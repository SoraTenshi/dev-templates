{
  description = "Template generator for some dev stuff i do";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: {
    templates = {
      rust = {
        path = ./rust;
      };
      swift = {
        path = ./swift;
      };
      vale = {
        path = ./vale;
      };
      zig = {
        path = ./zig;
      };
    };
  };
}
