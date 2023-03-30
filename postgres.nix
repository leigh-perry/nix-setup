let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2023-04-13";
        # Commit hash for nixos-unstable as of 2023-04-13 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/0c4800d579af4ed98ecc47d464a5e7b0870c4b1f.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "00gx09447gzgxlzwih4hdj51sdg62xanikkgr4bv4y7fpm98qirq";
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
