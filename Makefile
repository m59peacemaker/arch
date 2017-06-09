image="pmkr/arch-iso-dev-env"
VM_name="ArchM59Dev"
VM_path="./tmp/vm"
VM_HD_path=${VM_path}/hdd.vdi

# windows only
vb:
	@.\scripts\make-box.cmd ${VM_name} ${VM_path} ${VM_HD_path}
clean-vb:
	@VBoxManage unregistervm ${VM_name} --delete \
    & VBoxManage closemedium disk ${VM_HD_path} --delete \
    & rmdir /s /q ${VM_path}

setup:
	@(cd docker; docker build -t ${image} .)

run=docker run -it --rm --net host -v `pwd`:/app --workdir /app --privileged ${image}
shell:
	@${run} /bin/bash

_build:
	@make clean; `cd live; ./build.sh -V dev -v`

build:
	@${run} make _build

clean:
	@rm -v ./tmp/build.make_*

.PHONY: vb clean-vb setup shell _build build clean
