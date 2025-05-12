{pkgs, ...}: {
  imports = [
    ./git
    ./shell.nix
    # ./applications.nix
    ./modules/terraform
  ];

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
    # _1password-gui
    asciidoctor
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
    nodejs
    nodejs
    nodePackages."@angular/cli"
    nodePackages.pnpm
    nodePackages.prettier
    nodePackages.typescript
    nodePackages."@nestjs/cli"
    openjdk
    pandoc
    procs
    python310
    ripgrep
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
    pip
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
