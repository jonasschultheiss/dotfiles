# Starship configuration for jonasschultheiss
{pkgs, ...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format = "$username$hostname$directory$git_branch$git_status$cmd_duration$line_break$character";

      # Common symbol settings
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };

      # Directory settings
      directory = {
        truncation_length = 5;
        truncation_symbol = "…/";
      };
    };
  };
}
