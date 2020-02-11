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
  use-jdk = jdk8;
  pkgs = import <nixpkgs> { overlays = [ (self: super: {
    jdk = use-jdk;
    jre = use-jdk;
  }) ]; }; 
  gcptools = google-cloud-sdk;
in
  stdenv.mkDerivation rec {
    name = "Dataflow";

    buildInputs = [
      #figlet
      use-jdk
      sbt
      bloop
      ammonite
      gradle
      maven

      gcptools
    ];

    shellHook = ''
      #figlet -w 160 "${name}"
    '';
  }
