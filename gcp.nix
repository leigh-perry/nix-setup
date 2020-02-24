{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2020-02-02";
  # Commit hash for nixos-unstable as of 2020-02-02 - get from head (git log)
  url = https://github.com/nixos/nixpkgs/archive/4928d8ca89261d4fbd1811324e402a6025c77574.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "12r432bp0lszczrdcliqfa32qa70fbv0fdq74fw55q0mibn9sg68";
}) {};

let
  gcptools = google-cloud-sdk;
in
  stdenv.mkDerivation rec {
    name = "GCP";

    buildInputs = [
      #figlet
      gcptools
    ];

    shellHook = ''

      # in .zshrc:
      #
      # if [[ ! -z <DOLLAR>{LPZSH_GCP_COMPLETER} ]]; then
      #   echo Enabling GCP CLI completion
      #   source <DOLLAR>{LPZSH_GCP_COMPLETER}
      # fi
      export LPZSH_GCP_COMPLETER="${gcptools}/google-cloud-sdk/completion.zsh.inc"

      #figlet -w 160 "${name}"
    '';
  }
