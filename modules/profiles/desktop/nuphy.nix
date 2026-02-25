{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.profiles.desktop.enable {
    # Fn+Super unblocks the Super key
    boot.kernelParams = [ "hid_apple.fnmode=0" ];
  };
}
