{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable the Aerospace service
  # https://daiderd.com/nix-darwin/manual/index.html#opt-services.aerospace.enable
  
  # Make sure the aerospace package is installed
  environment.systemPackages = [ pkgs.aerospace ];
  
  services.aerospace = {
    enable = true;
    # Explicitly set the package
    package = pkgs.aerospace;
    # i3-like default configuration
    settings = {
      # Window appearance
      gap = 12;
      borderWidth = 2;
      borderColorFocused = "#689d6a"; # green
      borderColorNormal = "#3c3836"; # dark gray
      borderColorFloating = "#d79921"; # yellow

      # Window management behavior
      enableTilingMode = true;
      enableFloatingMode = true;
      enableStageMode = false;
      tilingFillStrategy = "recursive"; # recursive, minimal, balanced
      
      # Workspace settings
      workspaces = [
        { name = "1:web"; }
        { name = "2:code"; }
        { name = "3:term"; }
        { name = "4:chat"; }
        { name = "5:media"; }
        { name = "6:files"; }
        { name = "7:misc"; }
        { name = "8:misc"; }
        { name = "9:misc"; }
      ];
      
      # i3-like key bindings (using Command/Opt key as mod)
      keybindings = {
        # Window focus
        "cmd-h" = "focus left";
        "cmd-j" = "focus down";
        "cmd-k" = "focus up";
        "cmd-l" = "focus right";
        
        # Move windows
        "cmd+shift-h" = "move left";
        "cmd+shift-j" = "move down";
        "cmd+shift-k" = "move up";
        "cmd+shift-l" = "move right";
        
        # Window layout controls
        "cmd-f" = "fullscreen";
        "cmd-space" = "floating toggle";
        "cmd-e" = "layout toggle split";
        "cmd-s" = "layout stacking";
        "cmd-w" = "layout tabbed";
        
        # Workspace switching (cmd + number)
        "cmd-1" = "workspace 1:web";
        "cmd-2" = "workspace 2:code";
        "cmd-3" = "workspace 3:term";
        "cmd-4" = "workspace 4:chat";
        "cmd-5" = "workspace 5:media";
        "cmd-6" = "workspace 6:files";
        "cmd-7" = "workspace 7:misc";
        "cmd-8" = "workspace 8:misc";
        "cmd-9" = "workspace 9:misc";
        
        # Move window to workspace (cmd + shift + number)
        "cmd+shift-1" = "move container to workspace 1:web";
        "cmd+shift-2" = "move container to workspace 2:code";
        "cmd+shift-3" = "move container to workspace 3:term";
        "cmd+shift-4" = "move container to workspace 4:chat";
        "cmd+shift-5" = "move container to workspace 5:media";
        "cmd+shift-6" = "move container to workspace 6:files";
        "cmd+shift-7" = "move container to workspace 7:misc";
        "cmd+shift-8" = "move container to workspace 8:misc";
        "cmd+shift-9" = "move container to workspace 9:misc";
        
        # Common application shortcuts
        "cmd+shift-return" = "exec terminal";
        "cmd-d" = "exec open -a 'Spotlight'"; # like dmenu/rofi
        "cmd+shift-q" = "kill"; # close window
        "cmd+shift-c" = "reload"; # reload config
        "cmd+shift-r" = "restart"; # restart wm
      };
      
      # Mouse behavior
      mouse = {
        "mod-left" = "move";
        "mod-right" = "resize";
      };
      
      # Startup applications/commands
      startupCommands = [
        # Add any startup commands you want to run
        # "open -a Terminal"
        # "open -a Safari"
      ];
    };
  };
} 