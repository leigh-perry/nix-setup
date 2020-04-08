{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2020-02-24";
  # Commit hash for nixos-unstable as of 2020-02-24 - get from head (git log)
  url = https://github.com/nixos/nixpkgs/archive/069f62de77c5e1887159f560cee0ebab05e752c1.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack https://github.com/nixos/nixpkgs/archive/069f62de77c5e1887159f560cee0ebab05e752c1.tar.gz`
  sha256 = "0ck6mb6iaaw4fi1gy5nxsl68r5vx523b2zbjx2xrh302h82jwvbl";
}) {};

let
  select_plugins = p: [ p.google p.google-beta p.null ];
  app_terraform = { full = pkgs.terraform.withPlugins select_plugins; };
  app_terragrunt = pkgs.terragrunt.override { terraform = app_terraform; };
in
  stdenv.mkDerivation rec {
    name = "Terraform";

    buildInputs = [
      #figlet
      terraform_0_12
      app_terragrunt
    ];

    shellHook = ''
      #figlet -w 160 "${name}"
    '';
  }
