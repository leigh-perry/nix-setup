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
    };

  select_plugins = p: [ p.google p.google-beta p.null ];
  app_terraform = { full = pkgs.terraform.withPlugins select_plugins; };
  app_terragrunt = pkgs.terragrunt;
in
  pkgs.stdenv.mkDerivation rec {
    name = "Terraform";

    buildInputs = [
      #figlet
      pkgs.terraform
      pkgs.terragrunt
    ];

    shellHook = ''
      #figlet -w 160 "${name}"
    '';
  }
