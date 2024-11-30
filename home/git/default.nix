{ pkgs, ... }:

{
  home.packages = with pkgs.gitAndTools; [
    diff-so-fancy
    tig
    gh
  ];

  programs.git = {
    enable = true;
    userName = "Jonas Schultheiss";
    userEmail = "complaint@jonasschultheiss.dev";
    package = pkgs.gitAndTools.gitFull;

    signing = {
      key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIEkKRKYGIagUWR53s7ZH5lrn7O1ALWqbjALwrIm13Rv";

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
    ];

    aliases = {
      l = "log --pretty=oneline -n 50 --graph --abbrev-commit";
      save = "!git add -A && git commit -v -m 'SAVEPOINT'";
      undo = "reset HEAD~1 --mixed";
      wipe = "!git add -A && git commit --no-gpg-sign -qm 'WIPE SAVEPOINT' --no-verify && git reset HEAD~1 --hard";
      findcommit = "!f() { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short -S$1; }; f";
      findmessage = "!f() { git log --pretty=format:'%C(yellow)%h  %Cblue%ad  %Creset%s%Cgreen  [%cn] %Cred%d' --decorate --date=short --grep=$1; }; f";
    };

    extraConfig = {
      # SSH signing
      # test
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      gpg.ssh.allowedSignersFile = builtins.toPath ./allowed-signers;

      commit.template = builtins.toPath ./git-message;

      # If no upstream branch is specified, push to the branch with the same
      # name as the current branch
      push.default = "current";

      core = {
        editor = "cursor --wait";
        pager = "diff-so-fancy | less --tabs=4 -RFX";
      };

      init.defaultBranch = "main";
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
