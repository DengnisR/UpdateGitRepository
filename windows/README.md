# Actualizador de repositorio automatico (Windows)

Este script automatiza la descarga y actualización de un repositorio Git en un directorio específico en sistemas Windows. También configura una tarea programada para ejecutar el proceso de actualización automáticamente en intervalos regulares.

## Descripción

El script realiza las siguientes tareas:

-   Clona o actualiza un repositorio Git en un directorio específico.
-   Maneja archivos sin seguimiento para evitar conflictos durante la actualización.
-   Configura una tarea programada (equivalente a un cron job) para ejecutar el proceso de actualización automáticamente.
-   Instala dependencias (opcional) y reinicia la aplicación (opcional).

## Requisitos

Para usar este script, necesitas:

-   **Sistema Operativo** : Windows 10, Windows 11 o versiones modernas de Windows Server.
-   **PowerShell** : Versión 5.1 o superior (preinstalado en Windows 10/11).
-   **Git** : Instalado y disponible en el PATH del sistema ([descargar Git](https://git-scm.com/) ).
-   **Node.js y PM2 (Opcional)** : Si tu proyecto usa Node.js, asegúrate de tenerlos instalados.
-   **Permisos de Administrador** : Necesarios para configurar la tarea programada.

## Configuracion

1.  **Guarda el Script** : Guarda el script en un archivo, por ejemplo, `setup.ps1`.

2.  **Otorga Permisos de Ejecución** : Por defecto, PowerShell tiene restricciones de ejecución. Para permitir la ejecución del script, ejecuta el siguiente comando como administrador:

`Set-ExecutionPolicy RemoteSigned -Scope CurrentUser`

3. **Edita las Variables** : Abre el archivo `setup.ps1` y ajusta las siguientes variables según tus necesidades:

`$APP_DIR = "$HOME\folder"          # Directorio base de la aplicación
$APP_DIR_INSTALL = "$HOME\folder\install"  # Directorio donde se instalará el repositorio
$REPO_URL = "https://github.com/user/test.git"  # URL del repositorio
$BRANCH = "main"                   # Rama a monitorear`

4. **Ejecuta el Script** : Ejecuta el script con el siguiente comando:

`.\setup.ps1`

## Como funciona?

1.  **Clonación o Actualización** :

    -   Si el directorio ya contiene un repositorio Git, el script actualiza el repositorio con `git pull`.
    -   Si el directorio no está vacío pero no es un repositorio Git, los cambios locales se descartan antes de clonar el repositorio.
2.  **Tarea Programada** :

    -   El script configura una tarea programada que ejecuta el proceso de actualización automáticamente en el intervalo especificado.
3.  **Instalación de Dependencias** :

    -   Opcionalmente, puedes descomentar las líneas relacionadas con `npm install` para instalar dependencias.
4.  **Reinicio de la Aplicación** :

    -   Opcionalmente, puedes descomentar las líneas relacionadas con `pm2` para reiniciar la aplicación.
## Compatibilidad
El script es compatible con las siguientes versiones de Windows:

| Sistema Operativo         | Compatibilidad                                           |
|---------------------------|----------------------------------------------------------|
| Windows 11                | ✅ Totalmente compatible                                 |
| Windows 10                | ✅ Totalmente compatible                                 |
| Windows 8.1               | ✅ Compatible, pero puede requerir ajustes para tareas programadas |
| Windows 7                 | ❌ No compatible por defecto (requiere actualizar PowerShell o modificar el script) |
| Windows Server 2016+      | ✅ Totalmente compatible                                 |
| Windows Server 2012 R2    | ✅ Compatible, pero puede requerir ajustes para tareas programadas |
| Windows Server 2008 R2    | ❌ No compatible por defecto (requiere actualizar PowerShell o modificar el script) |

#### **Notas de Compatibilidad**

-   **PowerShell** : El script requiere PowerShell 5.1 o superior. Si usas una versión anterior, actualiza PowerShell desde [Microsoft Update](https://www.microsoft.com/en-us/download/details.aspx?id=54616) .
-   **Git** : Asegúrate de tener Git instalado y disponible en el PATH del sistema.
-   **Tareas Programadas** : En versiones antiguas de Windows, puedes usar `schtasks.exe` en lugar de `Register-ScheduledTask`.

## Personalizacion


Puedes personalizar el script según tus necesidades:

-   **Cambiar el Intervalo de la Tarea Programada** : Modifica la variable `$CRON_SCHEDULE`. Por ejemplo:

    - `-RepetitionInterval (New-TimeSpan -Minutes 30)`: Ejecutar cada 30 minutos.
    - `-RepetitionInterval (New-TimeSpan -Hours 1)`: Ejecutar cada hora.
    - `-RepetitionInterval (New-TimeSpan -Hours 6)`: Ejecutar cada 6 horas.
    - `-RepetitionInterval (New-TimeSpan -Hours 12)`: Ejecutar cada 12 horas.
    
-   **Habilitar Instalación de Dependencias** : Descomenta las líneas relacionadas con `npm install` si tu proyecto usa Node.js.

-   **Habilitar Reinicio de la Aplicación** : Descomenta las líneas relacionadas con `pm2` si usas PM2 para gestionar tu aplicación.

## Ejecución Manual

Si deseas ejecutar el proceso de actualización manualmente, puedes hacerlo con el siguiente comando:

`powershell.exe -ExecutionPolicy Bypass -File "$HOME\folder\update.ps1"`

Esto ejecutará el archivo `update.ps1` generado por el script principal.