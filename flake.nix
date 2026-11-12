{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # nixpkgs pin for music production packages
    nixpkgs-old.url = "github:NixOS/nixpkgs/55bfb4d7437bd4e09ab7cba58a43bd68eb310044";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:nix-community/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    lanzaboote.url = "github:nix-community/lanzaboote/v1.1.0";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";

    kwin-effects-glass.url = "github:4v3ngR/kwin-effects-glass";
    kwin-effects-glass.inputs.nixpkgs.follows = "nixpkgs";

    macshell-kwin.url = "github:OngYean/MacShell-KWin/pending-test";
    macshell-kwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nixpkgs, nixpkgs-old, home-manager, plasma-manager, chaotic, lanzaboote, kwin-effects-glass, macshell-kwin, ... }: {
    nixosConfigurations."ongyean-laptop" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/ongyean-laptop
        ./home-modules/common
      ];
    };

    nixosConfigurations."ongyean-pc" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/ongyean-pc
        ./home-modules/common
      ];
    };
  };
}
