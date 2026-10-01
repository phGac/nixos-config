# Reorganización detallada de la configuración de NixOS

## 1. Diagnóstico de la estructura actual

Tu configuración ya tiene una base bastante buena, pero hay varios signos de que está aún parcialmente mezclada:

- Hay una única configuración principal en `flake.nix`, pero la idea de múltiples equipos aún no está modelada.
- El sistema y el usuario están mezclados en varios niveles: `modules`, `hosts`, `home`, y `__env.nix`.
- Hay un host llamado `nixos` y otro llamado `tato-desktop`, pero no existe una convención clara entre ambos.
- Algunos archivos están muy generales y otros muy específicos, sin que siempre exista una regla clara de qué va en cada lugar.
- El usuario `tato` está definido dentro del flake, pero no está separado como una identidad reutilizable para múltiples máquinas.
- El archivo `__env.nix` contiene datos personales (nombre, email, correo ACME), lo que en una configuración más madura debería estar separado de la lógica y, si fuera sensible, no vivir en Git en texto plano.

Esto no es un problema de Nix en sí; es un problema de organización y de separación de responsabilidades.

---

## 2. Principio general a aplicar

La configuración debe seguir esta regla:

- un archivo = una responsabilidad
- un módulo = una categoría clara
- un host = una máquina concreta
- un perfil = un tipo de uso
- un usuario = una identidad del sistema

En otras palabras:

- no mezcles `Sistema + programa + host + usuario` en el mismo archivo
- no pongas paquetes de gaming junto con paquetes de desarrollo en el mismo módulo
- no dejes `hosts` vacíos ni nombres repetidos que no se usan

---

## 3. Qué está desordenado concretamente en tu repo

### 3.1. Hay dos nombres de host conflictivos

Tienes:

- `nixos/hosts/nixos/default.nix`
- `nixos/hosts/tato-desktop/`

Y en el flake, el nombre de configuración es solo:

```nix
nixosConfigurations.nixos = nixpkgs.lib.nixosSystem { ... }
```

Esto genera un problema conceptual:

- `nixos` es un nombre de host, pero no representa una máquina real de forma clara
- `tato-desktop` existe como carpeta, pero no está integrada plenamente
- hay una mezcla entre nombre genérico (`nixos`) y nombre descriptivo (`tato-desktop`)

### Recomendación

Usar una convención fija y clara:

- `desktop`
- `laptop`
- `workstation`
- `server`

Y no dejar nombres “genéricos” si luego quieres escalar.

---

### 3.2. El directorio `modules` está mezclando varios niveles

Actualmente tienes:

- `modules/system.nix`
- `modules/steam.nix`
- `modules/services/default.nix`

Esto no está mal, pero hay una mezcla de:

- configuración base del sistema
- configuración de hardware/software específico
- servicios
- programas para un caso de uso

Esto crece desordenado muy rápido.

### Recomendación

Organizar módulos por tipo:

```text
modules/
  common/
  desktop/
  dev/
  services/
```

Y cada capa debe tener una función bien definida.

---

### 3.3. `home/default.nix` agrega demasiadas cosas a la vez

Tu `home/default.nix` es un agregador general:

```nix
imports = [
  ./programs/default.nix
  ./shell/default.nix
  ./dev/default.nix
  ./tools/default.nix
];
```

Esto está bien como punto de entrada, pero hay un problema: el usuario no está modelado como un conjunto de perfiles reutilizables.

### Recomendación

En lugar de un agregador global, usar:

```text
users/
  tato/
    home.nix
    profiles/
      base.nix
      dev.nix
      gaming.nix
      internet.nix
```

Esto hace que el mismo usuario `tato` pueda tener configuraciones distintas según el equipo.

---

### 3.4. `__env.nix` no es una buena ubicación para datos personales

El archivo:

```nix
nixos/__env.nix
```

contiene:

- usuario git
- email git
- acme email

Eso tiene dos problemas:

1. no está claro si es variable de entorno o de configuración de usuario
2. se está usando como un “archivo de configuración global”, cuando debería ser un dato de usuario o incluso algo manejado por `sops-nix`/`age`

### Recomendación

Mover esto a una estructura más clara, por ejemplo:

```text
users/
  tato/
    identity.nix
```

O si es información sensible:

- `sops-nix`
- `agenix`
- o al menos un archivo separado no mezclado con módulos del sistema

