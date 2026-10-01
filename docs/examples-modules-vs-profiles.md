# Ejemplos prácticos: modules vs profiles y configuración de GPU

## 1. Diferencia básica

La idea central es esta:

- `modules/...` = configuración del sistema o de la máquina
- `users/.../profiles/...` = configuración del usuario

### Ejemplo de módulo del sistema

```nix
# modules/desktop/graphics.nix
{ config, pkgs, lib, ... }:
{
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
}
```

Esto afecta a la máquina completa.

### Ejemplo de perfil del usuario

```nix
# users/tato/profiles/base.nix
{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    firefox
    kitty
    git
  ];
}
```

Esto afecta al usuario `tato` y su entorno gráfico.

---

## 2. Ejemplo real de `modules/desktop/gaming.nix`

```nix
# modules/desktop/gaming.nix
{ config, pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true;

  services.logiops.enable = true;
}
```

### ¿Qué va aquí?

- Steam del sistema
- soporte de juegos
- hardware de juego
- controladores
- servicio del sistema que debe existir para toda la máquina

Esto no es configuración de usuario. Es de la máquina.

---

## 3. Ejemplo real de `users/tato/profiles/gaming.nix`

```nix
# users/tato/profiles/gaming.nix
{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    protonup-qt
    heroic
    lutris
  ];
}
```

### ¿Qué va aquí?

- apps del usuario para jugar
- lanzadores y utilidades personales
- herramientas que el usuario quiere instalar en su perfil

Esto no afecta a toda la máquina, sino al entorno del usuario.

---

## 4. Ejemplo real de `modules/desktop/graphics.nix`

Aquí es donde normalmente va la tarjeta gráfica.

### Caso A: NVIDIA

```nix
# modules/desktop/graphics.nix
{ config, pkgs, lib, ... }:
{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}
```

### Caso B: AMD

```nix
# modules/desktop/graphics.nix
{ config, pkgs, lib, ... }:
{
  services.xserver.videoDrivers = [ "amdgpu" ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
```

### Caso C: Intel integrado

```nix
# modules/desktop/graphics.nix
{ config, pkgs, lib, ... }:
{
  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
```

---

## 5. ¿Dónde va exactamente la configuración de la GPU?

La respuesta corta:

- va en `modules/desktop/graphics.nix` o un módulo equivalente del sistema
- no va en `users/.../profiles/...`

Porque la GPU:

- define el controlador gráfico del sistema
- afecta a X11/Wayland
- afecta a OpenGL/Vulkan
- depende de la máquina concreta
- puede cambiar de un equipo a otro

Por eso es una configuración del host, no del usuario.

---

## 6. Cómo organizarlo bien para varios equipos

La regla útil es:

- cada host puede importar un módulo gráfico distinto
- cada máquina define qué GPU tiene y qué driver hay que usar

Ejemplo:

```text
hosts/
  desktop/
    default.nix
  laptop/
    default.nix
```

### `hosts/desktop/default.nix`

```nix
{ config, pkgs, ... }:
{
  imports = [
    ../../modules/common
    ../../modules/desktop/graphics.nix
    ../../modules/desktop/gaming.nix
  ];
}
```

### `hosts/laptop/default.nix`

```nix
{ config, pkgs, ... }:
{
  imports = [
    ../../modules/common
    ../../modules/desktop/graphics.nix
    ../../modules/dev
  ];
}
```

La clave es que la configuración de la GPU vive en un módulo que es cargado por cada equipo, pero no depende del usuario.

---

## 7. ¿Qué pasa si cada equipo tiene distinta GPU?

Entonces la mejor práctica es tener un módulo gráfico específico por host o un módulo con condición por hardware.

### Opción A: módulo único, pero configurable

```nix
# modules/desktop/graphics.nix
{ config, pkgs, lib, ... }:
let
  gpu = "nvidia";
in
{
  config = if gpu == "nvidia" then {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia.enable = true;
  } else if gpu == "amd" then {
    services.xserver.videoDrivers = [ "amdgpu" ];
  } else {
    services.xserver.videoDrivers = [ "modesetting" ];
  };
}
```

### Opción B: mejor práctica

Mantener un módulo gráfico por tipo de hardware:

```text
modules/
  desktop/
    graphics-nvidia.nix
    graphics-amd.nix
    graphics-intel.nix
```

Y en cada host importas solo el que corresponde:

```nix
# hosts/desktop/default.nix
{
  imports = [
    ../../modules/desktop/graphics-nvidia.nix
  ];
}
```

Esto es más claro y más mantenible cuando cada equipo tiene distinta GPU.

---

## 8. Ejemplo de guía rápida para elegir qué va dónde

### va en `modules/desktop/...`

- GPU
- drivers
- Steam
- gaming
- monitor
- xserver
- OpenGL/Vulkan
- soporte de audio del sistema
- servicios del sistema

### va en `users/.../profiles/...`

- Firefox
- Discord
- VS Code
- Node
- kitty
- zsh
- Git
- dotfiles
- apps personales

---

## 9. Recomendación concreta para tu caso

Para tu estructura ideal, yo dejaría esto:

```text
modules/
  common/
  desktop/
    graphics.nix
    gaming.nix
    audio.nix
  dev/
  services/

users/
  tato/
    profiles/
      base.nix
      dev.nix
      gaming.nix
      internet.nix
```

Y dentro de `graphics.nix` pondrías únicamente:

- driver de GPU
- OpenGL
- Vulkan
- configuración de salida de vídeo
- conexión con el entorno gráfico del sistema

Nunca pondrías ahí apps de usuario ni paquetes personales.

---

## 10. Regla de decisión simple

Si una línea de configuración afecta a la máquina entera, va a `modules`.

Si afecta solo al usuario logueado, va a `users/.../profiles`.

### Ejemplos rápidos

- `services.xserver.enable = true;` → `modules`
- `programs.steam.enable = true;` → `modules`
- `home.packages = [ firefox ];` → `profiles`
- `programs.git.enable = true;` → `profiles`
- `hardware.nvidia.package = ...;` → `modules`
- `home.sessionVariables.TERMINAL = "kitty";` → `profiles`

---

## 11. Conclusión

La confusión normal es esta:

- muchas cosas parecen “de software” y se piensa que van en el usuario
- pero la GPU, Steam, drivers, xserver y servicios del sistema son de la máquina

Por eso `modules/desktop/graphics.nix` tiene sentido como módulo del sistema.

No es un “perfil de usuario”, sino parte de la capa de hardware y entorno gráfico de la máquina.

Si cada equipo tiene una GPU distinta, lo correcto es que cada host cargue el módulo gráfico que corresponda, o que `graphics.nix` sea modular y dependa del hardware concreto.
