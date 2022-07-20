{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    brews = [
      "llvm"
      "heroku-node"
      "python@3.9"
      "cocoapods"
      "swagger-codegen"
      "nats-io/nats-tools/nats"
      "auth0"
      "starship"
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
      "svn"
      "tealdeer"
      "tokei"
      "typescript"
      "wget"
      "yarn"
      "redis"
      "release-it"
      "openjdk@11"
    ];
    casks = [
      "malwarebytes"
      "wireshark"
      "alfred"
      "appcleaner"
      "brave-browser"
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
      "github"
      "insomnia"
      "iterm2"
      "ngrok"
      "notion"
      "postman"
      "spotify"
      "steam"
      "visual-studio-code"
      "react-native-debugger"
    ];
    taps = [
      "auth0/auth0-cli"
      "heroku/brew"
      "homebrew/cask-fonts"
      "ubuntu/microk8s"
      "homebrew/cask"
      "nats-io/nats-tools"
    ];
    masApps = {
      "1Password 7 - Password Manager" = 1333542190;
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
