# Basic Home Manager settings for verastalder
{pkgs, ...}: {
  # Import shared configurations
  imports = [
    ../../modules/shared/lunaka-config
  ];
}
