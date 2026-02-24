{
  config,
  lib,
  pkgs,
  username,
  ...
}:
{
  # GNOME-specific environment variables for better performance
  environment.sessionVariables = {
    # Use user-space threading for KMS (improves NVIDIA Wayland performance)
    MUTTER_DEBUG_KMS_THREAD_TYPE = "user";

    # Fix .org.gnome.Naut[13490]: Failed to initialize OpenGL with Gtk
    # https://gitlab.gnome.org/GNOME/sushi/-/issues/135#note_2500306
    GDK_GL = "gles";

    # Nautilus Audio/Video Properties: Your GStreamer installation is missing a plug-in.
    # https://github.com/NixOS/nixpkgs/issues/195936#issuecomment-1278954466
    GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
      pkgs.gst_all_1.gst-plugins-good
      pkgs.gst_all_1.gst-plugins-bad
      pkgs.gst_all_1.gst-plugins-ugly
      pkgs.gst_all_1.gst-libav
    ];
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

    # Disable GNOME's SSH agent (using standard SSH agent from common/ssh.nix)
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
    gnomeExtensions.logo-menu
    gnomeExtensions.pop-shell
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.appindicator
    gnomeExtensions.auto-accent-colour
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gsconnect # Mobile device integration (KDE Connect protocol)
    gnomeExtensions.color-picker
    gnomeExtensions.dash-in-panel
    gnomeExtensions.just-perfection
    gnomeExtensions.undecorate
    gnomeExtensions.vitals
    gnomeExtensions.caffeine
    gnomeExtensions.user-themes
  ];

  ## Exclusions
  environment.gnome.excludePackages =
    (with pkgs; [
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
    ]);
}
