let
  usb-uuid = "a7df6334-09bf-47dd-b4b9-6bee381a43e4";
  usb-mountpoint = "/mnt/usb_key";
  usb-device = "/dev/disk/by-uuid/a7df6334-09bf-47dd-b4b9-6bee381a43e4";

  bs = 1;
  offset-m = 50;
  offset-b = 52428800;
  keyfile-size = 4096;
in {
  # Ensure necessary kernel modules for USB and LUKS
  boot.initrd.availableKernelModules = [ "dm-crypt" "sd_mod" "usb_storage" ];

  # Use the usb-device as keyFile, with offset and size defined above.
  # Adjust the LUKS device naming to match the updated configuration.
  boot.initrd.luks.devices."cryptroot0" = {
    keyFile        = usb-device;
    keyFileOffset  = offset-b;
    keyFileSize    = keyfile-size;
    preLVM         = true;
    keyFileTimeout = 10;
  };
  boot.initrd.luks.devices."cryptroot1" = {
    keyFile        = usb-device;
    keyFileOffset  = offset-b;
    keyFileSize    = keyfile-size;
    preLVM         = true;
    keyFileTimeout = 10;
  };
  boot.initrd.luks.devices."cryptroot2" = {
    keyFile        = usb-device;
    keyFileOffset  = offset-b;
    keyFileSize    = keyfile-size;
    preLVM         = true;
    keyFileTimeout = 10;
  };
  boot.initrd.luks.devices."cryptroot3" = {
    keyFile        = usb-device;
    keyFileOffset  = offset-b;
    keyFileSize    = keyfile-size;
    preLVM         = true;
    keyFileTimeout = 10;
  };
}