---

### 3.5. Hay programas “de uso personal” mezclados con módulos utilitarios

Ejemplo: `home/programs/common.nix` tiene Discord y Vencord. Eso no parece “común”; parece un perfil social o de internet.

Eso es un buen ejemplo de cómo se vuelve confuso:

- `Discord` no es una herramienta “base” del sistema
- es una app de comunicación
- debería ir en un perfil de internet o social

### Recomendación

Agrupar por intención:

- `internet.nix`
- `social.nix`
- `gaming.nix`
- `dev.nix`

No por carpeta “programs” general si crece mucho.

---

### 3.6. Algunos módulos están vacíos o incompletos

Por ejemplo:

- `nixos/home/shell/common.nix` está casi vacío
- `nixos/hosts/tato-desktop/modules` está vacía

Esto indica que hay piezas empezadas y abandonadas.

### Recomendación

Si una carpeta o módulo no se va a usar, no dejarlo en el flujo principal. Eliminarlo o moverlo a un archivo de referencia y documentarlo.

---

## 4. Estructura final recomendada

La estructura ideal para tu caso es esta:

```text
nixos/
  flake.nix

  lib/
    mkSystem.nix
    mkHome.nix

  modules/
    common/
      nix.nix
      locale.nix
      networking.nix
      audio.nix
      security.nix
      packages.nix

    desktop/
      graphics.nix
      gaming.nix
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
      identity.nix
      profiles/
        base.nix
        dev.nix
        gaming.nix
        internet.nix
```

Esto produce las siguientes ventajas:

- cada host es una máquina concreta
- cada módulo tiene una responsabilidad clara
- cada perfil de usuario representa un caso de uso
- hay menos repetición
- se puede activar/desactivar por equipo sin tocar el resto

---

## 5. Cómo definir las capas correctamente

### 5.1. Capa 1: `common`

Aquí va todo lo que comparten todas las máquinas:

- locale
- time zone
- red
- audio
- paquetes esenciales
- seguridad
- caché / configuración de nix
- font config
- terminal base

Ejemplo de contenido:

```nix
# modules/common/nix.nix
{ config, pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
}
```

No debe contener gaming ni desarrollo; solo lo base.

---

### 5.2. Capa 2: `desktop`

Aquí va todo lo que es específico del PC de escritorio:

- Steam
- gamemode
- logiops
- solaar
- graphics
- audio/video
- controllers

Ejemplo:

```nix
# modules/desktop/gaming.nix
{ config, pkgs, ... }: {
  programs.steam.enable = true;
  programs.gamemode.enable = true;
  hardware.steam-hardware.enable = true;
}
```

Esto no debe vivir en un modulo global del sistema.

---

### 5.3. Capa 3: `dev`

Aquí va todo el entorno de trabajo:

- Node
- Java
- GitHub CLI
- VS Code / WebStorm
- Docker
- herramientas de desarrollo

Ejemplo:

```nix
# modules/dev/node.nix
{ config, pkgs, ... }: {
  home-manager.users.tato = { ... };
}
```

O más limpio y directo: 

```nix
# users/tato/profiles/dev.nix
{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    nodejs_22
    yarn
    bruno
  ];
}
```

---

### 5.4. Capa 4: `services`

Aquí van los servicios que hagan falta en casa o en red local:

- nginx
- docker
- zerotier
- avahi
- reverse proxy

Esto es una capa distinta del entorno de escritorio y no debería mezclarse con la configuración del usuario.

---

## 6. Cómo manejar múltiples equipos

La regla es bastante simple:

- cada equipo tiene su propio `host`
- cada host importa módulos y perfiles según su función

### Ejemplo de hosts

#### `desktop`

- `common`
- `desktop`
- `dev`
- `internet`
- `gaming`

#### `laptop`

- `common`
- `dev`
- `internet`
- `services` (si hace falta)

Esto permite que la misma computadora personal se ejecute con contenidos distintos según el hardware.

---

## 7. Cómo separar los perfiles del usuario

Tu usuario debe tener un perfil base y luego perfiles adicionales.

### Perfil base

```text
users/tato/profiles/base.nix
```

Incluye:

- shell
- editor base
- navegador base
- Git básico
- fuentes
- terminal

### Perfil dev

```text
users/tato/profiles/dev.nix
```

