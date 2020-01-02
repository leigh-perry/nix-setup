{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2019-11-25";
  # Commit hash for nixos-unstable as of 2019-11-25 - get from head (git log)
  url = https://github.com/nixos/nixpkgs/archive/091ddf2650952a5eda3d8e1b8adbf960c8b492b4.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "1mkq6y5wb9pbafvhfj720s29p8smdcrssz9qvvwshfzbjhaj4jal";
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
