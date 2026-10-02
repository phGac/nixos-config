# NixOS Home Configuration

## Descripción general

Este repositorio organiza una configuración de NixOS basada en flakes para un entorno doméstico moderno, con enfoque en:

- internet y uso cotidiano
- gaming en PC de escritorio
- programación y desarrollo
- administración de múltiples dispositivos
- servicios locales y herramientas del sistema

## Versión actual

- NixOS: 26.05
- Home Manager: release-26.05
- Base actual revisada: `flake.nix`, `hosts/nixos/default.nix`, `home/default.nix` y módulos de sistema/usuario

## Objetivo de la estructura final

La idea es que el proyecto quede ordenado en capas:

- configuración común del sistema
- configuración específica por máquina
- perfiles por tipo de uso
- configuración del usuario
- reutilización entre equipos

Esto permite mantener un mismo usuario y un mismo enfoque de trabajo, sin mezclar todas las decisiones en un solo lugar.

## Estructura recomendada

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
      network.nix
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

## Cómo está organizado

### 1) `modules/common/`

Aquí va todo lo que comparten las máquinas:

- teclado y locale
- audio
- red
- paquetes básicos
- seguridad
- sistema base

### 2) `modules/desktop/`

Para todo lo relacionado con un PC de escritorio:

- Steam
- gaming
- gráficos
- soporte de periféricos
- media

### 3) `modules/dev/`

Para herramientas de programación:

- Node
- Java
- VS Code
- Docker
- utilidades de desarrollo

### 4) `modules/services/`

Para servicios locales del hogar o red:

- nginx
- zerotier
- avahi
- servicios de infraestructura

### 5) `hosts/`

Cada equipo vive aquí:

- `desktop`: gaming + trabajo + internet
- `laptop`: desarrollo + navegación + servicios ligeros

Esto hace que cada máquina tenga su propia identidad sin duplicar toda la configuración.

### 6) `users/tato/`

El usuario se define de forma centralizada:

- programas personales
- shell
- perfil base
- perfiles por actividad

Esto permite mantener un usuario consistente en varios equipos.

## Cómo modificarlo

### Añadir un paquete base al sistema

Crea o edita un módulo dentro de `modules/common/` y agrégalo a la lista de imports del host correspondiente.

### Añadir un programa de desarrollo

Colócalo dentro de `modules/dev/` o en el perfil `users/tato/profiles/dev.nix`.

### Añadir una nueva máquina

1. Crea la carpeta `hosts/nombre-equipo/`
2. Añade `default.nix` y `hardware-configuration.nix`
3. Define qué módulos e imports usa
4. Añade la configuración a `flake.nix`

### Añadir un nuevo perfil de usuario

1. Crea un archivo `profiles/nuevo-perfil.nix`
2. Declara los paquetes o programas que necesite
3. Inclúyelo dentro del home del usuario o en el host correspondiente

## Cómo desplegar cambios

### Aplicar cambios del sistema

```bash
sudo nixos-rebuild switch --flake .#desktop
sudo nixos-rebuild switch --flake .#laptop
```

### Aplicar cambios del usuario con Home Manager

```bash
home-manager switch --flake .#tato@desktop
home-manager switch --flake .#tato@laptop
```

### Validar la configuración

```bash
sudo nix flake check
```

## Recomendación práctica

Para este repositorio, la mejor ruta es:

- mantener la base actual
- separar módulos comunes
- crear perfiles por uso
- modelar cada máquina como `host`
- reutilizar el usuario `tato` para todos los equipos

Esto hace que el sistema sea más fácil de mantener, escalar y entender.

## Documentación adicional

La guía detallada del paso a paso está en [docs/plan-organizacion-nixos.md](docs/plan-organizacion-nixos.md).
