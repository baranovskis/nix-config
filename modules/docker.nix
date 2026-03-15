{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  cfg = config.modules.docker;

  update-containers = pkgs.writeShellScriptBin "update-containers" ''
    images=$(${pkgs.docker}/bin/docker ps -a --format="{{.Image}}" | sort -u)

    echo "Found images to update:"
    echo "$images"

    for image in $images
    do
      echo "Pulling $image..."
      ${pkgs.docker}/bin/docker pull $image
    done

    echo "Container image updates complete!"
  '';
in {
  options.modules.docker = {
    enable = lib.mkEnableOption "Docker, Podman, and Distrobox";
  };

  config = lib.mkIf cfg.enable {
    virtualisation = {
      docker = {
        enable = true;
        autoPrune.enable = true;
        rootless = {
          enable = true;
          setSocketVariable = true;
        };
      };

      podman = {
        enable = true;
        autoPrune.enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };

      oci-containers.backend = "docker";
    };

    hardware.nvidia-container-toolkit.enable = true;

    environment.systemPackages = with pkgs; [
      lazydocker
      distrobox
      update-containers
    ];
  };
}
