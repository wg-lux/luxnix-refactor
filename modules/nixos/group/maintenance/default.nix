{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.luxnix; let
  cfg = config.group.maintenance;
in {
  options.group.maintenance = with types; {
    name = mkOpt str "maintenance" "The name of the group";
    members = mkOpt (listOf str) [
      "admin"
    ] "Groups for the user to be assigned.";
    gid = mkOpt int 102 "The group id";
  };

  config = {
    users.groups.${cfg.name} =
      {
        name = cfg.name; 
        members = cfg.members;
        gid = cfg.gid;
      };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
