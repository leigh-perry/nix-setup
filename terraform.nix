let
  pkgs =
    import (
      builtins.fetchTarball {
        # Descriptive name to make the store path easier to identify
        name = "nixos-unstable-2021-07-27";
        # Commit hash for nixos-unstable as of 2021-07-27 - get from head (git log)
        url = https://github.com/nixos/nixpkgs/archive/dd14e5d78e90a2ccd6007e569820de9b4861a6c2.tar.gz;
        # Hash obtained using `nix-prefetch-url --unpack <url>`
        sha256 = "1zmhwx1qqgl1wrrb9mjkck508887rldrnragvximhd7jrh1ya3fb";
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
