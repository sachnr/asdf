{
  description = "nix flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    wallpapers = {
      url = "github:sachnr/wallpapers";
      flake = false;
    };
  };

  outputs = inputs @ {self, ...}: let
    inherit (inputs.nixpkgs) lib;
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  in
    with lib; rec {
      wallpapers = pkgs.callPackage ./wallpapers.nix {inherit inputs;};
      rofi-script = pkgs.callPackage ./pkg.nix {};
      # swww = pkgs.callPackage ./swww.nix {};
      overlay = final: prev: {
        rofi-script = self.rofi-script;
        wallpapers = self.wallpapers;
        # swww = self.swww;
      };
      homeManagerModules.default = import ./hmModule.nix self;
    };
}
