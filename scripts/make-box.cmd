SET VM_name=%1
SET VM_path=%2
SET VM_HD_path=%3
SET iso=%~dp0\..\build\arch-m59-dev-x64.iso
SET ctl="SATA Controller"
SET /A cpus=%NUMBER_OF_PROCESSORS% / 2

VBoxManage createvm --name %VM_name% --register --basefolder %VM_path%
VBoxManage createhd --filename %VM_HD_path% --size 100000 --format VDI --variant Standard
VBoxManage storagectl %VM_name% --name %ctl% --add sata
VBoxManage storageattach %VM_name% --storagectl %ctl% --port 0 --device 0 --type hdd --medium %VM_HD_path%
VBoxManage storageattach %VM_name% --storagectl %ctl% --port 1 --device 0 --type dvddrive --medium emptydrive
VBoxManage modifyvm %VM_name% ^
  --nic1 bridged ^
  --cableconnected1 on ^
  --bridgeadapter1 eth0 ^
  --memory 2000 ^
  --ioapic on ^
  --cpus %cpus% ^
  --clipboard bidirectional ^
  --draganddrop bidirectional ^
  --vram 16 ^
  --accelerate3d on
