{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    brews = [
      "bat"
      "bottom"
      "broot"
      "cpanm"
      "dog"
      "duf"
      "dust"
      "eslint"
      "exa"
      "exiv2"
      "fd"
      "gh"
      "glow"
      "gnupg"
      "hexyl"
      "htop"
      "httpie"
      "hub"
      "hyperfine"
      "latexindent"
      "llvm"
      "m-cli"
      "mosh"
      "ncdu"
      "nvm"
      "openjdk@11"
      "packer"
      "perl"
      "prettier"
      "procs"
      "python@3.9"
      "release-it"
      "ripgrep"
      "speedtest-cli"
      "svn"
      "tealdeer"
      "terraform"
      "tokei"
      "typescript"
      "vercel-cli"
      "wget"
      "yarn"
    ];
    casks = [
      "1password-cli"
      "appcleaner"
      "brave-browser"
      "deepl"
      "discord"
      "docker"
      "figma"
      "font-geist-mono"
      "font-geist"
      "font-hack-nerd-font"
      "font-hack"
      "font-inter"
      "font-jetbrains-mono-nerd-font"
      "font-jetbrains-mono"
      "font-roboto"
      "github"
      "insomnia"
      "iterm2"
      "malwarebytes"
      "ngrok"
      "notion"
      "postman"
      "raycast"
      "spotify"
      "steam"
      "visual-studio-code"
      "wireshark"
      "zed"
    ];
    taps = [
      "heroku/brew"
      "homebrew/cask-fonts"
    ];
    # masApps = {
    #   # "Fantastical - Calendar & Tasks" = 975937182;
    #   "Magnet" = 441258766;
    #   "Microsoft Excel" = 462058435;
    #   "Microsoft PowerPoint" = 462062816;
    #   "Microsoft Word" = 462054704;
    #   "PDF Expert: PDF bearbeiten" = 1055273043;
    #   "Postico" = 1031280567;
    #   "Slack for Desktop" = 803453959;
    #   "Xcode" = 497799835;
    # };
  };
}
