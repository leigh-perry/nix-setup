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
