Distrobox compatible container images; for building AggroLlama & AggroWhisper with Clang or AOCC (*AMD's Optimized C Compiler*).

**AOCC Infused**

*Vulkan* -- (*about 2.04GiB*)
```
IMAGE="ghcr.io/celestial-uprising/brontitall:latest"

distrobox create -n brontitall -i ${IMAGE}

distrobox enter brontitall 
```

*CUDA* -- (*about 10.4GiB*)
```
IMAGE="ghcr.io/celestial-uprising/brequinda:latest"

distrobox create --nvidia -n brequinda -i ${IMAGE}

distrobox enter brequinda
```


**Clang Infused**

*Vulkan* -- (*about *)
```
IMAGE="ghcr.io/celestial-uprising/bartledan:latest"

distrobox create -n bartledan -i ${IMAGE}

distrobox enter bartledan
```

*CUDA* -- (*about *)
```
IMAGE="ghcr.io/celestial-uprising/bethselamin:latest"

distrobox create --nvidia -n bethselamin -i ${IMAGE}

distrobox enter bethselamin
```
