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
  use-jdk = jdk11;   # callPackage jdk/shared-jdk.nix { inherit jdk-name; inherit jdk-sha; };
  pkgs = import <nixpkgs> { overlays = [ (self: super: {
    jdk = use-jdk;
    jre = use-jdk;
  }) ]; }; 
  # cfg = (import jdk/jdk11.nix);
  # jdk-name = cfg.jdk-name;
  # jdk-sha = cfg.jdk-sha;
in
  stdenv.mkDerivation rec {
    name = "Scala";

    buildInputs = [
      #figlet
      use-jdk
      sbt
      bloop
      ammonite
      gradle
      maven

      # For ci-release / travis / mavencentral / sonatype
      gnupg
      
      # For scalajs
      nodejs

      # For docusaurus
      yarn
    ];

    shellHook = ''
      #figlet -w 160 "${name}"
    '';
  }
