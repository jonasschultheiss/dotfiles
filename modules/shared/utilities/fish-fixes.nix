{
  config,
  pkgs,
  lib,
  ...
}: {
  # Add a function to safely handle starship prompt initialization
  programs.fish.functions = {
    # Function to safely initialize starship prompt
    safe_starship_init = ''
      # Only try to initialize starship if it's available in the path
      if command -sq starship
        # Initialize starship
        starship init fish | source
      else
        # Fallback to a simple prompt if starship is not available
        function fish_prompt
          echo -n (set_color green)(whoami)(set_color normal)@(set_color blue)(hostname -s)(set_color normal)' '
          echo -n (set_color yellow)(prompt_pwd)(set_color normal)' > '
        end
      end
    '';
  };

  # Add Fish initialization to safely handle starship
  programs.fish.interactiveShellInit = ''
    # Safely initialize starship prompt to avoid errors when not installed
    safe_starship_init
  '';
}
