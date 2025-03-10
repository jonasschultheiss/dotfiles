{
  config,
  lib,
  pkgs,
  currentUser,
  currentComputer,
  ...
}: {
  # Assertions are now handled by the config-validation module

  system.defaults = {
    LaunchServices = {
      LSQuarantine = false;
    };

    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = false;
      AppleKeyboardUIMode = 3;
      AppleMeasurementUnits = "Centimeters";
      AppleMetricUnits = 1;
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "Automatic";
      AppleTemperatureUnit = "Celsius";
      InitialKeyRepeat = 15;
      KeyRepeat = 1;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSDisableAutomaticTermination = true;
      NSDocumentSaveNewDocumentsToCloud = false;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      NSTableViewDefaultSizeMode = 1;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
    };

    SoftwareUpdate = {
      AutomaticallyInstallMacOSUpdates = true;
    };

    alf = {
      globalstate = 1;
      stealthenabled = 1;
    };

    dock = {
      # TODO: Fix these
      # autohide-delay = "0";
      # autohide-time-modifier = "1";
      autohide = true;
      orientation = "left";
      showhidden = true;
      show-recents = false;
      static-only = true;
      tilesize = 32;
      launchanim = false;
      mru-spaces = false;
    };

    finder = {
      AppleShowAllFiles = true;
      ShowPathbar = true;
      AppleShowAllExtensions = true;
      FXEnableExtensionChangeWarning = false;
      CreateDesktop = false;
    };

    loginwindow = {
      GuestEnabled = false;
      DisableConsoleAccess = true;
    };

    # Dynamic screenshot location based on user
    screencapture = {
      location = "/Users/${currentUser.username}/screenshots";
    };

    # Dynamic SMB settings based on computer
    smb = {
      NetBIOSName = currentComputer.hostName;
      ServerDescription = currentComputer.hostName;
    };
  };

  # Create the screenshots directory if it doesn't exist
  system.activationScripts.screenshotDir = {
    enable = true;
    text = ''
      # Create screenshots directory for the current user
      USERNAME="${currentUser.username}"
      SCREENSHOT_DIR="/Users/$USERNAME/screenshots"

      if [ ! -d "$SCREENSHOT_DIR" ]; then
        echo "Creating screenshots directory at $SCREENSHOT_DIR"
        mkdir -p "$SCREENSHOT_DIR"
        chown "$USERNAME:staff" "$SCREENSHOT_DIR"
      fi
    '';
  };
}
