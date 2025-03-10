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
  }: let
    system = "aarch64-darwin";
    pkgs = nixpkgs.legacyPackages.${system};

    # Function to create a user configuration
    mkUserConfig = {
      username,
      email,
      extraStarshipSettings ? {},
    }: {
      config,
      lib,
      ...
    }: {
      home = {
        username = username;
        homeDirectory = "/Users/${username}";
        stateVersion = "22.05";

        packages = with pkgs; [
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

      # Enable starship with user-specific configuration
      programs.starship = {
        enable = true;
        enableFishIntegration = true;
        settings =
          lib.recursiveUpdate {
            format = "$username$hostname$directory$git_branch$git_status$cmd_duration$line_break$character";

            # Common symbol settings
            character = {
              success_symbol = "[➜](bold green)";
              error_symbol = "[✗](bold red)";
            };

            # Directory settings
            directory = {
              truncation_length = 5;
              truncation_symbol = "…/";
            };
          }
          extraStarshipSettings;
      };

      # Enable git with user-specific settings
      programs.git = {
        enable = true;
        userName = username;
        userEmail = email;
        extraConfig = {
          init.defaultBranch = "main";
          pull.rebase = true;
          push.autoSetupRemote = true;
          core.editor = "vim";
        };
      };

      # Import shared modules
      imports = [
        ../../modules/shared/lunaka-config
      ];
    };

    # Create dedicated user modules
    userModules = {
      jonasschultheiss = ./modules/home/jonasschultheiss/utilities.nix;
      verastalder = ./modules/home/verastalder/utilities.nix;
    };

    # Specific Starship settings for verastalder
    verastalder-starship-settings = {
      format = "$battery$username$hostname$directory$git_branch$git_state$git_status$cmd_duration$line_break$python$character";

      directory.read_only = " ";
      battery = {
        full_symbol = "•";
        charging_symbol = "⇡";
        discharging_symbol = "⇣";
      };
      git_branch = {
        format = "[$branch]($style)";
        style = "bright-black";
      };
      git_status = {
        format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](bright-black)( $ahead_behind$stashed)]($style) ";
        style = "cyan";
        conflicted = "​";
        untracked = "​";
        modified = "​";
        staged = "​";
        renamed = "​";
        deleted = "​";
        stashed = "≡";
      };
      git_state = {
        format = "\([$state( $progress_current/$progress_total)]($style)\) ";
        style = "bright-black";
      };
      cmd_duration = {
        format = "[$duration]($style) ";
        style = "yellow";
      };
    };
  in {
    # Home Manager configurations
    homeConfigurations = {
      jonasschultheiss = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [
          # Common user config
          (mkUserConfig {
            username = "jonasschultheiss";
            email = "jonas.schultheiss@example.com";
          })
          # User-specific utilities
          userModules.jonasschultheiss
          # Shared utilities
          ./modules/shared/utilities/default.nix
        ];
      };

      verastalder = home-manager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [
          # Common user config with custom starship settings
          (mkUserConfig {
            username = "verastalder";
            email = "vera.stalder@example.com";
            extraStarshipSettings = verastalder-starship-settings;
          })
          # User-specific utilities
          userModules.verastalder
          # Shared utilities
          ./modules/shared/utilities/default.nix
        ];
      };
    };

    # Darwin configurations
    darwinConfigurations.system = darwin.lib.darwinSystem {
      inherit system;
      modules = [
        # Basic darwin configuration
        {
          # Enable nix command and flakes with dirty warning disabled
          nix.settings = {
            experimental-features = ["nix-command" "flakes"];
            warn-dirty = false; # Disable the "Git tree is dirty" warning
          };

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

          # Configure screenshot location for jonasschultheiss
          system.defaults.screencapture.location = "/Users/jonasschultheiss/Pictures/Screenshots";
        }
      ];
    };

    # One-command builds with native commands
    # Run with: nix run .#build
    apps.${system} = {
      build = {
        type = "app";
        program = toString (pkgs.writeShellScript "build-and-switch" ''
          #!/bin/sh
          set -e

          # Build system configuration
          echo "Building system configuration..."
          nix build .#darwinConfigurations.system.system

          # Apply system configuration
          echo "Applying system configuration..."
          ./result/sw/bin/darwin-rebuild switch --flake .#system

          # Determine current user
          CURRENT_USER=$(whoami)

          # Build and activate home-manager configuration
          echo "Building and activating home-manager configuration for $CURRENT_USER..."

          # Try to build the home-manager configuration
          if nix build .#homeConfigurations.$CURRENT_USER.activationPackage --no-link 2>/dev/null; then
            echo "Using home-manager configuration for $CURRENT_USER"
            nix build .#homeConfigurations.$CURRENT_USER.activationPackage
            ./result/activate
          else
            echo "No home-manager configuration found for $CURRENT_USER"
          fi

          echo "Configuration applied successfully!"
        '');
      };
    };
  };
}
