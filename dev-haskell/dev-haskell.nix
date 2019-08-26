{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let
  input-ghc = ghc;
  input-cabal-install = cabal-install;
  input-stack = stack;
  input-hlint = hlint;
  input-hindent = haskell.lib.justStaticExecutables haskellPackages.hindent;
  input-ghcid = haskell.lib.justStaticExecutables haskellPackages.ghcid;
  input-cabal2nix = cabal2nix;

in
  stdenv.mkDerivation rec {
    name = "dev-haskell";
  
    buildInputs = [
      #git
      gettext
      tmux
      jq
      shellcheck
      figlet

      # NOTE: in `all-packages.nix`:
      # cabal-install = haskell.lib.justStaticExecutables haskellPackages.cabal-install;
      # stack = haskell.lib.justStaticExecutables haskellPackages.stack;
      # hlint = haskell.lib.justStaticExecutables haskellPackages.hlint;
  
      input-ghc
      input-cabal-install
      input-stack
      input-hlint
      input-hindent
      input-ghcid
      input-cabal2nix
    ];
  
    shellHook = ''
      figlet -w 160 "${name}"
      zsh
    '';
  }
