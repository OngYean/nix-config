{ inputs, ... }:

{
  imports = [
    ./xdg.nix
  ];

  inputs.home-manager.nixosModules.home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
  };
}
