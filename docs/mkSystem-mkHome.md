# mkSystem.nix y mkHome.nix

## Qué son

`mkSystem.nix` y `mkHome.nix` son funciones reutilizables que sirven para construir configuraciones de NixOS y Home Manager sin repetir la misma lógica en cada máquina o usuario.

La idea es centralizar la estructura común y luego configurarlo por caso concreto.

---

## 1) `mkSystem.nix`

### Objetivo

Genera una configuración de sistema NixOS a partir de:

- nombre del host
- arquitectura
- módulos a cargar
- usuario principal
- cualquier opción común compartida

### Ejemplo real de uso

```nix
# lib/mkSystem.nix
{ nixpkgs, home-manager, ... }:

{ hostName
, system ? "x86_64-linux"
, user ? "tato"
, modules ? [ ]
, extraSpecialArgs ? { }
}:

nixpkgs.lib.nixosSystem {
  inherit system;

  specialArgs = {
    inherit user;
  } // extraSpecialArgs;

  modules = [
    {
      networking.hostName = hostName;
      users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "docker" ];
      };
    }
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${user} = import ../users/${user}/home.nix;
    }
  ] ++ modules;
}
```

### Cómo se usa en el flake

```nix
# flake.nix
let
  mkSystem = import ./lib/mkSystem.nix { inherit nixpkgs home-manager; };
in {
  nixosConfigurations = {
    desktop = mkSystem {
      hostName = "desktop";
      system = "x86_64-linux";
      user = "tato";
      modules = [
        ./hosts/desktop/default.nix
        ./modules/common
        ./modules/desktop
      ];
    };

    laptop = mkSystem {
      hostName = "laptop";
      system = "x86_64-linux";
      user = "tato";
      modules = [
        ./hosts/laptop/default.nix
        ./modules/common
        ./modules/dev
      ];
    };
  };
}
```

### Qué resuelve

- no repites el bloque `nixosSystem` cada vez
- no repites la creación del usuario `tato`
- no repites `home-manager.nixosModules.home-manager`
- cada host solo agrega lo que cada máquina necesita

---

## 2) `mkHome.nix`

### Objetivo

Genera una configuración de Home Manager para un usuario, con perfiles reutilizables y una base común.

### Ejemplo real de uso

```nix
# lib/mkHome.nix
{ home-manager, ... }:

{ username
, homeDirectory
, extraModules ? [ ]
, extraSpecialArgs ? { }
}:

home-manager.lib.homeManagerConfiguration {
  inherit username homeDirectory;

  extraSpecialArgs = extraSpecialArgs;

  modules = [
    {
      home.username = username;
      home.homeDirectory = homeDirectory;
      home.stateVersion = "26.05";
      programs.home-manager.enable = true;
    }
    ./users/${username}/profiles/base.nix
  ] ++ extraModules;
}
```

### Cómo se usa

```nix
# flake.nix
let
  mkHome = import ./lib/mkHome.nix { inherit home-manager; };
in {
  homeConfigurations = {
    "tato@desktop" = mkHome {
      username = "tato";
      homeDirectory = "/home/tato";
      extraModules = [
        ./users/tato/profiles/dev.nix
        ./users/tato/profiles/gaming.nix
      ];
    };

    "tato@laptop" = mkHome {
      username = "tato";
      homeDirectory = "/home/tato";
      extraModules = [
        ./users/tato/profiles/dev.nix
        ./users/tato/profiles/internet.nix
      ];
    };
  };
}
```

### Qué resuelve

- evita duplicar `home.username`, `home.homeDirectory`, `stateVersion`
- reusa perfiles del usuario (`base`, `dev`, `gaming`, etc.)
- hace que el mismo usuario pueda tener distintos ambientes según la máquina

---

## 3) Por qué esto es útil en tu repo

Tu configuración actual ya tiene una buena base, pero tiene un patrón repetitivo:

- en el flake se repite el setup de Home Manager
- en el host se repite la definición del usuario
- cada equipo que agregues puede terminar con lógica duplicada

`mkSystem` y `mkHome` evitan precisamente eso.

---

## 4) Cómo encajan en la arquitectura recomendada

La estructura ideal quedaría así:

```text
nixos/
  flake.nix
  lib/
    mkSystem.nix
    mkHome.nix
  hosts/
    desktop/
      default.nix
    laptop/
      default.nix
  modules/
    common/
    desktop/
    dev/
    services/
  users/
    tato/
      home.nix
      profiles/
        base.nix
        dev.nix
        gaming.nix
        internet.nix
```

Con esto:

- `mkSystem` construye cada máquina
- `mkHome` construye cada perfil del usuario
- cada host usa solo los módulos que necesita
- cada usuario puede tener distintas combinaciones de perfiles

---

## 5) Ejemplo de perfil de usuario real

```nix
# users/tato/profiles/base.nix
{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    git
    vim
    unzip
    wget
    kitty
  ];

  programs.zsh.enable = true;
  programs.git = {
    enable = true;
    userName = "tato";
    userEmail = "tato@example.com";
  };
}
```

```nix
# users/tato/profiles/dev.nix
{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs_22
    yarn
    bruno
    vscode
  ];
}
```

```nix
# users/tato/profiles/gaming.nix
{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    steam
    protonup-qt
    solaar
  ];
}
```

Y en el flake solo los activas según el equipo o el caso de uso.

---

## 6) Regla de oro

`mkSystem` y `mkHome` no son para “hacer magia”, sino para:

- poner la lógica común en un solo lugar
- dejar el flake más legible
- hacer que cada host y cada usuario sea más declarativo

Si un host o perfil se repite, conviene encapsularlo en helper.

---

## 7) Conclusión

`mkSystem.nix` y `mkHome.nix` son funciones de apoyo que te permiten:

- crear NixOS configs más limpias
- crear Home Manager configs más reutilizables
- manejar varios equipos con una estructura ordenada
- reducir duplicación y errores

En resumen:

- `mkSystem` = crea una máquina
- `mkHome` = crea un usuario

Son una buena práctica cuando te quieres mover de una configuración simple a una arquitectura escalable y mantenible.
