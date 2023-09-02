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
      hash,
      packages,
      config ? {},
    }: let
      manifest = pkgs.lib.importJSON packages;
      site-src = pkgs.buildNpmPackage {
        inherit src;
        pname = manifest.name;
        version = manifest.version;
        npmDepsHash = hash;
        installPhase = ''
          cp -r . $out
        '';
      } // config;
    in
      pkgs.writeShellScriptBin manifest.name ''
        ${pkgs.bun}/bin/bun ${site-src}/build
      '';
  };
}
