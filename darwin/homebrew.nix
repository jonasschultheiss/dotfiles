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
      "angular-cli"
      "bat"
      "bottom"
      "broot"
      "cpanm"
      "dog"
      "duf"
      "dust"
      "eslint"
      "exiv2"
      "eza"
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
      "maven"
      "mosh"
      "ncdu"
      "nvm"
      "openjdk"
      "openjdk@17"
      "packer"
      "perl"
      "pnpm"
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
      "logi-options-plus"
      "malwarebytes"
      "ngrok"
      "notion"
      "postman"
      "raycast"
      "spotify"
      "tableplus"
      "visual-studio-code"
      "wireshark"
      "zed"
      # "steam"
    ];
    taps = [
      "heroku/brew"
      "homebrew/cask-fonts"
    ];
    masApps = {
      "Microsoft Excel" = 462058435;
      "Microsoft PowerPoint" = 462062816;
      "Microsoft Word" = 462054704;
      "Xcode" = 497799835;
    };
  };
}
