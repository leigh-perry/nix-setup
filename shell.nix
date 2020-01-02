{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2019-11-25";
  # Commit hash for nixos-unstable as of 2019-11-25 - get from head (git log)
  url = https://github.com/nixos/nixpkgs/archive/aa7efea848f5f936a86ea3c4dcd582df0b57699d.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "16wzghfxl9a4lvmvhxy6vgkdvb3b77dr9avbzzgfgxp2bcafbavb";
}) {};

let
  dummy = dummy;
in
  stdenv.mkDerivation rec {
    name = "Shell";

    buildInputs = [
      #figlet
      # TODO debug credentials for git
      # git
      gettext
      tmux
      jq
      tree
      shellcheck

      #docker
      #docker-compose
    ];

    # TODO set up proxy here
    shellHook = ''

      # in .zshrc:
      #
      # if [[ ! -z <DOLLAR>{LPZSH_AWS_COMPLETER} ]]; then
      #   echo Enabling awscli completion
      #   source <DOLLAR>{LPZSH_AWS_COMPLETER}
      # fi
      export LPZSH_AWS_COMPLETER="${awscli}/share/zsh/site-functions/aws_zsh_completer.sh"

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
      export LPZSH_DOCKER=${docker}/share/zsh/site-functions
      export LPZSH_DOCKER_COMPOSE=${docker-compose}/share/bash-completion/completions

      #figlet -w 160 "${name}"
      zsh
    '';
  }
