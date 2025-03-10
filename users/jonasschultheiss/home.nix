# Basic Home Manager settings for jonasschultheiss
{pkgs, ...}: {
  # Import shared configurations
  imports = [
    ../../modules/shared/lunaka-config
  ];
}
