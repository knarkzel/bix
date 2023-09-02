{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = import nixpkgs {
      system = "x86_64-linux";
    };
  in {
    buildBunPackage = {
      src,
      packages,
      hash,
      config ? {},
    }: let
      packageJSON = pkgs.lib.importJSON packages;
      site-src = pkgs.buildNpmPackage {
        inherit src;
        pname = "${packageJSON.name}";
        version = packageJSON.version;
        npmDepsHash = hash;
        installPhase = ''
          cp -r . $out
        '';
      } // config;
    in {
      pkgs.writeShellScriptBin = "${packageJSON.name}" ''
        ${pkgs.bun}/bin/bun ${site-src}/build
      '';
    };
  };
}
