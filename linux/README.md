# Actualizador de repositorio automatico (Linux)

Este script automatiza la descarga y actualización de un repositorio Git en un directorio específico en sistemas Linux. También configura un cron job para ejecutar el proceso de actualización automáticamente en intervalos regulares.

## Descripción

El script realiza las siguientes tareas:

-   Clona o actualiza un repositorio Git en un directorio específico.
-   Maneja archivos sin seguimiento para evitar conflictos durante la actualización.
-   Configura un cron job para ejecutar el proceso de actualización automáticamente.
-   Instala dependencias (opcional) y reinicia la aplicación (opcional).

## Requisitos

Para usar este script, necesitas:

-   Un sistema operativo basado en Linux o Unix.
-   Git instalado (`sudo apt install git`).
-   Acceso al repositorio Git (público o privado).
-   Permisos de superusuario (`sudo`) para configurar el cron job.

## Configuracion

1.  **Guarda el Script** : Guarda el script en un archivo, por ejemplo, `setup.sh`.

2.  **Otorga Permisos de Ejecución** : Haz el script ejecutable con el siguiente comando:

`chmod +x setup.sh`

3. **Edita las Variables** : Abre el archivo `setup.sh` y ajusta las siguientes variables según tus necesidades:

`APP_DIR="/home/$USER/folder"          # Directorio base de la aplicación
APP_DIR_INSTALL="/home/$USER/folder/install"  # Directorio donde se instalará el repositorio
REPO_URL="https://github.com/user/test.git"  # URL del repositorio
BRANCH="main"                         # Rama a monitorear
CRON_SCHEDULE="*/1 * * * *"           # Intervalo del cron job (ejemplo: cada minuto)`

4. **Ejecuta el Script** : Ejecuta el script para configurar el cron job y actualizar el repositorio:

`./setup.sh`

## Como funciona?

1.  **Clonación o Actualización** :

    -   Si el directorio ya contiene un repositorio Git, el script actualiza el repositorio con `git pull`.
    -   Si el directorio no está vacío pero no es un repositorio Git, los archivos sin seguimiento se mueven a un respaldo temporal antes de clonar el repositorio.
2.  **Cron Job** :

    -   El script configura un cron job que ejecuta el proceso de actualización automáticamente en el intervalo especificado.
3.  **Instalación de Dependencias** :

    -   Opcionalmente, puedes descomentar las líneas relacionadas con `npm install` para instalar dependencias.
4.  **Reinicio de la Aplicación** :

    -   Opcionalmente, puedes descomentar las líneas relacionadas con `pm2` para reiniciar la aplicación.

## Personalizacion

Puedes personalizar el script según tus necesidades:

-   **Cambiar el Intervalo del Cron Job** : Modifica la variable `CRON_SCHEDULE`. Por ejemplo:

    -   `0 * * * *`: Ejecutar cada hora.
    -   `0 0 * * *`: Ejecutar todos los días a medianoche.
-   **Habilitar Instalación de Dependencias** : Descomenta las líneas relacionadas con `npm install` si tu proyecto usa Node.js.

-   **Habilitar Reinicio de la Aplicación** : Descomenta las líneas relacionadas con `pm2` si usas PM2 para gestionar tu aplicación.
## Ejecución Manual

Si deseas ejecutar el proceso de actualización manualmente, puedes hacerlo con el siguiente comando:

`/home/$USER/prueba/update.sh`

Esto ejecutará el archivo `update.sh` generado por el script principal.
