{
  description = "NixOS system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      zen-browser,
      nixos-hardware,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      # Central vars — change here, propagates everywhere
      vars = {
        username = "cafo";
        stateVersion = "26.11";
      };
      vars' = vars // { dir = "/home/${vars.username}"; };

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      extraSpecialArgs = { inherit inputs system; } // vars';

      homeModules = [
        ./home/home.nix
        ./home/modules/dark.nix
        ./home/modules/packages.nix
        ./home/modules/mako.nix
        ./home/modules/zsh.nix
      ];
    in
    {
      nixosConfigurations.${vars.username} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = extraSpecialArgs;

        modules = [
          ./nixos/configuration.nix
          nixos-hardware.nixosModules.lenovo-ideapad-slim-5

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = extraSpecialArgs // { inherit pkgs; };

              users.${vars.username} = { imports = homeModules; };
            };
          }
        ];
      };

      # Standalone home-manager (e.g. non-NixOS machines)
      homeConfigurations.${vars.username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = homeModules ++ [
          {
            home = {
              inherit (vars') username dir;
              inherit (vars) stateVersion;
            };
          }
        ];
        extraSpecialArgs = extraSpecialArgs;
      };

      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          home-manager.packages.${system}.home-manager
          jq
          nixfmt
        ];
      };
    };
}
