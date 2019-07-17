# TODO https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs
{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let
  cfg = (import ../jdk/jdk11.nix);
  jdk-name = cfg.jdk-name;
  jdk-sha = cfg.jdk-sha;
in

stdenv.mkDerivation rec {
  name = "dev-iag";

  local-jdk11 =
    callPackage ../jdk/shared-jdk.nix {
      inherit jdk-name;
      inherit jdk-sha;
    };

  sbt-jdk11 =
    sbt.override {
      jre = local-jdk11;
    };

  buildInputs = [
    # TODO debug credentials for git
    # git
    gettext
    tree
    local-jdk11
    sbt-jdk11
    maven
    confluent-platform
    awscli
    terraform_0_12
    docker
    docker-compose
    jq
    figlet
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
