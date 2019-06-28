{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let
  cfg = (import ./jdk12.nix);
  jdk-name = cfg.jdk-name;
  jdk-sha = cfg.jdk-sha;
in 

stdenv.mkDerivation rec {
  name = "jdk-12";

  local-jdk12 =
    callPackage ./shared-jdk.nix {
      # see https://mirror.bazel.build/openjdk/index.html
      inherit jdk-name;
      inherit jdk-sha;
    };

  buildInputs = [
    local-jdk12
  ];
}
