{
  config,
  lib,
  username,
  ...
}: {
  config = lib.mkIf config.profiles.desktop.enable {
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
  };
}
