{
  description = "Flutter";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system: let
      devPkgs = import nixpkgs {
        inherit system;
        config = {
          android_sdk.accept_license = true;
          allowUnfree = true;
        };
      };

      pkgs = import nixpkgs {inherit system;};
    in {
      devShells.default = import ./nix/devshell.nix {pkgs = devPkgs;};

      packages.default = pkgs.callPackage ./nix/package.nix {};
    });
}
