# EDA482 MD307 Flake

Development flake for EDA482 Machine oriented programming course.

## Installation

Add the flake input to your `flake.nix`:

```nix
{
  inputs.md307.url = "https://github.com/olillin/eda482-md307-flake";
}
```

Add the system module to `configuration.nix` install everything necessary:

```
{ pkgs, inputs, ... }:
{
  imports = [
    inputs.md307.nixosModules.default
  ];
}
```
    

Also add the Home Manager module, this will install extensions for
Visual Studio Code:

```
{ pkgs, inputs, ... }:
{
  home-manager.users.youruser = {
    # import the home manager module
    imports = [
      inputs.md307.homeModules.default
    ];
  };
}
```

