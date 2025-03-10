{...}: {
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    brews = [
      "asciidoctor"
      "bat"
      "bottom"
      "broot"
      "cpanm"
      "duf"
      "dust"
      "eslint"
      "exiv2"
      "eza"
      "fd"
      "ffmpeg"
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
      "mtr"
      "ncdu"
      "nvm"
      "openjdk"
      "perl"
      "pnpm"
      "prettier"
      "procs"
      "python@3.9"
      "ripgrep"
      "speedtest-cli"
      "svn"
      "tealdeer"
      "telnet"
      "texlive"
      "tokei"
      "typescript"
      "wget"
    ];
    casks = [
      "1password-cli"
      "1password"
      "appcleaner"
      "brave-browser"
      "cursor"
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
      "languagetool"
      "linear-linear"
      "linear-linear"
      "logi-options+"
      "malwarebytes"
      "ngrok"
      "notion"
      "proton-mail"
      "raycast"
      "spotify"
      "tableplus"
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
