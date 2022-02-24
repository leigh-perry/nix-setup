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

  local-awscli = pkgs.awscli;    # awscli.override { python = python37; };
in
  pkgs.stdenv.mkDerivation rec {
    name = "AWS";

    buildInputs = [
      #figlet
      local-awscli
      pkgs.amazon-ecs-cli
    ];

    shellHook = ''

      # in .zshrc:
      #
      # if [[ ! -z <DOLLAR>{LPZSH_AWS_COMPLETER} ]]; then
      #   echo Enabling AWS CLI completion
      #   source <DOLLAR>{LPZSH_AWS_COMPLETER}
      # fi
      export LPZSH_AWS_COMPLETER="${local-awscli}/share/zsh/site-functions/aws_zsh_completer.sh"

      #figlet -w 160 "${name}"
    '';
  }
