{
  config,
  lib,
  ...
}: {
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./flatpak.nix
    ./gnupg.nix
    ./nuphy.nix
    ./printing.nix
    ./solaar.nix
    ./zen-browser.nix
  ];

  options.profiles.desktop = {
    enable = lib.mkEnableOption "desktop infrastructure (audio, bluetooth, printing, flatpak, peripherals)";
  };
}
