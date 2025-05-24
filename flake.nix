{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    devShell.${system} = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        bear
        gcc
        gnumake
        gtest
        sqlite
      ];
    };
    packages.${system} = {
      my-db = pkgs.stdenv.mkDerivation {
        name = "my-db";
        src = ./.;
        buildInputs = [pkgs.gcc pkgs.gnumake];
        nativeBuildInputs = [];
        buildPhase = ''
          make
        '';
        installPhase = ''
          mkdir -p $out/bin
          cp main.out $out/bin/my-db
        '';
      };
    };
  };
}
