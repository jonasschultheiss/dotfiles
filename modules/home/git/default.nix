{pkgs, ...}: {
  home.packages = with pkgs; [
    diff-so-fancy
    tig
    gh
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIEkKRKYGIagUWR53s7ZH5lrn7O1ALWqbjALwrIm13Rv";
      format = "ssh";
      signByDefault = true;
    };

    ignores = [
      ".cache/"
      ".DS_Store"
      ".idea/"
      "*.swp"
      "npm-debug.log*"
      "yarn-debug.log*"
      "yarn-error.log*"
      ".pnpm-debug.log*"
      ".vscode/"
      "node_modules/"
      "dist/"
      "build/"
      ".env"
      ".env.local"
    ];

    settings = {
      user = {
        name = "jonasschultheiss";
        email = "complaint@jonasschultheiss.dev";
      };

      alias = {
        l = "log --pretty=oneline -n 50 --graph --abbrev-commit";
        save = "!git add -A && git commit -v -m 'SAVEPOINT'";
        undo = "reset HEAD~1 --mixed";
        wipe = "!git add -A && git commit --no-gpg-sign -qm 'WIPE SAVEPOINT' --no-verify && git reset HEAD~1 --hard";
        findcommit = "!f() { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short -S$1; }; f";
        findmessage = "!f() { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short --grep=$1; }; f";
      };

      commit = {
        gpgsign = true;
        template = builtins.toPath ./git-message;
      };

      gpg = {
        format = "ssh";
        ssh = {
          program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
          allowedSignersFile = builtins.toPath ./allowed-signers;
        };
      };

      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };

      core = {
        editor = "cursor --wait";
        pager = "diff-so-fancy | less --tabs=4 -RFX";
        excludesfile = "~/.gitignore";
      };

      column.ui = "auto";
      branch.sort = "-committerdate";
      tag.sort = "version:refname";
      init.defaultBranch = "main";

      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };

      help.autocorrect = "prompt";

      rerere = {
        enabled = true;
        autoupdate = true;
      };

      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };

      pull.rebase = true;
      color.ui = true;

      "color \"diff-highlight\"" = {
        oldNormal = "red bold";
        oldHighlight = "red bold 52";
        newNormal = "green bold";
        newHighlight = "green bold 22";
      };

      "color \"diff\"" = {
        frag = "magenta bold";
        old = "red bold";
        new = "green bold";
        whitespace = "red reverse";
      };
    };
  };
}
