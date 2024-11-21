{ config, pkgs, ... }:

{
  imports = [ ./macos.nix ./homebrew.nix ];

  networking = {
    computerName = "devenv-pax";
    localHostName = "devenv-pax";
    hostName = "devenv-pax";
    knownNetworkServices = [ "Wi-Fi" "Thunderbolt Bridge" ];
    # dns = [ "1.1.1.1" "1.0.0.1" "2606:4700:4700::1111" "2606:4700:4700::1001" ];
  };
}
