let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2022-01-03";
        # Commit hash for nixos-unstable as of 2022-01-27 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/bfd901466794ecaba6614357816b0aa1fe70b7bf.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "18rj7fpb90ijb78fgc7mmrizsznhragm43k9192y5ddpbx1q8kxa";
      }
    ) {
    };

  postgres = pkgs.postgresql;
in
  pkgs.stdenv.mkDerivation rec {
    name = "GCP";

    buildInputs = [
      #figlet
      postgres
    ];

    shellHook = ''

      #figlet -w 160 "${name}"
    '';
  }
