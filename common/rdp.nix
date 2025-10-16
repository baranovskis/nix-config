{pkgs, ...}: {
  # RDP (Remote Desktop Protocol) configuration
  services.xrdp = {
    enable = true;
    defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
    openFirewall = true;
  };
}
