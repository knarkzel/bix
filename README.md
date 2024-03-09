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
      hash = "just-run-nix-build-for-the-hash";
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
      hash = "just-run-nix-build-for-the-hash";
    };
  };
}

```
