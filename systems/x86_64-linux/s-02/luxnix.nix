{config, pkgs, ...}@inputs:

{
  generic-settings = {
    linux = {
      # systemConfigurationPath = "${luxnixDirectory}/nixos-configurations
      # sensitiveServiceGroupName = "sensitive-service-group"; # is default
      # hostPlatform = "x86_64-linux"; # is default
      # sensitiveServiceGID = 901; # is default

      # Default
      # postgres = rec {
      #   defaultAuthentication = ''
      #       #type database                  DBuser                      address                     auth-method         optional_ident_map
      #       local sameuser                  all                                                     peer                map=superuser_map
      #   '';
      #   activeAuthentication = config.luxnix.generic-settings.postgres.defaultAuthentication;
      #   defaultIdentMap = ''
      #     # ArbitraryMapName systemUser DBUser
      #     superuser_map      root      postgres
      #     superuser_map      root      ${config.roles.postgres.default.replUser}
      #     superuser_map      ${config.user.admin.name}     postgres
      #     superuser_map      postgres  postgres
      #   '';
      #   activeIdentMap = config.luxnix.generic-settings.postgres.defaultIdentMap;
      # };

      # sslCertificateKeyPath = "${systemConfigurationPath}/ssl/cert.key";
      # sslCertificatePath = "${systemConfigurationPath}/ssl/cert.pem";

      cpuMicrocode = "intel"; # default is "intel"
      # processorType = "x86_64"; # default
      # kernelPackages = pkgs.linuxPackages_latest; # default
      kernelModules = [ "kvm-intel" ];
      extraModulePackages = []; # default
      # supportedFilesystems = ["btrfs"]; # default
      # resumeDevice = "/dev/disk/by-label/nixos"; # default
      # kernelParams = []; # default
      # blacklistedKernelModules = []; # default
      initrd = {
        # supportedFilesystems = ["nfs"]; # default
        # kernelModules = ["nfs"]; # default
        availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
      };
  
    };
  };
}