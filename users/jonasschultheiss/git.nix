# Git configuration for jonasschultheiss
{
  pkgs,
  lib,
  ...
}: {
  # Import common git configuration
  imports = [
    ../../modules/features/git/default.nix
  ];

  # User-specific git settings
  programs.git = {
    userName = "Jonas Schultheiss";
    userEmail = "complaint@jonasschultheiss.dev";

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIEkKRKYGIagUWR53s7ZH5lrn7O1ALWqbjALwrIm13Rv";
      signByDefault = true;
    };

    extraConfig = {
      # SSH signing
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      gpg.ssh.allowedSignersFile = builtins.toPath ./allowed-signers;

      commit.template = builtins.toPath ./git-message;
      commit.verbose = true;
    };
  };
}
