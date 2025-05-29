{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      runBearMake = pkgs.writeShellScript "bear" ''
        exec ${pkgs.bear}/bin/bear -- make clean all
      '';
    in {
      devShells.default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          bear
          gcc
          gnumake
          gtest
          sqlite
        ];
        shellHook = ''
          ${runBearMake}
        '';
      };
      apps = {
        runBearMake = {
          type = "app";
          program = "${runBearMake}";
        };
      };
      packages = {
        mydb = pkgs.stdenv.mkDerivation {
          name = "mydb";
          src = ./.;
          buildInputs = [pkgs.gcc pkgs.gnumake];
          nativeBuildInputs = [];
          buildPhase = ''
            make
          '';
          installPhase = ''
            mkdir -p $out/bin
            cp mydb.out $out/bin/mydb
          '';
        };
      };
    });
}
