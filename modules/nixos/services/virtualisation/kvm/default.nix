{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
with lib.luxnix; let
  cfg = config.services.virtualisation.kvm;
in {
  options.services.virtualisation.kvm = {
    enable = mkBoolOpt false "enable kvm virtualisation";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      libguestfs
      win-virtio
      win-spice
      virt-manager
      virt-viewer
    ];

    virtualisation = {
      kvmgt.enable = true;
      spiceUSBRedirection.enable = true;

      libvirtd = {
        enable = true;
        allowedBridges = [
          "nm-bridge"
          "virbr0"
        ];
        onBoot = "ignore";
        onShutdown = "shutdown";
        qemu = {
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [pkgs.OVMFFull.fd];
          };
        };
      };
    };
  };
}
