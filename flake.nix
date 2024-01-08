{
    description = " nix config for my server running on an old xeon x5650";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/23.11";
    };

    outputs = { self, nixpkgs } @inputs: {
        nixosConfigurations = {
            jokedotenterprises = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                specialArgs = inputs;
                modules = [ ./configuration.nix ];
            };
        };
    };
}
