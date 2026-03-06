{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.wm.gnome;
  stylixSettings = import ../../lib/stylix.nix {inherit pkgs;};
in {
  options.modules.wm.gnome = {
    enable = lib.mkEnableOption "GNOME desktop environment";
  };

  config = lib.mkIf cfg.enable {
    stylix = stylixSettings // {
      image = ../../assets/wallpapers/wallhaven-lym7pl.jpg;
    };

    environment.sessionVariables = {
      # Improves NVIDIA Wayland performance
      MUTTER_DEBUG_KMS_THREAD_TYPE = "user";

      # https://gitlab.gnome.org/GNOME/sushi/-/issues/135#note_2500306
      GDK_GL = "gles";

    };

    services = {
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverridePackages = [ pkgs.mutter ];
        extraGSettingsOverrides = ''
          [org.gnome.mutter]
          experimental-features=['scale-monitor-framebuffer', 'xwayland-native-scaling', 'kms-modifiers', 'variable-refresh-rate']
        '';
      };

      gnome.gcr-ssh-agent.enable = false;

      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
        defaultSession = lib.mkForce "gnome";
      };

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
      papirus-icon-theme
      gnome-tweaks
      gnome-remote-desktop
      nautilus-open-any-terminal
      gnomeExtensions.logo-menu
      gnomeExtensions.alphabetical-app-grid
      gnomeExtensions.appindicator
      gnomeExtensions.auto-accent-colour
      gnomeExtensions.blur-my-shell
      gnomeExtensions.gsconnect
      gnomeExtensions.color-picker
      gnomeExtensions.dash-in-panel
      gnomeExtensions.just-perfection
      gnomeExtensions.undecorate
      gnomeExtensions.vitals
      gnomeExtensions.caffeine
      gnomeExtensions.user-themes
    ];

    environment.gnome.excludePackages = with pkgs; [
      gnome-software
      gnome-music
      gnome-photos
      gnome-tour
      gedit
      epiphany
      geary
      gnome-characters
      tali
      iagno
      hitori
      atomix
      gnome-system-monitor
      gnome-console
    ];
  };
}
