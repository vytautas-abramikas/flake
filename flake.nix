{
  description = "broliux - NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      rev = "24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: 
  let 
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      aspire = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./modules/machine.nix
          ./modules/system.nix
          home-manager.nixosModules.home-manager
          ./modules/home.nix
        ];
      };
    };
  };
}