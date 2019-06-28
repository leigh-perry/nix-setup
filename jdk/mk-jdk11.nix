{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let
  cfg = (import ./jdk11.nix);
  jdk-name = cfg.jdk-name;
  jdk-sha = cfg.jdk-sha;
in 

stdenv.mkDerivation rec {
  name = "jdk-11";

  local-jdk11 =
    callPackage ./shared-jdk.nix {
      # see https://mirror.bazel.build/openjdk/index.html
      inherit jdk-name;
      inherit jdk-sha;
    };

  buildInputs = [
    local-jdk11
  ];
}
