let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2020-05-08";
        # Commit hash for nixos-unstable as of 2020-05-08 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/d78ba41a5604c8e06d40756a2436e52169354d36.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "0bk81ddx1iq8i0nhg1i44kllihphyzhbc416zgylli0ycphknrkv";
      }
    ) {
    };
in
  pkgs.stdenv.mkDerivation rec {
    name = "Shell";

    buildInputs = [
      #figlet
      pkgs.gettext
      pkgs.tmux
      pkgs.jq
      pkgs.tree
      pkgs.shellcheck
      pkgs.watch
      pkgs.ripgrep
      pkgs.bat
      pkgs.fzf

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
