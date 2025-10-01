{
  config,
  lib,
  pkgs,
  ...
}:
{
  services = {
    desktopManager.gnome = {
      enable = true;
      extraGSettingsOverridePackages = [ pkgs.mutter ];
      extraGSettingsOverrides = ''
        [org.gnome.mutter]
        experimental-features=['scale-monitor-framebuffer']
      '';
    };

    # Enable RDP access for remote desktop
    gnome.gnome-remote-desktop.enable = true;

    # hosts/global/core/ssh.nix handles this
    gnome.gcr-ssh-agent.enable = false;

    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };

      # Set the custom session as default
      defaultSession = lib.mkForce "gnome";
    };

    # Configure keyboard layout for Wayland
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
      excludePackages = [ pkgs.xterm ];
    };

    udev.packages = with pkgs; [ gnome-settings-daemon ];
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-remote-desktop
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.appindicator
    gnomeExtensions.auto-accent-colour
    gnomeExtensions.blur-my-shell
    gnomeExtensions.color-picker
    gnomeExtensions.dash-in-panel
    gnomeExtensions.just-perfection
    gnomeExtensions.undecorate
    gnomeExtensions.vitals
    gnomeExtensions.caffeine
  ];

  ## Exclusions
  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-music
      gnome-photos
      gnome-tour
      gedit
      epiphany
      geary
      gnome-characters
      totem
      tali
      iagno
      hitori
      atomix
      gnome-system-monitor
    ]);
}
