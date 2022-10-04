let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2022-06-23";
        # Commit hash for nixos-unstable as of 2022-06-23 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/e1e08fe28bf0588a41cd556eac40b98d2793da99.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "0abzal2gwzin9g7l4k2kll0hpjs3igacqq55k485fa4gb54s3f01";
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
    #pkgs.bloop
    pkgs.ammonite
    pkgs.gradle
    pkgs.maven
    #pkgs.scala-cli
    
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
