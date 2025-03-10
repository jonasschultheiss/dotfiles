{
  config,
  pkgs,
  lib,
  ...
}: let
  # Get the current username
  username = config.home.username;
in {
  # Create the directory in the users's home
  home.file."lunaka-config" = {
    source = ./.; # Copy the entire lunaka-config directory
    recursive = true;
    onChange = ''
      # Process the devfish.json template and replace the placeholder with the current username
      if [ -f ~/.config/home-manager/lunaka-config/devfish.json.template ]; then
        cat ~/.config/home-manager/lunaka-config/devfish.json.template | sed "s/USERNAME_PLACEHOLDER/${username}/g" > ~/.config/home-manager/lunaka-config/devfish.json
      fi

      # Create symbolic links
      ln -sf ~/.config/home-manager/lunaka-config ~/lunaka-config
      ln -sf ~/.config/home-manager/lunaka-config ~/Desktop/lunaka-config
    '';
  };

  # Add fish integration for iTerm2
  programs.fish.plugins = [
    {
      name = "iterm2-shell-integration";
      src = ./iterm2_shell_integration;
    }
  ];

  # Create an activation script to ensure links are created/updated at activation time
  home.activation.createLunakaConfigLinks = lib.hm.dag.entryAfter ["writeBoundary"] ''
    # Process the devfish.json template and replace the placeholder with the current username
    if [ -f ~/.config/home-manager/lunaka-config/devfish.json.template ]; then
      $DRY_RUN_CMD cat ~/.config/home-manager/lunaka-config/devfish.json.template | $DRY_RUN_CMD sed "s/USERNAME_PLACEHOLDER/${username}/g" > $VERBOSE_ARG ~/.config/home-manager/lunaka-config/devfish.json
    fi

    # Create symbolic links
    $DRY_RUN_CMD ln -sf ~/.config/home-manager/lunaka-config ~/lunaka-config
    $DRY_RUN_CMD ln -sf ~/.config/home-manager/lunaka-config ~/Desktop/lunaka-config
  '';
}
