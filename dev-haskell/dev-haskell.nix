{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2019-10-04";
  # Commit hash for nixos-unstable as of Mon Sep 2 01:17:20 2019 -0400
  url = https://github.com/nixos/nixpkgs/archive/85b7d89892a4ea088d541a694addb2e363758e44.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "0wxv4jvv9gri8kjzijrxdd1ijprwbsgsnzmjk2n4yxi0j41jk2f6";
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
      input-stack  # thank you mojave
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
