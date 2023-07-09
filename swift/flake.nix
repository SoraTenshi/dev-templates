{
  description = "A Nix-flake-based Swift development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = with pkgs; [ swift swiftPackages.swiftpm glibc ];

        shellHook = ''
          echo "swift `${pkgs.swift}/bin/swift --version`"
        '';
      };
    });
}