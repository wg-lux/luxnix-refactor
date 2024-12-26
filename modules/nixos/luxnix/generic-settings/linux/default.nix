{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.luxnix; let
  cfg = config.luxnix.generic-settings.linux;

in {
  options.luxnix.generic-settings.linux = { 
    kernelPackages = mkOption {
      type = types.package;
      default = pkgs.linuxPackages_latest;
      description = "Use linuxPackages_lates by default";
    };
    supportedFilesystems = mkOption {
      type = types.listOf types.str;
      default = ["btrfs"];
    };
    resumeDevice = mkOption {
      type = types.str;
      default = "/dev/disk/by-label/nixos";
    };
    kernelParams = mkOption {
      types = types.listOf types.str;
      default = [];
      description = "Default Kernel Params";
    };
    blacklistedKernelModules = mkOption {
      types = types.listOf types.str;
      default = [ ];
      description = "Default blacklisted Kernel Modules";
    };
    initrd = {
      supportedFilesystems = mkOption {
        types = types.listOf types.str;
        default = ["nfs"];
        description = "Default supported filesystems for initrd";
      };
      kernelModules = mkOption {
        types = types.listOf types.str;
        default = ["nfs"];
        description = "Default supported Kernel modules for initrd";
      };
    };
  };

  config = mkIf config.luxnix.generic-settings.enable {

    boot = {
      kernelPackages = lib.mkDefault cfg.kernelPackages;
      supportedFilesystems = lib.mkForce cfg.supportedFilesystems;
      resumeDevice = lib.mkDefault cfg.resumeDevice;
      kernelParams = lib.mkDefault cfg.kernelParams;
      blacklistedKernelModules = cfg.blacklistedKernelModules;
      initrd = cfg.initrd;
    };
  };
}

