# Generated via dconf2nix: https://github.com/gvolpe/dconf2nix
{ lib, ... }:

with lib.hm.gvariant;

{
  dconf.settings = {
    "org/gnome/TextEditor" = lib.mkDefault {
      style-scheme = "stylix";
    };

    "org/gnome/desktop/input-sources" = lib.mkDefault {
      sources = [
        (mkTuple [
          "xkb"
          "us"
        ])
        (mkTuple [
          "xkb"
          "ru"
        ])
      ];
    };

    "org/gnome/desktop/wm/preferences" = lib.mkDefault {
      num-workspaces = 3;
    };

    "org/gnome/mutter" = {
      experimental-features = lib.mkDefault [ "scale-monitor-framebuffer" ];
    };

    #"org/gnome/settings-daemon/plugins/color" = lib.mkDefault {
    #  night-light-enabled = true;
    #  night-light-schedule-automatic = false;
    #  night-light-schedule-from = 19.0;
    #  night-light-temperature = (mkUint32 3892);
    #};

    "org/gnome/shell" = {
      disable-user-extensions = lib.mkForce false;
      enabled-extensions = lib.mkDefault [
        "AlphabeticalAppGrid@stuarthayhurst"
        "appindicatorsupport@rgcjonas.gmail.com"
        "auto-accent-colour@Wartybix"
        "blur-my-shell@aunetx"
        "color-picker@tuberry"
        "dash-in-panel@fthx"
        "just-perfection-desktop@just-perfection"
        "solaar-extension@sidevesh"
        "undecorate@sun.wxg@gmail.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "Vitals@CoreCoding.com"
        "caffeine@patapon.info"
      ];
      last-selected-power-profile = lib.mkDefault "performance";
    };

    "org/gnome/shell/extensions/alphabetical-app-grid" = lib.mkDefault {
      folder-order-position = "start";
    };

    "org/gnome/shell/extensions/appindicator" = lib.mkDefault {
      icon-brightness = 0.0;
      icon-contrast = 0.0;
      icon-opacity = 240;
      icon-saturation = 0.0;
      icon-size = 0;
      legacy-tray-enabled = true;
      tray-pos = "right";
    };

    "org/gnome/shell/extensions/auto-accent-colour" = lib.mkDefault {
      disable-cache = false;
      hide-indicator = true;
      highlight-mode = true;
    };

    "org/gnome/shell/extensions/blur-my-shell" = lib.mkDefault {
      hacks-level = 1;
      settings-version = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = lib.mkDefault {
      brightness = 1.0;
      sigma = 85;
    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = lib.mkDefault {
      blacklist = [
        "Plank"
        "com.desktop.ding"
        "Conky"
        ".gamescope-wrapped"
        "steam_app_*"
        ".virt-manager-wrapped"
      ];
      blur = true;
      dynamic-opacity = false;
      enable-all = true;
      opacity = 230;
      sigma = 85;
    };

    "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab" = lib.mkDefault {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = lib.mkDefault {
      blur = false;
      brightness = 1.0;
      override-background = true;
      pipeline = "pipeline_default_rounded";
      sigma = 85;
      static-blur = false;
      style-dash-to-dock = 0;
      unblur-in-overview = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-panel" = lib.mkDefault {
      blur-original-panel = false;
    };

    "org/gnome/shell/extensions/blur-my-shell/hidetopbar" = lib.mkDefault {
      compatibility = false;
    };

    "org/gnome/shell/extensions/blur-my-shell/lockscreen" = lib.mkDefault {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/overview" = lib.mkDefault {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = lib.mkDefault {
      brightness = 1.0;
      override-background = true;
      pipeline = "pipeline_default";
      sigma = 85;
      static-blur = false;
    };

    "org/gnome/shell/extensions/blur-my-shell/screenshot" = lib.mkDefault {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/color-picker" = lib.mkDefault {
      auto-copy = true;
      color-picker-shortcut = [ "<Control><Super>c" ];
      enable-format = true;
      enable-notify = false;
      enable-shortcut = true;
      enable-sound = false;
      notify-sound = mkUint32 1;
      notify-style = mkUint32 0;
    };

    "org/gnome/shell/extensions/dash-in-panel" = lib.mkDefault {
      button-margin = 6;
      center-dash = true;
      colored-dot = true;
      icon-size = 32;
      move-date = true;
      panel-height = 46;
      show-apps = false;
      show-dash = false;
      show-label = true;
    };

    "org/gnome/shell/extensions/just-perfection" = lib.mkDefault {
      accessibility-menu = true;
      activities-button = false;
      clock-menu = true;
      clock-menu-position = 2;
      dash = true;
      dash-app-running = true;
      dash-separator = false;
      keyboard-layout = true;
      max-displayed-search-results = 0;
      panel-in-overview = true;
      quick-settings = true;
      quick-settings-dark-mode = true;
      ripple-box = true;
      show-apps-button = false;
      support-notifier-showed-version = 34;
      support-notifier-type = 0;
      top-panel-position = 0;
      window-preview-close-button = true;
      workspace = false;
      workspace-switcher-size = 0;
      workspaces-in-app-grid = true;
    };

    "org/gnome/shell/extensions/user-theme" = lib.mkDefault {
      name = "Stylix";
    };

    "org/gnome/shell/extensions/vitals" = lib.mkDefault {
      alphabetize = true;
      fixed-widths = true;
      hide-icons = false;
      hide-zeros = true;
      icon-style = 1;
      include-static-gpu-info = true;
      include-static-info = true;
      menu-centered = false;
      position-in-panel = 2;
      show-fan = false;
      show-gpu = true;
      show-memory = true;
      show-network = true;
      show-processor = true;
      show-storage = true;
      show-system = true;
      show-temperature = true;
      show-voltage = false;
      use-higher-precision = false;
    };

    "org/gnome/shell/keybindings" = lib.mkDefault {
      toggle-overview = [ "<Super>" ];
    };

    "org/virt-manager/virt-manager/connections" = lib.mkDefault {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };

    "org/gtk/gtk4/settings/file-chooser" = lib.mkDefault {
      show-hidden = false;
    };

    "org/gtk/settings/file-chooser" = lib.mkDefault {
      show-hidden = false;
    };
  };

  # Add ZFS pool to GNOME Files sidebar
  gtk.gtk3.bookmarks = [
    "file:///tank Tank"
  ];
}
