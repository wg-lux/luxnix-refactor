{
  config,
  lib,
  ...
}:
with lib;
with lib.luxnix; let
  cfg = config.cli.programs.nh;
in {
  options.cli.programs.nh = with types; {
    enable = mkBoolOpt false "Whether or not to enable nh (nix commandline helper).";
    luxnixDirectory = mkOption {
      type = types.str;
      default = config.luxnix.generic-settings.configurationPath;
      description = "The directory where nh expects the luxnix repository";
    };
  };

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = cfg.luxnixDirectory;
    };
  };
}
