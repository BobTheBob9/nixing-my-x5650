{ config, pkgs, ... }:
{
    # nix settings
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nix.settings.auto-optimise-store = true;

    # bootloader
    boot.loader.grub.enable = true;
    boot.loader.grub.version = 2;
    boot.loader.grub.efiSupport = false;
    boot.loader.grub.device = "/dev/sda"; # todo: check

    # net
    networking.hostName = "joke.enterprises";
    networking.interfaces.eth0.ipv4.addresses = [ {
        address = "192.168.1.2";
        prefixLength = 24;
    } ];
    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [
        22 ## ssh
    ];

    # important stuff
    services.openssh.enable = true;
    services.openssh.permitRootLogin = "yes";
    services.openssh.allowSFTP = true;

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
}
