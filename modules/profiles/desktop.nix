{
  config,
  lib,
  pkgs,
  inputs,
  username,
  ...
}: let
  cfg = config.profiles.desktop;

  zenExtension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };
in {
  imports = [
    inputs.solaar.nixosModules.default
  ];

  options.profiles.desktop = {
    enable = lib.mkEnableOption "desktop infrastructure (audio, bluetooth, printing, flatpak, peripherals)";
  };

  config = lib.mkIf cfg.enable {
    # PipeWire audio
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
    };

    users.users.${username}.extraGroups = [ "audio" ];

    # Bluetooth
    hardware.bluetooth = {
      enable = true;
      package = pkgs.bluez-experimental;
      powerOnBoot = true;
      settings = {
        LE = {
          MinConnectionInterval = 16;
          MaxConnectionInterval = 16;
          ConnectionLatency = 10;
          ConnectionSupervisionTimeout = 100;
        };
        Policy.AutoEnable = "true";
        General = {
          FastConnectable = true;
          JustWorksRepairing = "always";
          Experimental = true;
        };
      };
    };

    boot.extraModprobeConfig = ''
      options bluetooth enable_ecred=1
      options bluetooth enable_iso=1
    '';

    # Printing
    services.printing.enable = true;

    # Flatpak
    services.flatpak.enable = true;

    services.flatpak.remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    services.flatpak.update.onActivation = true;

    services.flatpak.update.auto = {
      enable = true;
      onCalendar = "*-*-* 0/6:00:00";
    };

    services.flatpak.packages = [
      "io.github.kolunmi.Bazaar"
      "com.github.tchx84.Flatseal"
      "io.github.flattool.Warehouse"
      "com.mattjakeman.ExtensionManager"
      "org.telegram.desktop"
      "com.bitwarden.desktop"
      "com.spotify.Client"
      "org.gimp.GIMP"
      "org.inkscape.Inkscape"
      "org.remmina.Remmina"
      "io.missioncenter.MissionCenter"
      "net.lutris.Lutris"
      "com.heroicgameslauncher.hgl"
      "com.usebottles.bottles"
      "com.jeffser.Alpaca"
      "dev.zed.Zed"
      "com.jetbrains.Toolbox"
      "io.podman_desktop.PodmanDesktop"
    ];

    # NuPhy keyboard — Fn+Super unblocks the Super key
    boot.kernelParams = [ "hid_apple.fnmode=0" ];

    # Logitech Solaar
    services.solaar = {
      enable = true;
      package = pkgs.solaar;
      window = "hide";
      batteryIcons = "symbolic";
      extraArgs = "";
    };

    # GnuPG
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
    services.pcscd.enable = true;

    environment.systemPackages = with pkgs; [
      gnomeExtensions.solaar-extension

      # Zen Browser
      (wrapFirefox
        inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
        {
          extraPrefs = lib.concatLines (
            lib.mapAttrsToList (
              name: value: ''lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});''
            ) {
              "extensions.autoDisableScopes" = 0;
              "extensions.pocket.enabled" = false;
            }
          );

          extraPolicies = {
            DisableTelemetry = true;
            ExtensionSettings = builtins.listToAttrs [
              (zenExtension "ublock-origin" "uBlock0@raymondhill.net")
            ];

            SearchEngines = {
              Default = "ddg";
              Add = [
                {
                  Name = "nixpkgs packages";
                  URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@np";
                }
                {
                  Name = "NixOS options";
                  URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@no";
                }
                {
                  Name = "NixOS Wiki";
                  URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                  IconURL = "https://wiki.nixos.org/favicon.ico";
                  Alias = "@nw";
                }
                {
                  Name = "noogle";
                  URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                  IconURL = "https://noogle.dev/favicon.ico";
                  Alias = "@ng";
                }
              ];
            };
          };
        }
      )
    ];
  };
}
