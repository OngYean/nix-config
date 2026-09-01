{
  inputs = {
    # Use `nix flake update` to update the flake to the latest revision of the chosen release channel.
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    #chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };
  outputs = inputs@{ self, nixpkgs, home-manager, nix-cachyos-kernel, ... }: {
    nixosConfigurations."ongyean-laptop" = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/ongyean-laptop
      ];
    };
  };
}
