{config, pkgs, ...}@inputs:

{
  luxnix = {
    traefik-host.enable = true;

    nvidia-prime = {
      enable = true; # enables common and desktop (with addon plasma) roles
      nvidiaBusId = "PCI:1:0:0";
      onboardBusId = "PCI:0:2:0";
      onboardGpuType = "intel";
      nvidiaDriver = "beta";
    };

    generic-settings = {
      linux = {
        cpuMicrocode = "intel"; # default is "intel"
        # processorType = "x86_64"; # default
        # kernelPackages = pkgs.linuxPackages_latest; # default
        kernelModules = [ "kvm-intel" ];
        extraModulePackages = []; # default
        initrd = {
          # supportedFilesystems = ["nfs"]; # default
          kernelModules = ["dm-snapshot" ]; # default
          availableKernelModules = [ "vmd" "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
        };

        # supportedFilesystems = ["btrfs"]; # default
        # resumeDevice = "/dev/disk/by-label/nixos"; # default
        # kernelParams = []; # default
        # blacklistedKernelModules = []; # default

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

        

        
    
      };
    };
  };
}