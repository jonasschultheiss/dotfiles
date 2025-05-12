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
    # Configuration using the settings attribute
    settings = {
      # You can use it to add commands that run after login to macOS user session.
      # 'start-at-login' needs to be 'true' for 'after-login-command' to work
      after-login-command = [];

      # You can use it to add commands that run after AeroSpace startup.
      # 'after-startup-command' is run after 'after-login-command'
      after-startup-command = [];

      # Start AeroSpace at login
      start-at-login = false;

      # Normalizations
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;

      # Layouts
      # The 'accordion-padding' specifies the size of accordion padding
      accordion-padding = 30;

      # Possible values: tiles|accordion
      default-root-container-layout = "tiles";

      # Possible values: horizontal|vertical|auto
      default-root-container-orientation = "auto";

      # Mouse follows focus when focused monitor changes
      on-focused-monitor-changed = ["move-mouse monitor-lazy-center"];

      # You can effectively turn off macOS "Hide application" (cmd-h) feature
      automatically-unhide-macos-hidden-apps = false;

      # Key mapping
      key-mapping = {
        preset = "qwerty";
      };

      # Gaps between windows and monitor edges
      gaps = {
        inner = {
          horizontal = 0;
          vertical = 0;
        };
        outer = {
          left = 0;
          bottom = 0;
          top = 0;
          right = 0;
        };
      };

      # Main binding mode
      mode = {
        main = {
          binding = {
            # Default keybindings would go here
            # Examples:
            "cmd-return" = "exec open -a Terminal";
            "cmd-space" = "exec open -a Spotlight";
            "cmd-q" = "kill";

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

            # Workspaces
            "cmd-1" = "workspace 1";
            "cmd-2" = "workspace 2";
            "cmd-3" = "workspace 3";
            "cmd-4" = "workspace 4";
            "cmd-5" = "workspace 5";
            "cmd-6" = "workspace 6";
            "cmd-7" = "workspace 7";
            "cmd-8" = "workspace 8";
            "cmd-9" = "workspace 9";

            # Move windows to workspaces
            "cmd+shift-1" = "move-node-to-workspace 1";
            "cmd+shift-2" = "move-node-to-workspace 2";
            "cmd+shift-3" = "move-node-to-workspace 3";
            "cmd+shift-4" = "move-node-to-workspace 4";
            "cmd+shift-5" = "move-node-to-workspace 5";
            "cmd+shift-6" = "move-node-to-workspace 6";
            "cmd+shift-7" = "move-node-to-workspace 7";
            "cmd+shift-8" = "move-node-to-workspace 8";
            "cmd+shift-9" = "move-node-to-workspace 9";

            # Layout controls
            "cmd-e" = "layout toggle split";
            "cmd-f" = "fullscreen";
            "cmd+shift-space" = "layout floating";
          };
        };
      };
    };
  };
} 