# bix

For `bun` you need a `yarn.lock`, make sure to install that automatically with following in `~/.bunfig.toml`:

```toml
[install.lockfile]
print = "yarn"

```

# Use `bun`

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    bix = {
      url = "github:knarkzel/bix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { bix, ... }: {
    packages.x86_64-linux = bix.buildBunPackage {
      src = ./.;
      packages = ./package.json;
      hash = "run-nix-build-for-the-hash";
    };
  };
}

```

# Use `node`

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    bix = {
      url = "github:knarkzel/bix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { bix, ... }: {
    packages.x86_64-linux = bix.buildNodePackage {
      src = ./.;
      packages = ./package.json;
      hash = "run-nix-build-for-the-hash";
    };
  };
}
```

# Fix issue building vips when using sharp

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    bix = {
      url = "github:knarkzel/bix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, bix, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    packages.x86_64-linux = bix.buildNodePackage {
      src = ./.;
      packages = ./package.json;
      hash = "run-nix-build-for-the-hash";
      config = {
        buildInputs = [pkgs.vips];
        nativeBuildInputs = [pkgs.pkg-config pkgs.python3];
        npmInstallFlags = ["--build-from-source"];
      };
    };
  };
}
```
