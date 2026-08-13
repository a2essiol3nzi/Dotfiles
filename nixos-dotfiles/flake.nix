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
    hermes-agent = {
      url = "github:NousResearch/hermes-agent";
      # NON follows nixpkgs: hermes potrebbe richiedere una versione specifica
      # motivazione: evitare rotture per via del mismatch tra nixos-26.05 (stabile) e unstable
    };
  };

  outputs = { self, nixpkgs, home-manager, zen-browser, hermes-agent, ... }: {
    nixosConfigurations.ZeNix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit zen-browser hermes-agent; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.axel = import ./home.nix;
            backupFileExtension = "backup";
            extraSpecialArgs = { inherit zen-browser hermes-agent; };
          };
        }
      ];
    };
  };
}
