{
  description = "A Nix-flake-based Zig development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    zig-overlay.url = "github:mitchellh/zig-overlay";
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , zig-overlay
    }:
    let
      overlays = [
        (final: prev: {
          zig-master = zig-overlay.${prev.system};
        })
      ];
    in
      flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit overlays system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [ zig-master.master ];

          shellHook = ''
            echo "zig `${pkgs.zig-overlay}/bin/zig version`"
          '';
        };
      });
}