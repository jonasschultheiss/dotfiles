{
  config,
  pkgs,
  lib,
  ...
}: let
  # Get the current username
  username = config.home.username;
in {
  # Create the lunaka-config directory with the correct configuration files
  home.file = {
    # The devfish.json template
    ".config/lunaka-config/devfish.json".text =
      builtins.replaceStrings
      ["USERNAME_PLACEHOLDER"]
      [username]
      (builtins.readFile ./devfish.json.template);

    # Copy the iTerm2 shell integration files
    ".config/lunaka-config/iterm2_shell_integration" = {
      source = ./iterm2_shell_integration;
      recursive = true;
    };
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
    # Ensure target directories exist
    $DRY_RUN_CMD mkdir -p $VERBOSE_ARG ~/.config/lunaka-config

    # Create symbolic links (with -f to force overwrite if they exist)
    echo "Creating symbolic links for lunaka-config"
    $DRY_RUN_CMD rm -rf $VERBOSE_ARG ~/lunaka-config || true
    $DRY_RUN_CMD rm -rf $VERBOSE_ARG ~/Desktop/lunaka-config || true
    $DRY_RUN_CMD ln -sfn $VERBOSE_ARG ~/.config/lunaka-config ~/lunaka-config
    $DRY_RUN_CMD ln -sfn $VERBOSE_ARG ~/.config/lunaka-config ~/Desktop/lunaka-config

    echo "lunaka-config setup complete"
  '';
}
