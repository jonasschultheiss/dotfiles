{
  description = "Minimal nix-darwin configuration with flakes";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    darwin,
    home-manager,
    ...
  } @ inputs: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    darwinConfigurations.minimal = darwin.lib.darwinSystem {
      inherit system;
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
          environment.shells = with pkgs; [fish];

          # Set hostname and system version
          networking.hostName = "jonasschultheiss-mac";
          system.stateVersion = 4;

          # Add basic system packages
          environment.systemPackages = with pkgs; [
            alejandra
            git
          ];
        }

        # Add home-manager
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # Configure jonasschultheiss user
          home-manager.users.jonasschultheiss = {pkgs, ...}: {
            home.username = "jonasschultheiss";
            home.homeDirectory = "/Users/jonasschultheiss";
            home.stateVersion = "22.05";

            # Enable home-manager
            programs.home-manager.enable = true;

            # Enable fish
            programs.fish.enable = true;

            # Enable git
            programs.git = {
              enable = true;
              userName = "Jonas Schultheiss";
              userEmail = "jonas.schultheiss@example.com";
            };

            # Basic packages
            home.packages = with pkgs; [
              fd
              eza
              bat
              ripgrep
            ];
          };
        }
      ];
    };
  };
}
