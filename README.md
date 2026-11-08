Brontitall is a distrobox compatible container image; for development with AOCC (*AMD's Optimized C Compiler*).

*Vulkan* -- (*about 2.04GiB*)
```
podman pull ghcr.io/celestial-uprising/brontitall:latest

distrobox create -n brontitall -i ghcr.io/celestial-uprising/brontitall:latest

distrobox enter brotitall 
```

*CUDA* -- (*about 10.4GiB*)
```
podman pull ghcr.io/celestial-uprising/brontitall-nvidia:latest

distrobox create --nvidia -n brontitall-nv -i ghcr.io/celestial-uprising/brontitall-nvidia:latest

distrobox enter brontitall-nv
```
