{pkgs, ...}: {
  # Define users with Fish as the default shell
  users.users = {
    jonasschultheiss = {
      name = "jonasschultheiss";
      home = "/Users/jonasschultheiss";
      shell = pkgs.fish;
    };
    verastalder = {
      name = "verastalder";
      home = "/Users/verastalder";
      shell = pkgs.fish;
    };
  };

  # Enable Fish shell system-wide
  environment.shells = with pkgs; [fish];
  programs.fish.enable = true;

  # Add system packages
  environment.systemPackages = with pkgs; [
    alejandra
  ];

  # Set the default configuration path
  environment.darwinConfig = "$HOME/.config/nixpkgs/flake.nix";
}
