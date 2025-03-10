{pkgs, ...}: let
  mainUser = "jonasschultheiss";
in {
  imports = [./darwin <home-manager/nix-darwin>];

  users.users.${mainUser} = {
    home = "/Users/${mainUser}";
    shell = pkgs.fish;
  };

  # Add fish to system shells
  environment.shells = with pkgs; [fish];
  programs.fish.enable = true;

  home-manager = {
    users.${mainUser} = import ./home;
    useGlobalPkgs = true;
    useUserPackages = false;
  };

  # Add system packages
  environment.systemPackages = with pkgs; [
    alejandra
  ];

  # The nix-daemon is now managed automatically by nix.enable
  nix.enable = true;

  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin-configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin-configuration.nix";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
