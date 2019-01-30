# Singularity Recipes for HPC Containers
This work intends to expand upon the reproducibility and mobility features of Singularity. Docker container images are built on the fly from intermediate layer images. If any of these layers change, the resulting built image may not be equivalent to earlier builds. This work provides a method of incorporating this 'anti-feature' with Singularity. However, the motivation is to allow 'layering' or 'stacking' of Singularity containers to re-use existing work and build container images quickly. The idea is sort of like 'inheritance' in OOP, thus expanding reusability, albeit at the cost of reproducibility.

[recipes](./recipes) contain Singularity definition files to build images which are available at the [Singularity Library](https://cloud.sylabs.io/library/verma).

[setup-singularity.sh](./setup-singularity.sh) installs Singularity in the location referenced in [common_dirs.sh](./common_dirs.sh).

[build-images.sh](./build-images.sh) provides examples of Singularity commands to build container images, and how the [definition files](./recipes) re-use existing containers and build progressively on top of them.
