{ pkgs ? import <nixpkgs> {} }:
with import (builtins.fetchTarball {
  # Descriptive name to make the store path easier to identify
  name = "nixos-unstable-2020-05-08";
  # Commit hash for nixos-unstable as of 2020-05-08 - get from head (git log)
  url = https://github.com/nixos/nixpkgs/archive/d78ba41a5604c8e06d40756a2436e52169354d36.tar.gz;
  # Hash obtained using `nix-prefetch-url --unpack <url>`
  sha256 = "0bk81ddx1iq8i0nhg1i44kllihphyzhbc416zgylli0ycphknrkv";
}) {
  config = {
    packageOverrides = pkgs: {
      jdk = pkgs.jdk11;
      jre = pkgs.jdk11;
    };
  };
};

stdenv.mkDerivation rec {
  name = "Scala";

  buildInputs = [
    jdk
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
      export JAVA_HOME="${jdk.home}"
    '';
  }
