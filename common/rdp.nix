{pkgs, ...}: {
  # RDP (Remote Desktop Protocol) configuration
  services.xrdp = {
    enable = true;
    defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
    openFirewall = true;
  };

  # XRDP needs the GNOME remote desktop backend to function
  services.gnome.gnome-remote-desktop.enable = true;
}
