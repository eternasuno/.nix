{
  description = "Nixos configuration.";

  outputs = {nixpkgs, ...} @ inputs: let
    inherit (nixpkgs) lib;
    hostConfigs = [
      (import ./hosts/framework inputs)
      (import ./hosts/MacBook-Air inputs)
    ];
  in
    lib.foldl lib.recursiveUpdate {} hostConfigs;

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-plugin-registry = {
      url = "github:AvengeMedia/dms-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    textfox = {
      url = "github:adriankarlen/textfox";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    maki = {
      url = "github:tontinton/maki";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # obscura darwin support PR (NixOS/nixpkgs#555157), head commit
    obscura-pr = {
      url = "github:dhogenson/nixpkgs/27e30e6529f48655b7f1a79e4cd6052dec2ef243";
      flake = false;
    };
  };
}
