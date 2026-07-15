{pkgs, ...}: {
  imports = [
    ./git
    ./shell.nix
    # ./applications.nix
    # ./modules/terraform
  ];

  # Enable Terraform module
  # modules.terraform = {
  #   enable = true;
  #   enableTerraformDocs = true;
  #   enableTFLint = true;
  #   enableCheckov = true;
  # };

  home.sessionVariables = {
    JAVA_HOME = "${pkgs.openjdk}";
    # ANDROID_SDK_ROOT = "$HOME/Library/Android/sdk";
  };

  home.sessionPath = [
    "$HOME/Library/Python/3.10/bin"
    #   "/usr/local/texlive/2022"
    #   "$ANDROID_SDK_ROOT/emulator"
    #   "$ANDROID_SDK_ROOT/platform-tools"
  ];

  home.packages = with pkgs; [
    _1password-cli
    # _1password-guida
    bat
    bottom
    broot
    comma # any cli you may need
    duf
    dust
    exiv2
    eza
    fd
    ffmpeg
    gh
    glow
    helm-docs
    gnupg
    hexyl
    home-manager # system package manager
    htop
    httpie
    hub
    hyperfine
    manix
    maven
    mosh
    mtr
    ncdu
    rustup
    nodejs
    telegram-desktop
    pnpm
    prettier
    typescript
    openjdk
    pandoc
    procs
    python3
    ripgrep
    wireshark
    speedtest-cli
    tealdeer
    texlive.combined.scheme-full
    tokei
    wget
    sherlock
    poppler-utils
    # Old casks
    # appcleaner
    raycast
    tenv
    ghc
    hlint
    # Nix tooling
    alejandra # Nix formatter
    # statix    # Nix linter
    deadnix # Find unused code/variables in Nix
    nixd # Nix language server - replacing nil
    nix-prefetch-github # For updating terraform provider overlays
    ghostscript
    google-chrome
    packer
  ];

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # The shell configuration has been moved to modules/darwin/system.nix
}
