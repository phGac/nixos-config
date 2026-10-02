{ inputs, lib }:

{
  mkSystem =
    {
      hostname,
      users ? [ ],
      system ? "x86_64-linux",
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      stateVersion ? "26.05",
      modules ? [],
    }:

    inputs.nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        ../hosts/${hostname}

        {
          networking.hostName = hostname;
          system.stateVersion = stateVersion;

          users.users = lib.genAttrs users (
            username: {
              isNormalUser = true;
              description = username;
              extraGroups = [ "networkmanager" "wheel" "docker" ];
            }
          );

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;

            users = lib.genAttrs users (
              username: {
                home.stateVersion = stateVersion;
                # home = {
                #   inherit username;
                #   homeDirectory = "/home/${username}";
                #   stateVersion = stateVersion;
                # };

                imports = [
                  ../users/${username}/home.nix
                ];                
              }
            );
          };
        }

        inputs.home-manager.nixosModules.home-manager
      ] ++ modules;
    };
}
