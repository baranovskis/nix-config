{ inputs, ... }:
let
  linuxModifications = final: prev: {
  };

  modifications = final: prev: {
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (final.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      inherit (final.stdenv.hostPlatform) system;
      config.allowUnfree = true;
    };
  };

  claude-code-overlay = inputs.claude-code.overlays.default;

in
{
  default =
    final: prev:

    (modifications final prev)
    // (linuxModifications final prev)
    // (stable-packages final prev)
    // (unstable-packages final prev)
    // (claude-code-overlay final prev);
}
