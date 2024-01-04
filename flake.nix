{
    description = " nix config for my server running on an old xeon x5650";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/23.05";
    };

    outputs = { self, nixpkgs } @inputs: {
        nixosConfigurations = {
            nixos-x5650 = nixpkgs.lib.nixosSystem {
                system = "x86_x64-linux";
                specialArgs = inputs;
                modules = [ ./configuration.nix ];
            };
        };
    };
}
