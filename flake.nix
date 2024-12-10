{
  description = "broliux - NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }: 
  let 
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      aspire = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./modules/machine.nix
          ./modules/system.nix
        ];
      };
    };
  };
}