{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let
  cfg = (import ../jdk/jdk11.nix);
  jdk-name = cfg.jdk-name;
  jdk-sha = cfg.jdk-sha;
in

stdenv.mkDerivation rec {
  name = "dev-haskell";

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
    ghc
    cabal-install
    stack
    haskellPackages.ghcid
    hlint
    haskellPackages.hindent
    cabal2nix
    jq
    figlet
  ];

  shellHook = ''
    figlet -w 160 "${name}"
    zsh
  '';
}
