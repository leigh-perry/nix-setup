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
