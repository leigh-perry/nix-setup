let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2021-01-27";
        # Commit hash for nixos-unstable as of 2021-01-27 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/891f607d5301d6730cb1f9dcf3618bcb1ab7f10e.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "1cr39f0sbr0h5d83dv1q34mcpwnkwwbdk5fqlyqp2mnxghzwssng";
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
