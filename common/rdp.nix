{
  config,
  lib,
  pkgs,
  ...
}:
{
  # RDP Remote Desktop Configuration
  # Hybrid setup: Local sessions use Wayland, RDP sessions use X11
  services = {
    # xrdp - allows RDP login at login screen (before user session starts)
    xrdp.enable = true;
    xrdp.defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
    xrdp.openFirewall = true;
  };

  # Configure xrdp to use X11 GNOME session
  # This creates isolated X11 sessions for RDP, separate from local Wayland sessions
  environment.etc."xrdp/startwm.sh" = {
    text = ''
      #!/bin/sh
      # Force X11 for XRDP sessions (XRDP doesn't support Wayland)
      unset WAYLAND_DISPLAY
      export XDG_SESSION_TYPE=x11
      export GDK_BACKEND=x11
      export QT_QPA_PLATFORM=xcb

      # Prevent conflicts with local sessions
      export XDG_SESSION_CLASS=user
      export XDG_SESSION_DESKTOP=gnome

      # Start GNOME session
      exec ${pkgs.gnome-session}/bin/gnome-session
    '';
    mode = "0755";
  };

  # Disable sleep entirely for a desktop RDP server
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
