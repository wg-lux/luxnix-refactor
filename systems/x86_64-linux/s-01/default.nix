{
  pkgs,
  lib,
  modulesPath,
  ...
}@inputs: 
  let
    extraImports = [ ];

  in
{

    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
      ./boot-decryption-config.nix
      (import ./disks.nix {})
      (import ./roles.nix {})
      (import ./endoreg.nix {})
      (import ./services.nix {})
      (import ./luxnix.nix {})

    ]++extraImports;




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
