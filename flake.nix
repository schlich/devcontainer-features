{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs =
    { self, nixpkgs }:

    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (
            { config, pkgs, ... }:
            {
              virtualisation.docker.enable = true;
              users.users.schlich.extraGroups = [ "docker" ];
            }
          )
        ];
      };
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nodejs
          deno
          devcontainer
          docker
        ];
      };
    };
}
