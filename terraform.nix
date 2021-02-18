let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2021-01-27";
        # Commit hash for nixos-unstable as of 2021-01-27 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/891f607d5301d6730cb1f9dcf3618bcb1ab7f10e.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "1cr39f0sbr0h5d83dv1q34mcpwnkwwbdk5fqlyqp2mnxghzwssng";
      }
    ) {
    };

  select_plugins = p: [ p.google p.google-beta p.null ];
  app_terraform = { full = pkgs.terraform_0_14.withPlugins select_plugins; };
  app_terragrunt = pkgs.terragrunt;
in
  pkgs.stdenv.mkDerivation rec {
    name = "Terraform";

    buildInputs = [
      #figlet
      pkgs.terraform_0_14
      pkgs.terragrunt
    ];

    shellHook = ''
      #figlet -w 160 "${name}"
    '';
  }
