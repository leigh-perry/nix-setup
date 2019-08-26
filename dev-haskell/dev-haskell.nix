{ nixpkgs ? import <nixpkgs> {} }:
with nixpkgs;

# https://docs.haskellstack.org/en/stable/install_and_upgrade/
# 
# After installation, running stack setup might fail with configure: error: cannot run C compiled programs. in which case you should run:
# 
# xcode-select --install
#
# Starting with macOs 10.14 (Mojave) running xcode-select --install might not be enough. You will need to install additional headers by running:
# 
# cd /Library/Developer/CommandLineTools/Packages/
# open macOS_SDK_headers_for_macOS_10.14.pkg


# https://github.com/gvolpe/rate-limiter/blob/aedf240fd8e14937c20411dcd0c62a5208cf5528/default.nix
let
  hp = nixpkgs.haskellPackages.override {
    overrides =
      self: super: with nixpkgs.haskell.lib; {

        # transient = super.callHackage "transient" "0.6.3" {};

        # original for "transient" in nixpkgs is:

        #   "transient" = callPackage
        #     ({ mkDerivation, atomic-primops, base, bytestring, containers
        #      , directory, mtl, primitive, random, stm, time, transformers
        #      }:
        #      mkDerivation {
        #        pname = "transient";
        #        version = "0.6.3";
        #        sha256 = "02zy60hilgagxa08j7bvd35wkpap5dzffc5af258hxiy0gdpdw0a";
        #        libraryHaskellDepends = [
        #          atomic-primops base bytestring containers directory mtl primitive
        #          random stm time transformers
        #        ];
        #        testHaskellDepends = [
        #          atomic-primops base bytestring containers directory mtl random stm
        #          time transformers
        #        ];
        #        description = "composing programs with multithreading, events and distributed computing";
        #        license = stdenv.lib.licenses.mit;
        #        hydraPlatforms = stdenv.lib.platforms.none;
        #        broken = true;
        #      }) {};

      };
  };
in
  stdenv.mkDerivation rec {
    name = "dev-haskell";

    buildInputs = [
      git
      gettext
      tmux
      jq
      shellcheck
      figlet

      ghc
      cabal-install
      stack
      hlint
      hp.hindent
      hp.ghcid
      cabal2nix
      hp.hakyll
    ];

    shellHook = ''
      figlet -w 160 "${name}"
      zsh
    '';
  }
