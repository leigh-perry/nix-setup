{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2020-02-02";
  # Commit hash for nixos-unstable as of 2020-02-02 - get from head (git log)
  url = https://github.com/nixos/nixpkgs/archive/7870644286e1ba555cbe65932fa8ac7f596b6efa.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "0jsa055gs1kgxj2xf4bf462l0p4g87p7d9i68718b654h1chy2pb";
}) {};

let
  input-ghc = ghc;
  input-cabal-install = cabal-install;
  input-stack = stack;
  input-hlint = hlint;
  input-hindent = haskell.lib.justStaticExecutables haskellPackages.hindent;
  input-ghcid = haskell.lib.justStaticExecutables haskellPackages.ghcid;
  input-cabal2nix = cabal2nix;
  pointfree = haskell.lib.justStaticExecutables haskellPackages.pointfree;
  pointful = haskell.lib.justStaticExecutables haskellPackages.pointful;
in
  stdenv.mkDerivation rec {
    name = "Haskell";
  
    buildInputs = [
      #figlet

      # NOTE: in `all-packages.nix`:
      # cabal-install = haskell.lib.justStaticExecutables haskellPackages.cabal-install;
      # stack = haskell.lib.justStaticExecutables haskellPackages.stack;
      # hlint = haskell.lib.justStaticExecutables haskellPackages.hlint;
  
      input-ghc
      input-cabal-install
      #input-stack  # thank you mojave
      input-hlint
      input-hindent
      input-ghcid
      input-cabal2nix

      pointfree
      #pointful
    ];
  
    shellHook = ''
      #figlet -w 160 "${name}"
    '';
  }
