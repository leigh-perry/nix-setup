{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2019-11-25";
  # Commit hash for nixos-unstable as of 2019-11-25 - get from head (git log)
  url = https://github.com/nixos/nixpkgs/archive/aa7efea848f5f936a86ea3c4dcd582df0b57699d.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "16wzghfxl9a4lvmvhxy6vgkdvb3b77dr9avbzzgfgxp2bcafbavb";
}) {};

let
  local-awscli = awscli;    # awscli.override { python = python37; };
in
  stdenv.mkDerivation rec {
    name = "AWS";

    buildInputs = [
      #figlet
      local-awscli
    ];

    shellHook = ''
      #figlet -w 160 "${name}"
    '';
  }
