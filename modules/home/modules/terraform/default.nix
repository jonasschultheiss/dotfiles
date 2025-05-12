{pkgs, lib, config, ...}:

with lib;

let
  cfg = config.modules.terraform;
in {
  options.modules.terraform = {
    enable = mkEnableOption "Enable terraform";
    
    enableTerraformDocs = mkEnableOption "Enable terraform-docs for automatic documentation generation";
    
    enableTFLint = mkEnableOption "Enable TFLint for linting Terraform code";
    
    enableCheckov = mkEnableOption "Enable Checkov for security scanning";
    
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      terraform
    ] 
    ++ (optional cfg.enableTerraformDocs terraform-docs)
    ++ (optional cfg.enableTFLint tflint)
    ++ (optional cfg.enableCheckov checkov)
  };
}
