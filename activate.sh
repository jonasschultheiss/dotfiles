#!/bin/bash
set -e

echo "Activating nix-darwin configuration..."
./result/sw/bin/darwin-rebuild switch --flake .#system

echo "Activating home-manager configuration for jonasschultheiss..."
nix run .#homeConfigurations.jonasschultheiss.activationPackage

echo "Configuration activated successfully!" 