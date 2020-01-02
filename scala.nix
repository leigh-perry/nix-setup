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
