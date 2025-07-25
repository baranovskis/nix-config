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
        layout = "us,ru";
        variant = "";
      };
    };

    udev.packages = with pkgs; [ gnome-settings-daemon ];
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
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

  ## Exclusions ##
  environment.gnome.excludePackages = (
    with pkgs;
    [
      atomix
      baobab
      # epiphany
      # evince
      geary
      gedit
      #gnome-console
      gnome-contacts
      gnome-maps
      gnome-music
      gnome-photos
      gnome-terminal
      gnome-tour
      gnome-user-docs
      gnomeExtensions.applications-menu
      gnomeExtensions.launch-new-instance
      gnomeExtensions.light-style
      gnomeExtensions.places-status-indicator
      gnomeExtensions.status-icons
      gnomeExtensions.system-monitor
      gnomeExtensions.window-list
      gnomeExtensions.windownavigator
      hitori
      iagno
      simple-scan
      tali
      yelp
    ]
  );
}
