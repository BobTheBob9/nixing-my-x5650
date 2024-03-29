{ config, pkgs, ... }:
{
    imports = [ ./hardware-configuration.nix ];

    # nix settings
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.auto-optimise-store = true;

    # bootloader
    boot.loader.grub.enable = true;   
    boot.loader.grub.efiSupport = false;
    boot.loader.grub.device = "/dev/sda"; # todo: check

    # net
    networking.hostName = "jokedotenterprises";
    networking.interfaces.enp5s0.useDHCP = true;
    networking.interfaces.enp5s0.ipv4.addresses = [ {
        address = "192.168.0.99";
        prefixLength = 24;
    } ];

    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [ 80 ];

    # important stuff
    services.openssh.enable = true;
    services.openssh.permitRootLogin = "yes";
    services.openssh.allowSFTP = true;
    services.openssh.openFirewall = true;

    # britain
    time.timeZone = "Europe/London";

    i18n.defaultLocale = "en_GB.UTF-8";
    i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_GB.UTF-8";
        LC_IDENTIFICATION = "en_GB.UTF-8";
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_MONETARY = "en_GB.UTF-8";
        LC_NAME = "en_GB.UTF-8";
        LC_NUMERIC = "en_GB.UTF-8";
        LC_PAPER = "en_GB.UTF-8";
        LC_TELEPHONE = "en_GB.UTF-8";
        LC_TIME = "en_GB.UTF-8";
    };

    console.keyMap = "uk";

    environment.systemPackages = [ 
        pkgs.neofetch
        pkgs.neovim
    ];

    services.static-web-server = {
        enable = true;
        listen = "[::]:80";
        root = "/web";
        configuration.general.directory-listing = true;
    };

    services.minecraft-server = {
        enable = true;
        eula = true;
        openFirewall = true;
        declarative = true;
        serverProperties.server-port = 25565;
        serverProperties.online-mode = false;

        package = let
            version = "b1.7.3";
            url = "http://files.betacraft.uk/server-archive/beta/b1.7.3.jar";
            sha256 = "0kdsg579ar793bqwz8a249sm6gas624rqdhmiw1hp9i599z14fh3";
        in ( pkgs.minecraftServers.vanilla-1-2.overrideAttrs ( old: rec {
            inherit version;
            name = "minecraft-server_${version}";
            src = pkgs.fetchurl { inherit url sha256; };
        }));
    };

    system.stateVersion = "23.05";
}

