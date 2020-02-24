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
