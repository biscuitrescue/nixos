{
  description = "NixOS system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    catppuccin.url = "github:catppuccin/nix";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, hyprland, ... }@inputs: let
    # ---- System-wide settings ----
    system = "x86_64-linux";
    username = "cafo";
    dir = "/home/${username}";
    stateVersion = "25.05";

    pkgs = nixpkgs.legacyPackages.${system};

    # ---- Shared Home Manager modules ----
    homeModules = [
      catppuccin.homeModules.catppuccin
      ./home/modules/core.nix
      ./home/home.nix
      ./home/modules/dark.nix
      ./home/modules/packages.nix
      ./home/modules/hypr/hypr.nix
      ./home/modules/hypr/hyprpaper.nix
      ./home/modules/hypr/hypridle.nix
      ./home/modules/mako.nix
    ];

    # ---- Passed to all HM configs ----
    extraSpecialArgs = {
      inherit inputs system pkgs username dir stateVersion;
    };

    # ---- Shortcut for home-manager.lib.homeManagerConfiguration ----
    mkHomeConfig = modules:
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs modules;
        extraSpecialArgs = extraSpecialArgs;
      };
  in {

    nixosConfigurations.${username} = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ./nixos/configuration.nix

        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";

          home-manager.users.${username} = {
            imports = homeModules;
            home.username = username;
            home.homeDirectory = dir;
            home.stateVersion = stateVersion;
          };

          home-manager.extraSpecialArgs = extraSpecialArgs;
        }
      ];
    };

    ### Standalone Home Configs (CLI)
    homeConfigurations = {
      ${username} = mkHomeConfig homeModules;
    };
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [
        inputs.home-manager.packages.${system}.home-manager
        pkgs.jq
        pkgs.nixpkgs-fmt
      ];
    };
  };
}
