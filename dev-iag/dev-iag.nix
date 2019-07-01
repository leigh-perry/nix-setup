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

  buildInputs = [
    git
    gettext
    local-jdk11
    sbt
    awscli
    terraform_0_12
    jq
    figlet
  ];

  # TODO layer on top of dev-scala
  # TODO set up proxy here
  shellHook = ''
    mkdir -p ~/links

    # support intellij sdk location
    unlink ~/links/jdk11
    ln -s ${local-jdk11}/ ~/links/jdk11

    # TODO find way of overriding sbt jdk at system level
    #export SBT_OPTS="-java-home ~/links/jdk11"

    export AWS_COMPLETER="${awscli}/share/zsh/site-functions/aws_zsh_completer.sh"

    figlet -w 160 "${name}"
    zsh
  '';
}
