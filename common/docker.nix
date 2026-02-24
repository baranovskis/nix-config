# Container-focused development — Docker + Podman + Distrobox
#
# Docker: primary runtime for OCI containers and docker-compose workflows
# Podman: rootless containers, daemonless, used by Distrobox
# Distrobox: interactive pet containers for tools that need a mutable Linux env
{ pkgs, username, ... }:
let
  update-containers = pkgs.writeShellScriptBin "update-containers" ''
    SUDO=""
    if [[ $(id -u) -ne 0 ]]; then
      SUDO="sudo"
    fi

    # Get all unique images from running and stopped containers
    images=$($SUDO ${pkgs.docker}/bin/docker ps -a --format="{{.Image}}" | sort -u)

    echo "Found images to update:"
    echo "$images"

    for image in $images
    do
      echo "Pulling $image..."
      $SUDO ${pkgs.docker}/bin/docker pull $image
    done

    echo "Container image updates complete!"
  '';
in
{
  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
    };

    # Podman for rootless containers and Distrobox
    podman = {
      enable = true;
      autoPrune.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };

    oci-containers.backend = "docker";
  };

  environment.systemPackages = with pkgs; [
    lazydocker # Docker TUI
    distrobox # Pet containers from any distro image
    update-containers
  ];

  users.users.${username} = {
    extraGroups = [ "docker" ];
  };
}
