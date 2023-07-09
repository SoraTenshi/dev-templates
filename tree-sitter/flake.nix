{
  description = "A Nix-flake-based Tree-Sitter grammar development environment";

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
        packages = with pkgs; [ tree-sitter nodejs pnpm clang ];

        shellHook = ''
          echo "Tree-Sitter@`${pkgs.tree-sitter}/bin/tree-sitter --version`"
        '';
      };
    });
}