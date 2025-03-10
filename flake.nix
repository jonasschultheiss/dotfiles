{
  description = "Multi-user nix-darwin configuration with flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    darwin,
    home-manager,
    ...
  }: {
    # Home Manager configurations
    homeConfigurations = {
      jonasschultheiss = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [
          {
            home = {
              username = "jonasschultheiss";
              homeDirectory = "/Users/jonasschultheiss";
              stateVersion = "22.05";

              packages = with nixpkgs.legacyPackages.aarch64-darwin; [
                fd
                eza
                bat
                ripgrep
                git
                starship
              ];
            };

            # Enable home-manager
            programs.home-manager.enable = true;

            # Enable fish
            programs.fish.enable = true;

            # Enable starship and configure it properly
            programs.starship = {
              enable = true;
              enableFishIntegration = true;
              settings = {
                add_newline = true;
                format = "$all";
              };
            };

            # Enable git
            programs.git = {
              enable = true;
              userName = "Jonas Schultheiss";
              userEmail = "jonas.schultheiss@example.com";
            };

            # Import shared modules
            imports = [
              ./modules/shared/lunaka-config
              ./modules/shared/utilities/default.nix
              ./modules/shared/utilities/fish-fixes.nix
              ./modules/home/jonasschultheiss/utilities.nix
            ];
          }
        ];
      };

      verastalder = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [
          {
            home = {
              username = "verastalder";
              homeDirectory = "/Users/verastalder";
              stateVersion = "22.05";

              packages = with nixpkgs.legacyPackages.aarch64-darwin; [
                fd
                eza
                bat
                ripgrep
                git
                starship
              ];
            };

            # Enable home-manager
            programs.home-manager.enable = true;

            # Enable fish
            programs.fish.enable = true;

            # Enable starship and configure it properly
            programs.starship = {
              enable = true;
              enableFishIntegration = true;
              settings = {
                add_newline = true;
                format = "$all";
              };
            };

            # Enable git
            programs.git = {
              enable = true;
              userName = "Vera Stalder";
              userEmail = "vera.stalder@example.com";
            };

            # Import shared modules
            imports = [
              ./modules/shared/lunaka-config
              ./modules/shared/utilities/default.nix
              ./modules/shared/utilities/fish-fixes.nix
              ./modules/home/verastalder/utilities.nix
            ];
          }
        ];
      };
    };

    # Darwin configurations
    darwinConfigurations.system = darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        # Basic darwin configuration
        {
          # Enable nix command and flakes
          nix.settings.experimental-features = ["nix-command" "flakes"];

          # Enable auto-optimise-store
          nix.optimise.automatic = true;

          # Allow unfree packages
          nixpkgs.config.allowUnfree = true;

          # Enable fish shell
          programs.fish.enable = true;
          environment.shells = with nixpkgs.legacyPackages.aarch64-darwin; [fish];

          # Set hostname and system version
          networking.hostName = "jonasschultheiss-mac";
          system.stateVersion = 4;

          # Add basic system packages
          environment.systemPackages = with nixpkgs.legacyPackages.aarch64-darwin; [
            alejandra
            git
          ];

          # Configure screenshot location for jonasschultheiss
          system.defaults.screencapture.location = "/Users/jonasschultheiss/Pictures/Screenshots";
        }
      ];
    };
  };
}
