let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2023-08-11";
        # Commit hash for nixos-unstable as of 2023-08-11 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/51e7e7a385d5ff46f6215d93cbd7d290a00d1645.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "0kbngv3v0xvnx7g2xjx2fxgy99bp6ay3xsk7hrwx3z6gmh1hpbj9";
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
#   pkgs.bloop
    pkgs.ammonite
    pkgs.gradle
    pkgs.maven
    pkgs.scala-cli
    
    pkgs.graphviz

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
