{
  pkgs,
  lib,
  ...
}@inputs: 
  let
    sensitiveHdd = import ./sensitive-hdd.nix {};
    roles = import ./roles.nix;
    endoreg = import ./endoreg.nix;
    boot = import ./boot.nix;
    luxnixNvidiaPrime = import ./luxnix.nvidia-prime-settings.nix; 
    services = import ./services.nix;
    luxnixHardware = import ./luxnix.hardware.nix;

    extraImports = [
      ./boot-decryption-config.nix
    ];

  in
{
  imports = [
    # ./hardware-configuration.nix
    ./disks.nix
  ]++extraImports;


  

  ##### CUSTOMIZE ######
  luxnix.hardware = luxnixHardware;  
  luxnix.nvidia-prime = luxnixNvidiaPrime;


  services = services;
  boot = boot;
  roles = roles;
  endoreg = endoreg;

  user = {
    admin = {
      name = "admin";
    };
    ansible.enable = true;
    settings.mutable = false;
  };


  system.stateVersion = "23.11";
}
