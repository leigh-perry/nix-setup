{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2020-02-24";
  # Commit hash for nixos-unstable as of 2020-02-24 - get from head (git log)
  url = https://github.com/nixos/nixpkgs/archive/dc436efc90cf604d533e682da4a82cad3a0a7aaf.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "1wizx2x3qrq54fs6gd7ngmdzf6577g8vwpmzhzaci8fh0fmrdpkb";
}) {};

let
  dummy = dummy;
in
  stdenv.mkDerivation rec {
    name = "Terraform";

    buildInputs = [
      #figlet
      terraform_0_12
    ];

    shellHook = ''
      #figlet -w 160 "${name}"
    '';
  }
