# Git configuration for verastalder
{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Vera Stalder";
    userEmail = "vera.stalder@example.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "vim";
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
