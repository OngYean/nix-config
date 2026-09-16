{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    pinnedPkgs.url = "github:NixOS/nixpkgs/8ce4ef6cb6f871616146b9fe26d2a5ae594e94fe";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    lanzaboote.url = "github:nix-community/lanzaboote/v1.1.0";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nixpkgs, pinnedPkgs, home-manager, chaotic, lanzaboote, ... }: {
    nixosConfigurations."ongyean-laptop" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/ongyean-laptop
        {
          nixpkgs.overlays = [(final: prev: {
            linux-firmware = pinnedPkgs.legacyPackages.x86_64-linux.linux-firmware;
          })];
        }
      ];
    };
  };
}
