{pkgs, ...}: {
  # Define a user with Fish as the default shell
  users.users.jonasschultheiss = {
    name = "jonasschultheiss";
    home = "/Users/jonasschultheiss";
    shell = pkgs.fish;
    uid = 501;
  };

  users.knownUsers = [ "jonasschultheiss" ];

  # Enable Fish shell system-wide
  environment.shells = with pkgs; [fish];
  programs.fish.enable = true;

  # Add system packages (from the current darwin-configuration.nix)
  environment.systemPackages = with pkgs; [
    alejandra
  ];

  # Set the default configuration path
  environment.darwinConfig = "$HOME/.config/nixpkgs/flake.nix";

  # Set hostname and computer name
  networking = {
    computerName = "devenv";
    hostName = "devenv";
    localHostName = "devenv";
  };

  # This configures macOS to use the hostname in various services
  system.defaults.smb.NetBIOSName = "devenv";
  system.defaults.smb.ServerDescription = "devenv";
}
