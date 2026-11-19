#!/usr/bin/env bash
set -e

# Force modern CMake to tolerate older policy requirements
export CMAKE_POLICY_VERSION_MINIMUM=3.5

BUILD_DIR="${HOME}/src/research/heartofgold/build"
mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}

dnf download --source --releasever=44 --destdir ${BUILD_DIR} \
    openssl \
    zstd \
    zlib-ng \
    lz4 \
    x264 \
    x265 \
    ffmpeg

rebuild_srpm() {
    local pkg_name=$1
    local srpm=$(ls ${pkg_name}-*.src.rpm 2>/dev/null | head -n 1)
    if [ -z "${srpm}" ]; then
        echo "Error: Source RPM matching '${pkg_name}-*.src.rpm' not found!"
        exit 1
    fi

    sudo dnf builddep -y ${srpm}

    local rpm_arch_dir=$(rpm --eval '%{_arch}')
    local rpm_noarch_dir="noarch"
    local build_root=$(rpm --eval '%{_topdir}')

    if [ "${pkg_name}" = "x265" ]; then
        # Unpack SRPM to edit its spec file and patch CMake files
        rpm -i ${srpm}
        local spec_file=$(ls ${build_root}/SPECS/x265*.spec)
        
        # 1. Fix CMake policies for CMake 4.x compatibility
        sed -i '/%autosetup/a find . -name "CMakeLists.txt" -exec sed -i "s/cmake_policy(SET CMP0025 OLD)/cmake_policy(SET CMP0025 NEW)/g" {} +' ${spec_file}
        sed -i '/%autosetup/a find . -name "CMakeLists.txt" -exec sed -i "s/cmake_policy(SET CMP0054 OLD)/cmake_policy(SET CMP0054 NEW)/g" {} +' ${spec_file}
        
        # 2. Directly append math library linking to TestBench
        sed -i '/%autosetup/a echo "target_link_libraries(TestBench m)" >> source/test/CMakeLists.txt' ${spec_file}

        rpmbuild -ba --nocheck ${spec_file}
    else
        rpmbuild --rebuild --nocheck ${srpm}
    fi

    sudo dnf install -y ${build_root}/RPMS/${rpm_arch_dir}/${pkg_name}-*.rpm ${build_root}/RPMS/${rpm_noarch_dir}/${pkg_name}-*.rpm || true
}

rebuild_srpm zlib-ng
rebuild_srpm lz4
rebuild_srpm zstd
rebuild_srpm openssl
rebuild_srpm x264
rebuild_srpm x265
rebuild_srpm ffmpeg

sudo ldconfig
