let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2023-08-11";
        # Commit hash for nixos-unstable as of 2023-08-11 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/51e7e7a385d5ff46f6215d93cbd7d290a00d1645.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "0kbngv3v0xvnx7g2xjx2fxgy99bp6ay3xsk7hrwx3z6gmh1hpbj9";
      }
    ) {
    };

  gcptools = pkgs.google-cloud-sdk;
in
  pkgs.stdenv.mkDerivation rec {
    name = "GCP";

    buildInputs = [
      pkgs.linkerd
    ];

    shellHook = ''
    '';
  }
