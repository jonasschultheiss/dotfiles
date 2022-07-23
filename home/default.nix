{ config, pkgs, ... }:

{
  imports = [
    ./git
    ./shell.nix
    ];

  home.sessionVariables = {
    ANDROID_SDK_ROOT = "$HOME/Library/Android/sdk";
  };

  home.sessionPath = [
    "$ANDROID_SDK_ROOT/emulator"
    "$ANDROID_SDK_ROOT/platform-tools"
  ];



  home.packages = with pkgs; [
    home-manager # system package manager
    comma        # any cli you may need

  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}
