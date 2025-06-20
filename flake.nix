{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf = {
      url = "github:notashelf/nvf/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
    hyprland.url = "github:hyprwm/Hyprland";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    zen-browser,
    nvf,
    catppuccin,
    ...
    } @ inputs: let
      system = "x86_64-linux";
      inherit (nixpkgs) lib;
    in {
      pkgs = nixpkgs.legacyPackages.system;

      nixosConfigurations = {
        cafo = lib.nixosSystem {
          inherit system;
          modules = [
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.backupFileExtension = "backup";
              # home-manager.backupFileExtension = "backup-" + pkgs.lib.readFile "${pkgs.runCommand "timestamp" { env.when = self.sourceInfo.lastModified; } "echo -n `date '+%Y%m%d%H%M%S'` > $out"}";
              home-manager.useUserPackages = true;
              home-manager.users.cafo = {
                imports = [
                  nvf.homeManagerModules.default
                  catppuccin.homeModules.catppuccin
                  ./home/home.nix
                  ./home/nvf_conf.nix
                  ./home/wayland/hypr/hypr.nix
                  ./home/wayland/hypr/hyprpaper.nix
                  ./home/wayland/hypr/hypridle.nix
                  ./home/wayland/mako.nix
                ];
              };
              home-manager.extraSpecialArgs = {
                inherit inputs system;
                pkgs = nixpkgs.legacyPackages.${system};
              };
            }
          ];
        };
      };
    };
}
