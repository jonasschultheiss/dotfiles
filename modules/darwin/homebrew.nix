{...}: {
  homebrew = {
    enable = true;
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    taps = [
      "hashicorp/tap"
      "pulumi/tap"
      "siderolabs/tap"
    ];
    brews = [
      "hashicorp/tap/tfstacks"
      "pulumi/tap/pulumi"
      "ghcup"
      "stylish-haskell"
      "cabal-install"
      "kubernetes-cli"
      "siderolabs/tap/talosctl"
      "cloudflared"
      "helm"
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
      "libreoffice"
      "brave-browser"
      "cursor"
      "deepl"
      "discord"
      "docker-desktop"
      "figma"
      # "font-geist"
      # "font-geist-mono"
      # "font-hack"
      # "font-hack-nerd-font"
      # "font-inter"
      # "font-jetbrains-mono"
      # "font-jetbrains-mono-nerd-font"
      "font-roboto"
      "github"
      "insomnia"
      "iterm2"
      "keepassxc"
      "languagetool-desktop"
      "linear"
      "malwarebytes"
      "microsoft-teams"
      "ngrok"
      "notion"
      "proton-mail"
      "raycast"
      "spotify"
      "tableplus"
      "teamviewer"
      "todoist-app"
      "visual-studio-code"
    ];
    masApps = {
      # "Microsoft Excel" = 462058435;
      # "Microsoft PowerPoint" = 462062816;
      # "Microsoft Word" = 462054704;
      # "Xcode" = 497799835;
    };
  };
}
