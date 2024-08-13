{
  description = "Paradise NixOS (fredamaral config)";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    agenix,
    stylix,
    ...
  } @ inputs: let
    user = "fredamaral";
    system = ["x86_64-linux" "aarch64-linux"];
    machines = {
      desktop = "megaman";
      laptop-nixos = "bomberman";
      laptop-macos = "sonic";
      homelab = "zelda";
    };
    domain = "fredamaral.com";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    mkSystem = hostname: system: extraModules:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user hostname domain system;} // machines;
        modules =
          [
            ./system/hosts/${hostname}/configuration.nix
            ./system/common/default.nix
            stylix.nixosModules.stylix
            agenix.nixosModules.default
          ]
          ++ extraModules;
      };

    mkHome = hostname: system:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {inherit inputs hostname user;} // machines;
        modules = [
          ./home/${hostname}.nix
        ];
      };
  in {
    formatter = pkgs.alejandra;

    nixosConfigurations = {
      ${machines.desktop} = mkSystem machines.desktop "x86_64-linux" [];
      ${machines.laptop-nixos} = mkSystem machines.laptop-nixos "aarch64-linux" [];
      ${machines.laptop-macos} = mkSystem machines.laptop-macos "aarch64-linux" [];
    };

    homeConfigurations = {
      ${machines.desktop} = mkHome machines.desktop "x86_64-linux";
      ${machines.laptop-nixos} = mkHome machines.laptop-nixos "aarch64-linux";
      ${machines.laptop-macos} = mkHome machines.laptop-macos "aarch64-linux";
    };
  };
}
