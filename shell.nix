{ pkgs ? import <nixpkgs> {} }:
let
  inherit (pkgs) ruby bundlerEnv mkShell bundler;

  env = bundlerEnv {
    name = "github_oldtimes";
    gemdir = ./.;
  };
in
  mkShell { buildInputs = [ ruby env bundler ]; }
