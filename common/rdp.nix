{
  config,
  lib,
  pkgs,
  ...
}:
{
  # GNOME Remote Desktop Configuration
  # Uses GNOME's built-in RDP server (gnome-remote-desktop)
  services.gnome.gnome-remote-desktop.enable = true;

  # Open firewall for RDP (port 3389)
  networking.firewall.allowedTCPPorts = [ 3389 ];

  # Disable sleep entirely for a desktop RDP server
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
