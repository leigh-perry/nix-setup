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
in
  pkgs.stdenv.mkDerivation rec {
    name = "Shell";

    buildInputs = [
      #figlet
      pkgs.gettext
      #pkgs.tmux
      pkgs.jq
      pkgs.yq
      pkgs.tree
      pkgs.shellcheck
      pkgs.watch
      pkgs.ripgrep
      #pkgs.bat
      pkgs.fzf
      pkgs.fd
      pkgs.gron
      pkgs.htop
      pkgs.direnv

      pkgs.neovim

      #pkgs.cntlm

      pkgs.docker
      pkgs.docker-compose
      pkgs.dive
    ];

    # TODO set up proxy here
    shellHook = ''

      # TODO docker-compose completion not working
      # in .zshrc:
      #
      # if [[ ! -z <DOLLAR>{LPZSH_DOCKER} ]]; then
      #   echo Enabling docker and docker-compose completion
      #   fpath=(<DOLLAR>{LPZSH_DOCKER} <DOLLAR>fpath)
      #   autoload compinit && compinit -i
      #
      #   source <DOLLAR>{LPZSH_DOCKER_COMPOSE}/docker-compose
      # fi
      export LPZSH_DOCKER=${pkgs.docker}/share/zsh/site-functions
      export LPZSH_DOCKER_COMPOSE=${pkgs.docker-compose}/share/bash-completion/completions

      #figlet -w 160 "${name}"
      #zsh
    '';
  }
