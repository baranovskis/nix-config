{
  config,
  lib,
  pkgs,
  username,
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

      # Enable autologin without locking after login
      autoLogin = {
        enable = true;
        user = username;
      };
    };

    # Prevent automatic lock after autologin
    xserver.displayManager.gdm.autoLogin.delay = 0;

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
