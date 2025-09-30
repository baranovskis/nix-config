{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  # PCI addresses for AMD Radeon Pro WX 5100
  radeonGpuPci = "0000:06:00.0";
  radeonAudioPci = "0000:06:00.1";
  # Vendor:Device IDs
  radeonGpuId = "1002:67c7";
  radeonAudioId = "1002:aaf0";
in
{
  #hardware.amdgpu = {
    #amdvlk = true;
    #rocm = true;
  #};

  # Create the scripts directory
  systemd.tmpfiles.rules = [
    "d /etc/scripts 0755 root root -"
  ];

  # Radeon GPU passthrough scripts
  environment.etc."scripts/bind-radeon-gpu.sh" = {
    text = ''
      #!${pkgs.bash}/bin/bash
      set -e

      RADEON_GPU_PCI="${radeonGpuPci}"
      RADEON_AUDIO_PCI="${radeonAudioPci}"
      RADEON_GPU_ID="${radeonGpuId}"
      RADEON_AUDIO_ID="${radeonAudioId}"

      echo "Binding Radeon GPU to VFIO..."

      # Unbind from current drivers
      if [ -e /sys/bus/pci/devices/$RADEON_GPU_PCI/driver ]; then
        echo "$RADEON_GPU_PCI" > /sys/bus/pci/devices/$RADEON_GPU_PCI/driver/unbind
      fi
      if [ -e /sys/bus/pci/devices/$RADEON_AUDIO_PCI/driver ]; then
        echo "$RADEON_AUDIO_PCI" > /sys/bus/pci/devices/$RADEON_AUDIO_PCI/driver/unbind
      fi

      # Bind to vfio-pci directly (will auto-register IDs if needed)
      if [ ! -e /sys/bus/pci/devices/$RADEON_GPU_PCI/driver ]; then
        echo vfio-pci > /sys/bus/pci/devices/$RADEON_GPU_PCI/driver_override
        echo "$RADEON_GPU_PCI" > /sys/bus/pci/drivers_probe
      fi
      if [ ! -e /sys/bus/pci/devices/$RADEON_AUDIO_PCI/driver ]; then
        echo vfio-pci > /sys/bus/pci/devices/$RADEON_AUDIO_PCI/driver_override
        echo "$RADEON_AUDIO_PCI" > /sys/bus/pci/drivers_probe
      fi

      echo "Radeon GPU bound to VFIO successfully"
      echo "GPU: $RADEON_GPU_PCI"
      echo "Audio: $RADEON_AUDIO_PCI"
    '';
    mode = "0755";
  };

  environment.etc."scripts/unbind-radeon-gpu.sh" = {
    text = ''
      #!${pkgs.bash}/bin/bash
      set -e

      RADEON_GPU_PCI="${radeonGpuPci}"
      RADEON_AUDIO_PCI="${radeonAudioPci}"
      RADEON_GPU_ID="${radeonGpuId}"
      RADEON_AUDIO_ID="${radeonAudioId}"

      echo "Unbinding Radeon GPU from VFIO..."

      # Unbind from vfio-pci
      if [ -e /sys/bus/pci/devices/$RADEON_GPU_PCI/driver ]; then
        echo "$RADEON_GPU_PCI" > /sys/bus/pci/devices/$RADEON_GPU_PCI/driver/unbind
      fi
      if [ -e /sys/bus/pci/devices/$RADEON_AUDIO_PCI/driver ]; then
        echo "$RADEON_AUDIO_PCI" > /sys/bus/pci/devices/$RADEON_AUDIO_PCI/driver/unbind
      fi

      # Clear driver override
      echo "" > /sys/bus/pci/devices/$RADEON_GPU_PCI/driver_override
      echo "" > /sys/bus/pci/devices/$RADEON_AUDIO_PCI/driver_override

      # Bind back to original drivers explicitly
      if [ ! -e /sys/bus/pci/devices/$RADEON_GPU_PCI/driver ]; then
        echo "$RADEON_GPU_PCI" > /sys/bus/pci/drivers/amdgpu/bind 2>/dev/null || echo "$RADEON_GPU_PCI" > /sys/bus/pci/drivers_probe
      fi
      if [ ! -e /sys/bus/pci/devices/$RADEON_AUDIO_PCI/driver ]; then
        echo "$RADEON_AUDIO_PCI" > /sys/bus/pci/drivers_probe
      fi

      echo "Radeon GPU returned to host system"
      echo "GPU: $RADEON_GPU_PCI"
      echo "Audio: $RADEON_AUDIO_PCI"
    '';
    mode = "0755";
  };

  environment.etc."scripts/gpu-status.sh" = {
    text = ''
      #!${pkgs.bash}/bin/bash
      echo "=== GPU Status ==="
      echo "NVIDIA:"
      lspci -k | grep -A 3 -B 1 "NVIDIA"
      echo ""
      echo "Radeon:"
      lspci -k | grep -A 3 -B 1 "AMD"
      echo ""
      echo "VFIO bound devices:"
      ls /sys/bus/pci/drivers/vfio-pci/ | grep -v bind
    '';
    mode = "0755";
  };
}
