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
