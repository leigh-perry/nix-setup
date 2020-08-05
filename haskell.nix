let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2020-05-08";
        # Commit hash for nixos-unstable as of 2020-08-05 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/aa7efea848f5f936a86ea3c4dcd582df0b57699d.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "16wzghfxl9a4lvmvhxy6vgkdvb3b77dr9avbzzgfgxp2bcafbavb";
      }
    ) {
    };

  input-ghc = pkgs.ghc;
  input-cabal-install = pkgs.cabal-install;
  input-stack = pkgs.stack;
  input-hlint = pkgs.hlint;

  haskell = pkgs.haskell;
  haskellPackages = pkgs.haskellPackages;
  input-hindent = haskell.lib.justStaticExecutables haskellPackages.hindent;
  input-ghcid = haskell.lib.justStaticExecutables haskellPackages.ghcid;
  input-cabal2nix = pkgs.cabal2nix;
  pointfree = haskell.lib.justStaticExecutables haskellPackages.pointfree;
  pointful = haskell.lib.justStaticExecutables haskellPackages.pointful;
in
  pkgs.stdenv.mkDerivation rec {
    name = "Haskell";
  
    buildInputs = [
      #figlet

      # NOTE: in `all-packages.nix`:
      # cabal-install = haskell.lib.justStaticExecutables haskellPackages.cabal-install;
      # stack = haskell.lib.justStaticExecutables haskellPackages.stack;
      # hlint = haskell.lib.justStaticExecutables haskellPackages.hlint;
  
      input-ghc
      input-cabal-install
      #input-stack  # thank you mojave
      input-hlint
      input-hindent
      input-ghcid
      input-cabal2nix

      pointfree
      #pointful
    ];
  
    shellHook = ''
      #figlet -w 160 "${name}"
    '';
  }
