{
  pkgs,
  lib,
  ...
}: {
  # Temporarily removed common git configuration import

  # Complete git configuration for verastalder
  programs.git = {
    enable = true;
    userName = "Vera Stalder";
    userEmail = "vera.stalder@example.com"; # Replace with actual email

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "vim";

      # Common aliases
      alias = {
        l = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
        s = "status -s";
        co = "checkout";
        cob = "checkout -b";
        del = "branch -D";
        br = "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative))' --sort=-committerdate";
        save = "!git add -A && git commit -m 'chore: savepoint'";
        undo = "reset HEAD~1 --mixed";
        res = "!git reset --hard";
        done = "!git push origin HEAD";
        lg = "!git log --pretty=format:\"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]\" --abbrev-commit -30";
      };

      # User-specific extra configuration
      # github.user = "verastalder";
      # credential.helper = "osxkeychain";
    };

    # Enable delta for better diffs
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "GitHub";
        side-by-side = true;
      };
    };

    # Enable git-lfs
    lfs.enable = true;

    # Common ignore patterns
    ignores = [
      ".DS_Store"
      "*.log"
      ".idea/"
      ".vscode/"
      "node_modules/"
      "dist/"
      "build/"
      ".env"
      ".env.local"
      "*.swp"
      "*.swo"
    ];
  };
}
