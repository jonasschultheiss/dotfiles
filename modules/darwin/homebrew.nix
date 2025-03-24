{...}: {
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    brews = [
      # "angular-cli"
      # "asciidoctor"
      # "bat"
      # "bottom"
      # "broot"
      # "duf"
      # "dust"
      # "exiv2"
      # "eza"
      # "fd"
      # "ffmpeg"
      # "gh"
      # "glow"
      # "gnupg"
      # "hexyl"
      # "htop"
      # "httpie"
      # "hub"
      # "hyperfine"
      # "llvm"
      # "maven"
      # "mosh"
      # "mtr"
      # "ncdu"
      # "openjdk"
      # "openjdk@17"
      # "pandoc"
      # "perl"
      # "pnpm"
      # "prettier"
      # "procs"
      # "python@3.9"
      # "speedtest-cli"
      # "tealdeer"
      # "telnet"
      # "tokei"
      # "typescript"
      # "wget"
    ];
    casks = [
      # "1password-cli"
      "appcleaner"
      "brave-browser"
      "cursor"
      "deepl"
      "discord"
      "docker"
      "figma"
      "font-geist"
      "font-geist-mono"
      "font-hack"
      "font-hack-nerd-font"
      "font-inter"
      "font-jetbrains-mono"
      "font-jetbrains-mono-nerd-font"
      "font-roboto"
      "github"
      "insomnia"
      "iterm2"
      "keepassxc"
      "languagetool"
      "linear-linear"
      "logi-options+"
      "malwarebytes"
      "microsoft-teams"
      "ngrok"
      "notion"
      "proton-mail"
      "raycast"
      "spotify"
      "tableplus"
      "teamviewer"
      "todoist"
      "visual-studio-code"
      "whatsapp"
    ];
    masApps = {
      "Microsoft Excel" = 462058435;
      "Microsoft PowerPoint" = 462062816;
      "Microsoft Word" = 462054704;
      "Xcode" = 497799835;
    };
  };
}
