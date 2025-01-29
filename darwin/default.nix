{...}: {
  imports = [
    ./macos.nix
    ./homebrew.nix
    ./documentation.nix
  ];

  networking = {
    computerName = "devenv";
    localHostName = "devenv";
    hostName = "devenv";
    knownNetworkServices = ["Wi-Fi" "Thunderbolt Bridge"];
    # dns = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
  };
}
