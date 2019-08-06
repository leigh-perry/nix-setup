{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let
  cfg = (import ../jdk/jdk11.nix);
  jdk-name = cfg.jdk-name;
  jdk-sha = cfg.jdk-sha;
in

stdenv.mkDerivation rec {
  name = "dev-scala";

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
    git
    gettext
    tmux
    jq
    shellcheck
    figlet

    local-jdk11
    sbt-jdk11
    nodejs
  ];

  shellHook = ''
    figlet -w 160 "${name}"
    zsh
  '';
}
