{
  config,
  lib,
  ...
}:
with lib;
with lib.luxnix; let
  cfg = config.security.sops;

  # CHANGEME Enable sops
in {
  options.security.sops = with types; {
    enable = mkBoolOpt false "Whether to enable sop for secrets management.";
  };

  config = mkIf cfg.enable {
    sops = {
      age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    };
  };
}
