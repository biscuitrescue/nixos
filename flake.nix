{
  description = "NixOS config with NVF, Hyprland, Catppuccin, and standalone Home Manager support";

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

    # nvf = {
    #   url = "github:notashelf/nvf";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

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
      # nvf.homeManagerModules.default
      catppuccin.homeModules.catppuccin
      ./home/modules/core.nix
      ./home/home.nix
      # ./home/nvf_conf.nix
      ./home/modules/packages.nix
      ./home/modules/hypr.nix
      ./home/modules/hyprpaper.nix
      ./home/modules/hypridle.nix
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
    ### 💥 NixOS System Configuration (with HM)
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

            # ✅ Required in NixOS module mode
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

      # NVF-only config (home-manager switch --flake .#nvf)
      # nvf = mkHomeConfig [
      #   ./home/modules/core.nix
      #   nvf.homeManagerModules.default
      #   ./home/nvf_conf.nix
      # ];
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
