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
in
  pkgs.stdenv.mkDerivation rec {
    name = "Shell";

    buildInputs = [
      #figlet
      pkgs.gettext
      #pkgs.tmux
      pkgs.jq
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
      pkgs.just

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
