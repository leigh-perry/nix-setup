let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2020-10-06";
        # Commit hash for nixos-unstable as of 2020-10-06 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/84d74ae9c9cbed73274b8e4e00be14688ffc93fe.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "0ww70kl08rpcsxb9xdx8m48vz41dpss4hh3vvsmswll35l158x0v";
      }
    ) {
    };

  select_plugins = p: [ p.google p.google-beta p.null ];
  app_terraform = { full = pkgs.terraform.withPlugins select_plugins; };
  app_terragrunt = pkgs.terragrunt.override { terraform = app_terraform; };
in
  pkgs.stdenv.mkDerivation rec {
    name = "Terraform";

    buildInputs = [
      #figlet
      pkgs.terraform_0_13
      app_terragrunt
    ];

    shellHook = ''
      #figlet -w 160 "${name}"
    '';
  }
