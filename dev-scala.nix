{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2019-10-04";
  # Commit hash for nixos-unstable as of Mon Sep 2 01:17:20 2019 -0400
  url = https://github.com/nixos/nixpkgs/archive/85b7d89892a4ea088d541a694addb2e363758e44.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "0wxv4jvv9gri8kjzijrxdd1ijprwbsgsnzmjk2n4yxi0j41jk2f6";
}) {};

let
  cfg = (import jdk/jdk11.nix);
  jdk-name = cfg.jdk-name;
  jdk-sha = cfg.jdk-sha;

  # Docker brings in python37, so use that to avoid clash
  local-awscli = awscli.override { python = python37; };

  local-jdk11 = callPackage jdk/shared-jdk.nix { inherit jdk-name; inherit jdk-sha; };

  sbt-jdk11 = sbt.override { jre = local-jdk11; };
in

stdenv.mkDerivation rec {
  name = "dev-scala";

  buildInputs = [
    # TODO debug credentials for git
    # git
    gettext
    tmux
    jq
    tree
    shellcheck
    figlet

    local-jdk11
    sbt-jdk11
    gradle
    maven

    local-awscli
    terraform_0_12

    #docker
    #docker-compose
    
    # For scalajs
    nodejs
  ];

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
