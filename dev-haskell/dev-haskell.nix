{ pkgs ? import <nixpkgs> {} }:
with pkgs;

stdenv.mkDerivation rec {
  name = "dev-haskell";

  buildInputs = [
    git
    gettext
    tmux
    jq
    shellcheck
    figlet

    ghc
    cabal-install
    stack
    hlint
    haskellPackages.hindent
    haskellPackages.ghcid
    cabal2nix
  ];

  shellHook = ''
    figlet -w 160 "${name}"
    zsh
  '';
}
