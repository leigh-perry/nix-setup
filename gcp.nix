let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2022-01-03";
        # Commit hash for nixos-unstable as of 2022-01-03 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/59bfda72480496f32787cec8c557182738b1bd3f.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "18akd1chfvniq1q774rigfxgmxwi0wyjljpa1j9ls59szpzr316d";
      }
    ) {
    };

  gcptools = pkgs.google-cloud-sdk;
in
  pkgs.stdenv.mkDerivation rec {
    name = "GCP";

    buildInputs = [
      #figlet
      gcptools
      pkgs.kubernetes-helm
      pkgs.kubectl
      pkgs.kubectx
    ];

    shellHook = ''

      # in .zshrc:
      #
      # if [[ ! -z <DOLLAR>{LPZSH_GCP_COMPLETER} ]]; then
      #   echo Enabling GCP CLI completion
      #   source <DOLLAR>{LPZSH_GCP_COMPLETER}
      # fi
      export LPZSH_GCP_COMPLETER="${gcptools}/google-cloud-sdk/completion.zsh.inc"

      #figlet -w 160 "${name}"
    '';
  }
