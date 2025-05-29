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
        tests = pkgs.stdenv.mkDerivation {
          name = "tests";
          src = ./.;
          buildInputs = with pkgs; [gcc gnumake gtest];
          buildPhase = ''
            make test.out
          '';
          installPhase = ''
            mkdir -p $out/bin
            cp test.out $out/bin/tests
          '';
        };
      };
    });
}
