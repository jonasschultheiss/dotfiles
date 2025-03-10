{...}: {
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    brews = [
      "texlive"
      "mtr"
      "latexindent"
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
      "tokei"
      "typescript"
      "wget"
    ];
    casks = [
      "proton-mail"
      "1password-cli"
      "appcleaner"
      "brave-browser"
      "cursor"
      "discord"
      "todoist"
      "deepl"
      "whatsapp"
      "docker"
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
      "languagetool"
      "linear-linear"
      "logi-options+"
      "malwarebytes"
      "ngrok"
      "notion"
      "raycast"
      "spotify"
      "tableplus"
      "linear-linear"
      "visual-studio-code"
      "font-geist-mono"
      "font-geist"
    ];
    masApps = {
      "Microsoft Excel" = 462058435;
      "Microsoft PowerPoint" = 462062816;
      "Microsoft Word" = 462054704;
      "Xcode" = 497799835;
    };
  };
}
