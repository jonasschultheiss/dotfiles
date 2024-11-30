{ pkgs, ... }:

let mainUser = "jonasschultheiss";
in {
  imports = [ ./darwin <home-manager/nix-darwin> ];

  users.users.${mainUser} = {
    home = "/Users/${mainUser}";
    shell = pkgs.fish;
  };
  
  # Add fish to system shells
  environment.shells = with pkgs; [ fish ];
  programs.fish.enable = true;
  
  # Enable fish as login shell
  environment.loginShell = pkgs.fish;

  home-manager = {
    users.${mainUser} = import ./home;
    useGlobalPkgs = true;
    useUserPackages = false;
  };

  services.nix-daemon.enable = true;
  nix.useDaemon = true;

  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin-configuration.nix
  environment.darwinConfig = "$HOME/.config/nixpkgs/darwin-configuration.nix";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
