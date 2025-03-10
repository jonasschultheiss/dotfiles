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
  } @ inputs: let
    inherit (darwin.lib) darwinSystem;
    inherit (home-manager.lib) homeManagerConfiguration;
    inherit (nixpkgs.lib) optionalAttrs mkMerge optional;
    inherit (builtins) pathExists;

    # System architecture
    system = "aarch64-darwin";

    # Configuration for Mac hardware - OS specific modules
    darwinModules = [
      ./modules/os/darwin/default.nix
      ./modules/validation/config-validation.nix
    ];

    # Common feature modules - always loaded
    commonFeatureModules = [
      ./modules/features/git
      ./modules/features/shell
      ./modules/features/starship
    ];

    # Define available computers - expose as flake attribute
    computers = {
      devenv = {
        description = "Development Environment";
        hostName = "devenv";
      };
      devenv-pax = {
        description = "PAX Development Environment";
        hostName = "devenv-pax";
      };
    };

    # Define known users with their metadata - expose as flake attribute
    users = {
      jonasschultheiss = {
        username = "jonasschultheiss";
        email = "complaint@jonasschultheiss.dev";
        fullName = "Jonas Schultheiss";
        githubUsername = "jonasschultheiss";
        githubSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIEkKRKYGIagUWR53s7ZH5lrn7O1ALWqbjALwrIm13Rv";
        githubAuthkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGNNCEOHeRpxqO/nOSepzbEV4MqfF5kYwODzjmnhinom";
      };
      verastalder = {
        username = "verastalder";
        email = "verag@lunaka.dev";
        fullName = "Vera Stalder";
        githubUsername = "verastalder";
        githubSigningKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIEkKRKYGIagUWR53s7ZH5lrn7O1ALWqbjALwrIm13Rv";
        githubAuthkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGNNCEOHeRpxqO/nOSepzbEV4MqfF5kYwODzjmnhinom";
      };
      default = {
        username = "default";
        email = "default@example.com";
        fullName = "Default User";
      };
    };

    # Function to create specialized arguments for modules
    mkSpecialArgs = {
      userInfo ? {},
      computerName ? null,
    } @ args: {
      inherit inputs self system;
      flakeDirectory = self.outPath;
      currentUser = userInfo;
      currentComputer =
        if computerName != null
        then computers.${computerName} // {name = computerName;}
        else null;
    };

    # Function to check if a user-specific configuration exists
    userHasConfig = username: configPath:
      pathExists configPath;

    # Function to create user configurations with consistent structure
    mkUserConfig = username: computerName: let
      userInfo = users.${username} or users.default;

      # Path to user-specific configuration for this computer
      userComputerConfigPath = ./users/${username}/computers/${computerName}.nix;
      userDefaultConfigPath = ./users/${username}/default.nix;

      # Whether user-specific configuration files exist
      hasComputerConfig = userHasConfig username userComputerConfigPath;
      hasDefaultConfig = userHasConfig username userDefaultConfigPath;
    in
      homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = mkSpecialArgs {
          userInfo = userInfo;
          inherit computerName;
        };
        modules = [
          # Base computer configuration
          ./computers/${computerName}/default.nix

          # Common feature modules
          commonFeatureModules

          # User's default configuration (if it exists)
          (optional hasDefaultConfig userDefaultConfigPath)

          # User's computer-specific configuration (if it exists)
          (optional hasComputerConfig userComputerConfigPath)
        ];
      };

    # Function to create a Darwin configuration for a specific computer
    mkComputerConfig = computerName:
      darwinSystem {
        inherit system;
        specialArgs = mkSpecialArgs {computerName = computerName;};
        modules =
          darwinModules
          ++ [
            # Computer-specific configuration
            ./computers/${computerName}/default.nix

            # Set hostname during build
            {
              networking.hostName = computers.${computerName}.hostName;
              networking.computerName = computers.${computerName}.hostName;
              networking.localHostName = computers.${computerName}.hostName;
            }
          ];
      };

    # Function to create a build script for a specific computer and user
    mkBuildScript = computerName: username:
      nixpkgs.legacyPackages.${system}.writeShellScript "build-${computerName}-${username}" ''
        #!/bin/sh
        set -e

        # Build and apply system configuration for ${computerName}
        echo "Building system configuration for ${computerName}..."
        nix build ${self}#darwinConfigurations.${computerName}.system --no-link

        # Apply system configuration
        echo "Applying system configuration..."
        ${darwin.packages.${system}.darwin-rebuild}/bin/darwin-rebuild switch --flake ${self}#${computerName}

        # Build and activate home-manager configuration for ${username} on ${computerName}
        echo "Building and activating home-manager configuration for ${username} on ${computerName}..."
        nix build ${self}#homeConfigurations.${username}-${computerName}.activationPackage --no-link
        ${home-manager.packages.${system}.home-manager}/bin/home-manager switch --flake ${self}#${username}-${computerName}

        echo "Configuration applied successfully!"
      '';

    # Build all possible user-computer combinations for known users
    allUserComputerConfigs = builtins.foldl' (
      result: username:
        builtins.foldl' (
          innerResult: computerName:
            innerResult
            // {
              "${username}-${computerName}" = mkUserConfig username computerName;
            }
        )
        result (builtins.attrNames computers)
    ) {} (builtins.attrNames users);
  in {
    # Expose users and computers as flake attributes for validation
    usersData = users;
    computersData = computers;

    # Home Manager configurations - one for each valid user-computer combination
    homeConfigurations = allUserComputerConfigs;

    # Darwin configurations - one per computer
    darwinConfigurations = builtins.listToAttrs (builtins.map (computerName: {
      name = computerName;
      value = mkComputerConfig computerName;
    }) (builtins.attrNames computers));

    # Build scripts - one per known user-computer combination
    apps.${system} =
      # Generate build scripts for all known users on all computers
      builtins.foldl' (
        result: username:
          builtins.foldl' (
            innerResult: computerName:
              innerResult
              // {
                "build-${computerName}-${username}" = {
                  type = "app";
                  program = toString (mkBuildScript computerName "${username}-${computerName}");
                };
              }
          )
          result (builtins.attrNames computers)
      ) {} (builtins.filter (name: name != "default") (builtins.attrNames users))
      # Default build script that detects the current hostname and user
      // {
        build = {
          type = "app";
          program = toString (nixpkgs.legacyPackages.${system}.writeShellScript "build-detect" ''
            #!/bin/sh
            set -e

            # Detect current user and hostname
            CURRENT_USER=$(whoami)
            CURRENT_HOST=$(hostname -s)

            # Check if we have a configuration for this hostname
            if ! nix build ${self}#darwinConfigurations.$CURRENT_HOST.system --no-link 2>/dev/null; then
              echo "No configuration found for computer '$CURRENT_HOST'"
              echo "Available computers:"
              echo "  $(ls -1 computers | tr '\n' ' ')"
              echo ""
              echo "Please run 'nix run .#build-COMPUTER-USER' to apply a specific configuration"
              exit 1
            fi

            # Apply system configuration
            echo "Applying system configuration for $CURRENT_HOST..."
            ${darwin.packages.${system}.darwin-rebuild}/bin/darwin-rebuild switch --flake ${self}#$CURRENT_HOST

            # Check for user-specific configuration
            CONFIG_NAME="$CURRENT_USER-$CURRENT_HOST"
            FALLBACK_CONFIG="default-$CURRENT_HOST"

            if nix build ${self}#homeConfigurations.$CONFIG_NAME.activationPackage --no-link 2>/dev/null; then
              echo "Using home-manager configuration for $CURRENT_USER on $CURRENT_HOST"
              ${home-manager.packages.${system}.home-manager}/bin/home-manager switch --flake ${self}#$CONFIG_NAME
            elif nix build ${self}#homeConfigurations.$FALLBACK_CONFIG.activationPackage --no-link 2>/dev/null; then
              echo "No specific configuration found for $CURRENT_USER, using default configuration for $CURRENT_HOST"
              ${home-manager.packages.${system}.home-manager}/bin/home-manager switch --flake ${self}#$FALLBACK_CONFIG
            else
              echo "No configuration found for $CURRENT_USER or default on $CURRENT_HOST"
              echo "Available users for this computer:"
              for user in $(ls -1 users); do
                if nix build ${self}#homeConfigurations.$user-$CURRENT_HOST.activationPackage --no-link 2>/dev/null; then
                  echo "  $user"
                fi
              done
              echo ""
              echo "Please run 'nix run .#build-$CURRENT_HOST-USER' to apply a specific configuration"
              exit 1
            fi

            echo "Configuration applied successfully!"
          '');
        };
      };
  };
}
