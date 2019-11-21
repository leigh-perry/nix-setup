{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2019-11-10";
  # Commit hash for nixos-unstable as of 11 Nov 2019
  url = https://github.com/nixos/nixpkgs/archive/bef773ed53f3d535792d7d7ff3ea50a3deeb1cdd.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "0jhkh6gjdfwk398lkmzb16dgg6h6xyq5l7bh3sa3iw46byfk5i16";
}) {};

let

  pkgs = import <nixpkgs> { overlays = [ (self: super: {
    jdk = jdk8;
    jre = jdk8;
  }) ]; }; 

  # Docker brings in python37, so use that to avoid clash
  local-awscli = awscli.override { python = python37; };

  #sbt-jdk8 = sbt.override { jre = jdk8; };
in

stdenv.mkDerivation rec {
  name = "dev-spark";

  buildInputs = [
    # TODO debug credentials for git
    # git
    gettext
    tmux
    jq
    shellcheck
    figlet

    jdk8
    sbt
    scala_2_11
    gradle
    maven

    local-awscli
    terraform_0_12

    docker
    docker-compose
  ];

  # TODO layer on top of dev-scala
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

    figlet -w 160 "${name}"
    zsh
  '';
}
