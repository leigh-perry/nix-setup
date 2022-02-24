let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2022-01-03";
        # Commit hash for nixos-unstable as of 2022-01-27 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/bfd901466794ecaba6614357816b0aa1fe70b7bf.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "18rj7fpb90ijb78fgc7mmrizsznhragm43k9192y5ddpbx1q8kxa";
      }
    ) {
      overlays = [ (
        self: super: {
          jdk = use-jdk;
          jre = use-jdk;
        }
      ) ];
    };

  use-jdk = pkgs.jdk17;   # callPackage jdk/shared-jdk.nix { inherit jdk-name; inherit jdk-sha; };
in
  pkgs.stdenv.mkDerivation rec {
    name = "Scala";

  buildInputs = [
    pkgs.jdk
    pkgs.sbt
    pkgs.coursier
    pkgs.bloop
    pkgs.ammonite
    pkgs.gradle
    pkgs.maven
    pkgs.scala-cli

    # For ci-release / travis / mavencentral / sonatype
    pkgs.gnupg

    # For scalajs
    pkgs.nodejs

    # For docusaurus
    pkgs.yarn
  ];

    shellHook = ''
      #figlet -w 160 "${name}"
      export JAVA_HOME="${use-jdk.home}"
    '';
  }
