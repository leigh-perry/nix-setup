let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2020-05-08";
        # Commit hash for nixos-unstable as of 2020-05-08 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/d78ba41a5604c8e06d40756a2436e52169354d36.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "0bk81ddx1iq8i0nhg1i44kllihphyzhbc416zgylli0ycphknrkv";
      }
    ) {
      overlays = [ (
        self: super: {
          jdk = use-jdk;
          jre = use-jdk;
        }
      ) ];
    };

  use-jdk = pkgs.jdk14;   # callPackage jdk/shared-jdk.nix { inherit jdk-name; inherit jdk-sha; };
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
