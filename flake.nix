{
  description = "Multi-user nix-darwin configuration with flakes";

  inputs = {
    # Package sources
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Environment/system management
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    darwin,
    home-manager,
    ...
  }: let
    # System architecture
    system = "aarch64-darwin"; # Change to x86_64-darwin if you're on Intel

    # Configure nixpkgs
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    # Define user configurations
    users = {
      jonasschultheiss = {
        username = "jonasschultheiss";
        homeDirectory = "/Users/jonasschultheiss";
      };
      verastalder = {
        username = "verastalder";
        homeDirectory = "/Users/verastalder";
      };
    };
  in {
    darwinConfigurations.system = darwin.lib.darwinSystem {
      inherit system;
      modules = [
        # nix-darwin base configuration
        ./modules/darwin

        # Make home-manager work with nix-darwin
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users = {
              # Import user-specific configurations
              ${users.jonasschultheiss.username} = import ./modules/home/jonasschultheiss;
              ${users.verastalder.username} = import ./modules/home/verastalder;
            };
          };
        }
      ];
    };

    # Convenient development shell for bootstrapping
    devShell.${system} = pkgs.mkShell {
      buildInputs = [
        pkgs.nixfmt
      ];
    };
  };
}
