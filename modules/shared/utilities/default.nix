{
  config,
  pkgs,
  lib,
  ...
}: {
  # Add shared fish functions for managing the Nix configuration
  programs.fish.functions = {
    # Build both configurations (shared)
    build-configs = ''
      echo "Building nix-darwin configuration..."
      nix build .#darwinConfigurations.system.system

      echo "Building home-manager configuration for current user ($USER)..."
      nix build .#homeConfigurations.$USER.activationPackage

      echo "Configurations built successfully! Run apply-configs to activate them."
    '';

    # Update all nix packages and configurations (shared)
    update-nix = ''
      set -l old_dir (pwd)
      cd ~/.config/nixpkgs

      echo "Updating flake inputs..."
      nix flake update

      echo "Building updated configuration..."
      build-configs

      echo "Nix system updated successfully! Run apply-configs to activate the updated configuration."
      cd $old_dir
    '';

    # Apply both configurations (shared)
    apply-configs = ''
      set -l old_dir (pwd)
      cd ~/.config/nixpkgs

      # Only run the darwin-rebuild command if the result exists
      if test -e ./result/sw/bin/darwin-rebuild
        echo "Applying nix-darwin configuration..."
        ./result/sw/bin/darwin-rebuild switch --flake .#system
      else
        echo "Darwin configuration not built yet, skipping..."
      end

      # Only run the home-manager activation if the result exists
      if test -e ./result/activate
        echo "Applying home-manager configuration for current user ($USER)..."
        ./result/activate
      else
        echo "Home-manager configuration not built yet, skipping..."
      end

      echo "Configurations applied successfully!"
      cd $old_dir
    '';
  };

  # Add shared shell aliases for the functions
  programs.fish.shellAliases = {
    # Shorter aliases for the functions
    "build-nix" = "build-configs";
    "apply-nix" = "apply-configs";
    "update-all" = "update-nix";
  };
}
