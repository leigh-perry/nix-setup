let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2021-02-28";
        # Commit hash for nixos-unstable as of 2021-02-28 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/f6b5bfdb470d60a876992749d0d708ed7b6b56ca.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "1rfsyz5axf2f7sc14wdm8dmb164xanbw7rcw6w127s0n6la17kq2";
      }
    ) {
    };

  gcptools = pkgs.google-cloud-sdk;
in
  pkgs.stdenv.mkDerivation rec {
    name = "Node.js";

    buildInputs = [
      pkgs.nodejs-14_x
      (pkgs.yarn.override { nodejs = pkgs.nodejs-14_x; })
    ];

    shellHook = ''
    '';
  }
