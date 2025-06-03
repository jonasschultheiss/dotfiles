final: prev: {
  # Direct override of terraform-providers.proxmox
  terraform-providers =
    prev.terraform-providers
    // {
      proxmox = prev.terraform-providers.proxmox.overrideAttrs (oldAttrs: rec {
        version = "3.0.2-rc01"; # Latest version as of writing - update this periodically
        pname = "terraform-provider-proxmox";

        src = prev.fetchFromGitHub {
          owner = "Telmate";
          repo = "terraform-provider-proxmox";
          rev = "v${version}";
          hash = "sha256-vrlZ2bt2Eczst+Xu5BZZqFp2aJzb1WrHZS/p3f99gRI="; # Update this hash when version changes
        };

        # Ensure we use the correct provider registry info
        provider-source-address = "registry.terraform.io/Telmate/proxmox";

        # Temporary placeholder so evaluation succeeds; rebuild once and Nix will
        # fail with a message that shows the correct hash. Replace it afterwards.
        vendorHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";

        # Update any version constraints
        meta =
          oldAttrs.meta
          // {
            description = "Terraform provider for Proxmox VE (latest version overlay)";
            homepage = "https://github.com/Telmate/terraform-provider-proxmox";
          };
      });
    };
}
