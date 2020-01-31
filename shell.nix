{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2019-11-25";
  # Commit hash for nixos-unstable as of 2019-11-25 - get from head (git log)
  url = https://github.com/nixos/nixpkgs/archive/091ddf2650952a5eda3d8e1b8adbf960c8b492b4.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "1mkq6y5wb9pbafvhfj720s29p8smdcrssz9qvvwshfzbjhaj4jal";
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

      cntlm

      docker
      docker-compose
      dive
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
      export LPZSH_DOCKER=${docker}/share/zsh/site-functions
      export LPZSH_DOCKER_COMPOSE=${docker-compose}/share/bash-completion/completions

      #figlet -w 160 "${name}"
      #zsh
    '';
  }
