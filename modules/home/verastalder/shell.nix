{pkgs, ...}: let
  # Verastalder-specific shell abbreviations
  shellAbbrs = {
    gs = "git status -sb";
    ga = "git add";
    gc = "git commit";
    gcm = "git commit -m";
    gca = "git commit --amend";
    gcl = "git clone";
    gco = "git checkout";
    gp = "git push";
    gpl = "git pull";
    gl = "git l";
    gd = "git diff";
    gds = "git diff --staged";
    gr = "git rebase -i HEAD~15";
    gf = "git fetch --prune";
    gfc = "git findcommit";
    gfm = "git findmessage";
    p = "pnpm";
    y = "yarn";
    reload-switch = "darwin-rebuild switch --flake ~/.config/nixpkgs#system";
  };
in {
  # Import common shell configuration
  imports = [
    ../../../common/shell
  ];

  # Additional Verastalder-specific shell customizations
  programs.fish = {
    inherit shellAbbrs;

    # Additional Verastalder-specific shell aliases
    shellAliases = {
      c = "cd ~/coding";
      cm = "npx npkill";
      h = "cd ~";
      inflate = "ruby -r zlib -e \"STDOUT.write Zlib::Inflate.inflate(STDIN.read)\"";
      dark = "osascript -e 'tell application \"System Events\" to tell appearance preferences to set dark mode to not dark mode'";
    };

    # Additional Verastalder-specific shell init
    shellInit = ''
      # Configure Java
      set -gx CPPFLAGS "-I/opt/homebrew/opt/openjdk@17/include"
      set -gx JAVA_HOME /opt/homebrew/opt/openjdk@17
      set -gx PATH $JAVA_HOME/bin $PATH

      # Configure Chrome
      set -gx CHROME_BIN "/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"

      # Configure PNPM
      set -gx PNPM_HOME "/Users/verastalder/Library/pnpm"
      set -gx PATH "$PNPM_HOME" $PATH

      # Initialize starship
      starship init fish | source

      # Check if NVM has a default version, if not install LTS
      if test -e ~/.nvm/alias/default
        nvm use default >/dev/null 2>&1
      else
        echo "No default Node.js version found. Installing LTS version..."
        # Source NVM and run multiple commands within the same bass call
        bass "source /opt/homebrew/opt/nvm/nvm.sh --no-use && nvm install --lts && nvm alias default 'lts/*' && nvm use default"
      end

      # Set fish syntax highlighting
      set -g fish_color_autosuggestion '555'  'brblack'
      set -g fish_color_cancel -r
      set -g fish_color_command --bold
      set -g fish_color_comment red
      set -g fish_color_cwd green
      set -g fish_color_cwd_root red
      set -g fish_color_end brmagenta
      set -g fish_color_error brred
      set -g fish_color_escape 'bryellow'  '--bold'
      set -g fish_color_history_current --bold
      set -g fish_color_host normal
      set -g fish_color_match --background=brblue
      set -g fish_color_normal normal
      set -g fish_color_operator bryellow
      set -g fish_color_param cyan
      set -g fish_color_quote yellow
      set -g fish_color_redirection brblue
      set -g fish_color_search_match 'bryellow'  '--background=brblack'
      set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
      set -g fish_color_user brgreen
      set -g fish_color_valid_path --underline
    '';

    interactiveShellInit = ''
      # Add keys to SSH agent
      ssh-add -A 2>/dev/null;
    '';

    # Preserve Verastalder's custom functions
    functions = {
      nvm = "bass source /opt/homebrew/opt/nvm/nvm.sh --no-use ';' nvm $argv";
      checkip = "curl checkip.amazonaws.com";
      gfb = ''
        # Check if ticket number was provided
        if test (count $argv) -ne 1
          echo "Please provide a ticket number"
          echo "Usage: fb <ticket-number>"
          return 1
        end

        # Switch to main, fetch, and pull
        git checkout main
        git fetch --prune
        git pull

        # Create and checkout new feature branch
        git checkout -b "feature/SWE-$argv[1]"
      '';

      sync = ''
        # Store current branch name
        git add .
        git stash
        set current_branch (git rev-parse --abbrev-ref HEAD)

        # Fetch and prune
        git fetch --prune

        # Checkout main and pull
        git checkout main
        git pull

        # Return to feature branch and merge
        git checkout $current_branch
        git merge main
        git stash pop

        echo "Synced main into $current_branch"
      '';
    };
  };

  # Preserve Verastalder's starship customizations
  programs.starship.settings = {
    format = "$battery$username$hostname$directory$git_branch$git_state$git_status$cmd_duration$line_break$python$character";

    directory.read_only = " ";
    battery = {
      full_symbol = "•";
      charging_symbol = "⇡";
      discharging_symbol = "⇣";
    };
    git_branch = {
      format = "[$branch]($style)";
      style = "bright-black";
    };
    git_status = {
      format = "[[(*$conflicted$untracked$modified$staged$renamed$deleted)](bright-black)( $ahead_behind$stashed)]($style) ";
      style = "cyan";
      conflicted = "​";
      untracked = "​";
      modified = "​";
      staged = "​";
      renamed = "​";
      deleted = "​";
      stashed = "≡";
    };
    git_state = {
      format = "\([$state( $progress_current/$progress_total)]($style)\) ";
      style = "bright-black";
    };
    cmd_duration = {
      format = "[$duration]($style) ";
      style = "yellow";
    };
  };

  # Verastalder-specific plugins
  programs.fish.plugins = [
    {
      name = "iterm2-shell-integration";
      src = ../iterm2_shell_integration;
    }
    {
      name = "fish-kubectl-completions";
      src = pkgs.fetchFromGitHub {
        owner = "evanlucas";
        repo = "fish-kubectl-completions";
        rev = "ced676392575d618d8b80b3895cdc3159be3f628";
        sha256 = "sha256-OYiYTW+g71vD9NWOcX1i2/TaQfAg+c2dJZ5ohwWSDCc";
      };
    }
    {
      name = "bass";
      src = pkgs.fetchFromGitHub {
        owner = "edc";
        repo = "bass";
        rev = "master";
        sha256 = "0mb01y1d0g8ilsr5m8a71j6xmqlyhf8w4xjf00wkk8k41cz3ypky";
      };
    }
    {
      name = "nix-env";
      src = pkgs.fetchFromGitHub {
        owner = "lilyball";
        repo = "nix-env.fish";
        rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
        sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
      };
    }
  ];

  # Enable zsh as a fallback shell with same aliases
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    history.extended = true;
  };

  # Verastalder-specific packages
  home.packages = with pkgs; [
    # Add any Verastalder-specific packages here
  ];
}
