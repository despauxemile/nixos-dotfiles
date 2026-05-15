{
  description = "milou's nixos configs";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
      };
    in
    {
      nixosConfigurations.lab = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/lab/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit pkgs-unstable; };
              users.milou = import ./home/lab.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };

      nixosConfigurations.xps = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/xps/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit pkgs-unstable; };
              users.milou = import ./home/xps.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };

      nixosConfigurations.desk = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/desk/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit pkgs-unstable; };
              users.milou = import ./home/desk.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
}
