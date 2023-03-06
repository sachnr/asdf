nix flake for a single bash script :upside_down_face:

change wallpapers using rofi

![](/rofi/sample.png)

### Flake Usage

```nix
{
  description = "A very basic flake";

  inputs = {
    rofi-script.url = "github:sachnr/wallpapers";
  };

  outputs = { self, ... }@inputs: {
    nixosConfigurations.host = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          nixpkgs.overlays = [
              inputs.rofi-script.overlay
          ];
        }
        ./configuration.nix
      ];
    };
  };
}
```

### Home manager options

```
modules = [
    wall-utils.homeManagerModules.default
    {
        programs.wall-utils = {
            enable = true;
            swww.enable = true;
            customCommand = "swww img";
            customDir = "$HOME/Pictures";
            background = "#323D43FF";
            background-alt = "#3C474DFF";
            foreground = "#DAD1BEFF";
            selected = "#7FBBB3FF";
            active = "#A7C080FF";
            urgent = "#E67E80FF";
            font = "RobotoMono Nerd Font 9";
        };
    }
];

```
