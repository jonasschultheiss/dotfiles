# Configuration validation module
# This module centralizes all validation logic for users and computers
{
  config,
  lib,
  pkgs,
  currentUser,
  currentComputer,
  self, # Access to flake
  ...
}: let
  # Use the users and computers defined in flake.nix, accessed via the self parameter
  users = self.usersData;
  computers = self.computersData;

  # Check if the currentUser is valid
  isValidUser =
    currentUser
    != null
    && currentUser.username != null
    && builtins.hasAttr currentUser.username users;

  # Check if the currentComputer is valid
  isValidComputer =
    currentComputer
    != null
    && currentComputer.name != null
    && builtins.hasAttr currentComputer.name computers;

  # Generate error messages
  userErrorMsg = ''
    Error: Invalid user configuration.
    Current user: ${
      if currentUser != null && currentUser.username != null
      then currentUser.username
      else "undefined"
    }
    Valid users: ${builtins.concatStringsSep ", " (builtins.attrNames users)}
  '';

  computerErrorMsg = ''
    Error: Invalid computer configuration.
    Current computer: ${
      if currentComputer != null && currentComputer.name != null
      then currentComputer.name
      else "undefined"
    }
    Valid computers: ${builtins.concatStringsSep ", " (builtins.attrNames computers)}
  '';
in {
  # Generate assertions based on the validation results
  assertions = [
    {
      assertion = isValidUser;
      message = userErrorMsg;
    }
    {
      assertion = isValidComputer;
      message = computerErrorMsg;
    }
  ];
}
