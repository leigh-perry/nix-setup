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
  local-awscli = awscli;    # awscli.override { python = python37; };
in
  stdenv.mkDerivation rec {
    name = "AWS";

    buildInputs = [
      #figlet
      local-awscli
    ];

    shellHook = ''

      # in .zshrc:
      #
      # if [[ ! -z <DOLLAR>{LPZSH_AWS_COMPLETER} ]]; then
      #   echo Enabling AWS CLI completion
      #   source <DOLLAR>{LPZSH_AWS_COMPLETER}
      # fi
      export LPZSH_AWS_COMPLETER="${local-awscli}/share/zsh/site-functions/aws_zsh_completer.sh"

      #figlet -w 160 "${name}"
    '';
  }
