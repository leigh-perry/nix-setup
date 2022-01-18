let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2022-01-03";
        # Commit hash for nixos-unstable as of 2022-01-03 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/59bfda72480496f32787cec8c557182738b1bd3f.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "18akd1chfvniq1q774rigfxgmxwi0wyjljpa1j9ls59szpzr316d";
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
