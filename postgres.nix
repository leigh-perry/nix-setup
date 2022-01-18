let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2021-09-31";
        # Commit hash for nixos-unstable as of 2021-09-31 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/39ab62f8f644c1a076cdba8de12baf15142cfe59.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "1n9gf65cvd0i14ricnz55j1cr5mwvajg6678342fm738xid9fv08";
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
