{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2019-11-10";
  # Commit hash for nixos-unstable as of 11 Nov 2019
  url = https://github.com/nixos/nixpkgs/archive/bef773ed53f3d535792d7d7ff3ea50a3deeb1cdd.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "0jhkh6gjdfwk398lkmzb16dgg6h6xyq5l7bh3sa3iw46byfk5i16";
}) {};

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
      tree
      shellcheck
      figlet

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
    ];
  
    shellHook = ''
      figlet -w 160 "${name}"
      zsh
    '';
  }
