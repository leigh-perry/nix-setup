{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let
  cfg = (import ./jdk11.nix);
  jdk-name = cfg.jdk-name;
  jdk-sha = cfg.jdk-sha;
in 

stdenv.mkDerivation rec {
  name = "jdk-11";

  use-jdk =
    callPackage ./shared-jdk.nix {
      inherit jdk-name;
      inherit jdk-sha;
    };

  buildInputs = [
    use-jdk
  ];
}
