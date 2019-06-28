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
      # see https://mirror.bazel.build/openjdk/index.html
      inherit jdk-name;
      inherit jdk-sha;
    };

  buildInputs = [
    local-jdk11
    sbt
    jq
    figlet
  ];
}
