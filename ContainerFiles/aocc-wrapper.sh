#!/usr/bin/env bash
TOOL=$(basename "$0")
if [[ "$TOOL" == "aoc++" ]]; then
    REAL="/opt/AMD/aocc-compiler-6.0.0/bin/aoc_cpp.real"
else
    REAL="/opt/AMD/aocc-compiler-6.0.0/bin/aoc.real"
fi

filtered_args=()
for arg in "$@"; do
    if [[ "$arg" == "-Wa,--generate-missing-build-notes=yes" ]] || \
       [[ "$arg" == "-Wa,--noexecstack" ]] || \
       [[ "$arg" == "--config=/usr/lib/rpm/redhat/redhat-hardened-clang.cfg" ]]; then
        continue
    fi
    filtered_args+=("$arg")
done
exec "$REAL" "${filtered_args[@]}"
