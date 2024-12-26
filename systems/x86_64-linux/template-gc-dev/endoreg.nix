{
  sensitive-storage = {
    enable = true; 
    partitionConfigurations = (import ./sensitive-storage.nix {} );
  };
}