{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  # AMD Radeon Pro WX 5100 - VFIO Passthrough Configuration
  # This GPU is dedicated for VM passthrough only

  # Bind Radeon GPU to VFIO at boot (prevent amdgpu from claiming it)
  boot.kernelParams = [
    "vfio-pci.ids=1002:67c7,1002:aaf0"
  ];

  # Enable runtime power management to prevent overheating when GPU is idle
  services.udev.extraRules = ''
    # AMD Radeon WX 5100 - Enable runtime PM for power savings when not in use by VM
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1002", ATTR{device}=="0x67c7", ATTR{power/control}="auto"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x1002", ATTR{device}=="0xaaf0", ATTR{power/control}="auto"
  '';
}
