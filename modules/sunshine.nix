{
  config,
  lib,
  username,
  ...
}: let
  cfg = config.modules.sunshine;
in {
  options.modules.sunshine = {
    enable = lib.mkEnableOption "Sunshine game streaming server";
  };

  config = lib.mkIf cfg.enable {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };

    users.users.${username}.extraGroups = [ "video" "render" "input" ];
  };
}
