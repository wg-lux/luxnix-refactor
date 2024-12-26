{
  config,
  inputs,
  pkgs,
  lib,
  ...
}:

with lib;
with lib.luxnix; let
  cfg = config.luxnix.python.sw;
  # we need to find out what system we are working on (eg linux, darwin, ...)
  system = config.system.build.host.system;
  
in {
  options.luxnix.python.sw = with types; {
    enable = mkBoolOpt false "Enable or disable sw python";

    # Other bool options are: enable cuda support for nix packages, add xserver driver, add initrd-kernel-module, addd autoadddriverrunpath
    # enable prime sync, enable modesetting, 
    pythonVersion = mkOption {
      type = types.str;
      default = "312";
      description = "The python version to use";
    };

    # input for nvidia, intel and amd busid
    pythonPackage = mkOption {
      default = pkgs."python${cfg.pythonVersion}Full";
      type = types.package;
      description = "The python package to use";
    };

    pythonPackages = mkOption {
      default = with pkgs."python${cfg.pythonVersion}Packages" ; [
        ansible
        pexpect
      ];
      type = types.listOf types.package;
      description = "The python packages to use";
    };
  };

  config = mkIf cfg.enable {

    environment.systemPackages = [
      cfg.pythonPackage
    ] ++ cfg.pythonPackages;
  };
  
}