{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.solaar.nixosModules.default
  ];

  config = lib.mkIf config.profiles.desktop.enable {
    services.solaar = {
      enable = true;
      package = pkgs.solaar;
      window = "hide";
      batteryIcons = "symbolic";
      extraArgs = "";
    };

    environment.systemPackages = with pkgs; [
      gnomeExtensions.solaar-extension
    ];
  };
}
