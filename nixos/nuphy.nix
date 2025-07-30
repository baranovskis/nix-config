{ pkgs, ... }:
{
  # Remarks: Pressing Fn+Super unblocked the Super key
  boot.kernelParams = [ "hid_apple.fnmode=0" ];
}
