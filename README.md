# nix-setup

[![Powered by Nix](https://img.shields.io/badge/powered%20by-nix-blue.svg)](https://nixos.org/nix/)
![Grain free](https://img.shields.io/badge/grain-free-orange.svg)

# Introduction

This is a group of derivations for `nix-shell`.
They let you spin up sandboxed installations of tools set for Scala, Haskell, Terraform, etc
without installing anything globally on your computer.

# Installation steps

1. Install Nix by following [their instructions](https://nixos.org/nix/).
2. Clone this repo somewhere, say `~/dev/nix-setup`
3. Create a symlink on your system path to the `sn` script, say at `~/dev/nix-setup/sn`

# Usage

To invoke a set of Nix shells, type `sn <shell-name> <shell-name> ... <shell-name>`.

Currently supported shell-name values are

| shell-name    | Description                 | Derivation                 |
| ------------- |-----------------------------| ---------------------------|
| aws           | AWS CLI                     | `nix-setup/aws.nix`        |       
| haskell       | Haskell development         | `nix-setup/haskell.nix`    |           
| kafka         | Kafka tools                 | `nix-setup/kafka.nix`      |         
| scala         | Scala development           | `nix-setup/scala.nix`      |         
| shellutil     | Utils for bash or zsh       | `nix-setup/shell.nix`      |         
| spark         | Scala development for Spark | `nix-setup/spark.nix`      |         
| terraform     | Terraform tools             | `nix-setup/terraform.nix`  |             

After loading the specified Nix shells, `sn` then invokes `zsh`.
If you don't use zsh, hack the `sn` script accordingly.