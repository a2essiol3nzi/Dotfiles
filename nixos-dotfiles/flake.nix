{
  description = "NixOS by axel";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    # nixpkgs.url = "nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, ... }: {
    nixosConfigurations.ZeNix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit zen-browser; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.axel = import ./home.nix;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit zen-browser; };
          };
        }
      ];
    };
  };
}
