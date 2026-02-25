{ ... }: {
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
  };

  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{power/wakeup}="disabled"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{power/wakeup}="disabled"
  '';

  # Wake-on-LAN
  networking.interfaces.eno1.wakeOnLan.enable = true;
}
