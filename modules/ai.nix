{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.modules.ai;
in {
  options.modules.ai = {
    enable = lib.mkEnableOption "Ollama local LLM server";
  };

  config = lib.mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = "cuda";
    };

    environment.systemPackages = with pkgs; [
      ollama
    ];
  };
}
