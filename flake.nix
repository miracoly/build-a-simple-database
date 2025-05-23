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
      shellHook = ''
        bear -- make > /dev/null 2>&1
      '';
    };
  };
}