Incluye:

- Node
- Java
- VS Code
- WebStorm
- Docker
- herramientas de desarrollo

### Perfil gaming

```text
users/tato/profiles/gaming.nix
```

Incluye:

- Steam
- GameMode
- controlador
- software de juego

### Perfil internet

```text
users/tato/profiles/internet.nix
```

Incluye:

- Firefox
- Discord
- mensajería
- utilidades de comunicación
- navegador y apps sociales

Con esta estructura, el usuario puede combinar perfiles de una forma clara.

---

## 8. Cómo migrar sin romper todo

No hace falta reescribir todo de golpe. La migración debe hacerse por etapas.

### Fase 1: limpiar nombres y hosts

- decidir nombre final del equipo actual
- eliminar o desactivar `hosts/tato-desktop` si no lo vas a usar
- dejar solo `hosts/desktop` o `hosts/laptop`
- actualizar `flake.nix`

### Fase 2: mover datos de `__env.nix`

- sacar la identidad personal del usuario a `users/tato/identity.nix`
- dejar un archivo pequeño y claro para nombre/email/git
- si los datos son sensibles, usar `sops-nix` o `agenix`

### Fase 3: separar módulos por categoría

Mover de:

- `modules/system.nix` → `modules/common/`
- `modules/steam.nix` → `modules/desktop/gaming.nix`
- `services/default.nix` → `modules/services/`

### Fase 4: convertir home a perfiles

- `home/default.nix` deja de ser “todo junto”
- se convierte en un “selector” de perfiles
- cada perfil se activa por host o por gusto personal

### Fase 5: validar y probar

Ejecutar:

```bash
sudo nix flake check
sudo nixos-rebuild test --flake .#desktop
sudo nixos-rebuild switch --flake .#desktop
```

---

## 9. Cómo debe quedar `flake.nix` al final

El flake debería verse más bien así:

```nix
{
  description = "Personal NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/desktop/default.nix
            ./modules/common
            ./modules/desktop
            ./modules/dev
            ./modules/services
          ];
        };

        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/laptop/default.nix
            ./modules/common
            ./modules/dev
            ./modules/services
          ];
        };
      };
    };
}
```

Esto deja claro que el flake genera varios sistemas y que cada host puede importar los módulos que necesite.

---

## 10. Reglas prácticas para mantener el repo limpio

Estas reglas te ayudarán a no volver a mezclar las cosas:

- Un módulo no debe depender de otro caso de uso no relacionado
- Un `host` no debe importar “todo” por default
- `home-manager` debe estar orientado a perfiles, no a una configuración global gigante
- un archivo con `default.nix` solo debe ser un agregador o un punto de entrada
- si una carpeta no se usa, eliminarla
- si un módulo tiene más de una responsabilidad, dividirlo
- si una variable es personal, sacarla de la configuración principal

---

## 11. Qué conviene priorizar en orden

### Prioridad alta

1. unificar nombres de hosts
2. quitar/limpiar `__env.nix`
3. separar módulos por tipo
4. definir `desktop` y `laptop`
5. mover programas de usuario a perfiles

### Prioridad media

6. mover servicios a `modules/services`
7. dejar mejor organizado `home-manager`
8. crear `lib` helpers si se hace complejo

### Prioridad baja

9. refactorizar nombres viejos si el sistema ya funciona
10. introducir `sops-nix` si empiezan a aparecer secretos o datos sensibles

---

## 12. Resultado esperado

Cuando lo dejes organizado, tu repositorio debería comportarse así:

- cada equipo tiene una config clara
- cada módulo tiene una función exacta
- cada perfil del usuario representa un caso de uso
- los cambios son aislados y fáciles de probar
- el sistema es escalable a más equipos o más perfiles
- el mantenimiento no se vuelve un caos con cada nueva app

---

## 13. Recomendación final

La mejor versión para tu caso es esta:

- un flake con varios hosts
- módulos separados por `common`, `desktop`, `dev`, `services`
- usuario `tato` con perfiles reutilizables
- datos sensibles fuera de la configuración base
- documentación clara de qué va en cada carpeta

En resumen: tu configuración ya tiene la base funcional, pero todavía falta la capa de arquitectura. Esa capa es la que te va a permitir mantener el sistema ordenado, fácil de escalar y sin confusiones cuando agregues más equipos o más apps.
