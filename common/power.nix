{ config, lib, pkgs, ... }:
{
  # Enable power management
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  # Desktop performance tuning
  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
  };

  # Disable systemd targets for sleep and hibernation
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # Disable wakeup for ALL USB and PCIe devices
  services.udev.extraRules = ''
    # Disable all USB device wakeup (prevents mouse/keyboard/any USB device from waking PC)
    ACTION=="add", SUBSYSTEM=="usb", ATTR{power/wakeup}="disabled"

    # Disable all PCIe port wakeup (prevents network cards, GPUs, NVMe, etc. from waking PC)
    ACTION=="add", SUBSYSTEM=="pci", ATTR{power/wakeup}="disabled"
  '';

  # Enable Wake-on-LAN for ethernet interface eno1  
  networking.interfaces.eno1.wakeOnLan.enable = true;
}
