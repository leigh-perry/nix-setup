{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2020-05-08";
  # Commit hash for nixos-unstable as of 2020-05-08 - get from head (git log)
  url = https://github.com/nixos/nixpkgs/archive/d78ba41a5604c8e06d40756a2436e52169354d36.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "0bk81ddx1iq8i0nhg1i44kllihphyzhbc416zgylli0ycphknrkv";}) {};

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
