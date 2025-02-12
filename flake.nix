{
  outputs = {
    nixpkgs,
    self,
  }: let
    allSys = f: builtins.mapAttrs (_: pkgs: f pkgs) nixpkgs.legacyPackages;
  in {
    packages = allSys (pkgs: {
      default = let
        pkg = {bundlerApp}:
          bundlerApp {
            pname = "hola";
            gemdir = ./.;
            exes = ["hola"];
          };
      in
        pkgs.callPackage pkg {};
    });
    devShells = allSys (pkgs: {
      default = pkgs.mkShell {
        packages = with pkgs; [solargraph ruby.devEnv];
        inputsFrom = [self.packages.${pkgs.system}.default];
      };
    });
  };
}
