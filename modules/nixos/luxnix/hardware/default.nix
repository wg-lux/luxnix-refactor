{
  lib,
  pkgs,
  config,
  ...
}:
with lib; 
with lib.luxnix; let
  cfg = config.luxnix.hardware;
in {
  options.luxnix.hardware = {
    enable = mkEnableOption "Enable Default Hardware configuration";
    processorType = mkOption {
      type = types.str;
    };
  };


  config = mkIf cfg.enable {
    
    hardware.cpu."${cfg.processorType}".updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };
}
