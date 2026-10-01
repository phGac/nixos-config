# Plan de organización de la configuración de NixOS

## Versión actual

- NixOS: 26.05
- Home Manager: release-26.05
- Configuración base revisada: `flake.nix`, `hosts/nixos/default.nix`, `home/default.nix`, `modules/system.nix`, `modules/steam.nix`
- Enfoque actual: PC doméstico con uso de internet, gaming, programación y servicios locales.

## Objetivo de la configuración

La configuración debe quedar orientada a un entorno doméstico y escalable, con:

- PC de escritorio principal para gaming y multimedia
- laptop o equipo portátil para trabajo/programación
- usuario único (`tato`) con perfiles reutilizables
- módulos comunes compartidos entre máquinas
- instalación y mantenimiento simples con flakes
- capacidad de añadir nuevos equipos sin duplicar lógica innecesaria

## Estado actual

La estructura actual ya tiene una buena base:

- Flake principal con `nixosConfigurations.nixos`
- Home Manager integrado
- Separación de módulos por tipo
- Soporte de Steam y gaming
- Algunos programas de desarrollo y uso diario ya definidos

Sin embargo, todavía está pensada para una sola máquina, por lo que conviene evolucionarla a una arquitectura de:

- base común
- perfiles por uso
- hosts por hardware
- usuario reutilizable

## Paso a paso recomendado

### 1) Definir la versión base y el objetivo del repo

Mantener la versión actual como base de referencia:

- `nixos-26.05`
- `home-manager/release-26.05`

Esto permite que cualquier cambio futuro se mantenga consistente con la rama estable actual del canal 26.05.

### 2) Separar la configuración por capas

La lógica debe dividirse en estos bloques:

1. Configuración común del sistema
   - locale
   - timezone
   - red
   - audio
   - seguridad
   - paquetes mínimos

2. Configuración por perfil de uso
   - `gaming`
   - `dev`
   - `internet`
   - `productivity`
   - `services`

3. Configuración por hardware
   - `desktop`
   - `laptop`
   - `workstation` (si aparece más adelante)

4. Configuración del usuario
   - shell
   - programas de usuario
   - Git
   - editor
   - browser
   - herramientas de trabajo

### 3) Reorganizar el árbol de archivos

La estructura final recomendada es la siguiente:

```text
nixos/
  flake.nix
  lib/
    mkHome.nix
    mkSystem.nix

  modules/
    common/
      nix.nix
      locale.nix
      networking.nix
      audio.nix
      security.nix
    desktop/
      gaming.nix
      graphics.nix
      steam.nix
      media.nix
    dev/
      node.nix
      java.nix
      vscode.nix
      docker.nix
    services/
      nginx.nix
      zerotier.nix
      avahi.nix

  hosts/
    desktop/
      default.nix
      hardware-configuration.nix
    laptop/
      default.nix
      hardware-configuration.nix

  users/
    tato/
      home.nix
      profiles/
        base.nix
        dev.nix
        gaming.nix
        internet.nix
```

### 4) Crear un perfil base para todos los equipos

Este perfil debe contener todo lo que compartan los equipos:

- shell
- git
- utilidades esenciales
- navegador
- terminal
- font settings
- audio
- network
- locale

Esto evita duplicar ajustes entre equipos y hace que `desktop` y `laptop` hereden la misma base.

### 5) Crear perfiles de uso

Cada perfil agrega funciones específicas:

- `gaming`: Steam, controllers, gamemode, gráficos, herramientas de juego
- `dev`: Node, Java, VS Code, Docker, herramientas de trabajo
- `internet`: Firefox, discord, utilidades de navegación y comunicación
- `services`: nginx, docker, zerotier, avahi, servicios locales

La idea es que cada host use solo los perfiles que necesite.

### 6) Definir hosts por máquina

Cada host debe describir:

- hardware específico
- GPU/graphics
- teclado o input
- audio/periféricos
- servicios necesarios
- perfil activo del usuario

Ejemplo:

- `desktop`: gaming + internet + dev
- `laptop`: dev + internet + services (si aplica)

### 7) Adaptar `flake.nix` para múltiples configuraciones

En lugar de un único `nixosConfigurations.nixos`, conviene crear varias configuraciones:

```nix
nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
  modules = [
    ./hosts/desktop/default.nix
    ./modules/common
    ./modules/desktop
  ];
};

nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
  modules = [
    ./hosts/laptop/default.nix
    ./modules/common
    ./modules/dev
  ];
};
```

Esto permite desplegar cada equipo sin mezclar configuraciones.

### 8) Reutilizar Home Manager por máquina

En Home Manager se recomienda usar perfiles de usuario y no mezclar todo en un único `home/default.nix`.

Estructura recomendada:

- `users/tato/home.nix` como punto central
- `profiles/base.nix`
- `profiles/dev.nix`
- `profiles/gaming.nix`
- `profiles/internet.nix`

Así ambos equipos pueden compartir el mismo usuario pero con diferentes combinaciones de paquetes y ajustes.

### 9) Mantener la configuración fácil de modificar

Para evitar que el repo crezca desordenado:

- Un módulo = una responsabilidad
- Un archivo = una categoría lógica
- No mezclar servicios, apps de usuario y GPU en un mismo archivo
- Añadir comentarios solo cuando ayudan a la mantenibilidad

### 10) Validar la configuración

Antes de aplicar cambios importantes, ejecutar:

```bash
sudo nix flake check
sudo nixos-rebuild test --flake .#desktop
sudo nixos-rebuild switch --flake .#desktop
```

Para laptop:

```bash
sudo nixos-rebuild switch --flake .#laptop
```

Y si usas Home Manager por separado:

```bash
home-manager switch --flake .#tato@desktop
home-manager switch --flake .#tato@laptop
```

## Orientación final recomendada

Esta configuración debe apuntar a un entorno doméstico y profesional, con estos usos principales:

- internet y navegación diaria
- gaming en PC de escritorio
- programación y desarrollo
- servicios locales o home lab
- administración sencilla de varios equipos

## Resultado esperado

Con la reorganización propuesta:

- el sistema será más legible
- será más fácil escalar a otras máquinas
- no habrá duplicación de módulos innecesaria
- la administración será más rápida y menos frágil
- se facilitará el mantenimiento a mediano y largo plazo

## Siguiente acción recomendada

1. Mantener la configuración actual como base
2. Crear `hosts/desktop` y `hosts/laptop`
3. Mover la configuración común a `modules/common`
4. Separar paquetes por perfil (`dev`, `gaming`, `internet`)
5. Ajustar `flake.nix` para múltiples configuraciones

Esto convierte tu repo en una configuración NixOS ordenada, reutilizable y preparada para crecer.
