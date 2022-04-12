{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    brews = [
      "auth0"
      "bat"
      "bottom"
      "broot"
      "dog"
      "duf"
      "dust"
      "eslint"
      "exa"
      "fd"
      "glow"
      "heroku"
      "hexyl"
      "htop"
      "httpie"
      "hub"
      "hyperfine"
      "kubernetes-cli"
      "lazydocker"
      "m-cli"
      "microk8s"
      "mosh"
      "ncdu"
      "nvm"
      "prettier"
      "procs"
      "ripgrep"
      "speedtest-cli"
      "starship"
      "svn"
      "tealdeer"
      "tokei"
      "typescript"
      "wget"
      "yarn"
    ];
    casks = [
      "appcleaner"
      "deepl"
      "discord"
      "docker"
      "dropbox"
      "figma"
      "font-hack-nerd-font"
      "font-hack"
      "font-inter"
      "font-jetbrains-mono-nerd-font"
      "font-jetbrains-mono"
      "font-roboto"
      "insomnia"
      "iterm2"
      "ngrok"
      "notion"
      "postman"
      "spotify"
      "steam"
      "visual-studio-code"
    ];
    taps = [
      "auth0/auth0-cli"
      "heroku/brew"
      "homebrew/cask-fonts"
      "ubuntu/microk8s"
    ];
    masApps = {
      "1Password 7 - Password Manager" = 1333542190;
      "Alfred" = 405843582;
      "Amphetamine" = 937984704;
      "Jira Cloud by Atlassian" = 1475897096;
      "Magnet" = 441258766;
      "Microsoft Excel" = 462058435;
      "Microsoft PowerPoint" = 462062816;
      "Microsoft Word" = 462054704;
      "PDF Expert: PDF bearbeiten" = 1055273043;
      "Postico" = 1031280567;
      "Slack for Desktop" = 803453959;
      "Xcode" = 497799835;
    };
  };
}
