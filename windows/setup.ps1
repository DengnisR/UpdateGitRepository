# Variables
$APP_DIR = "$HOME\folder" # Ruta base de la aplicación
$APP_DIR_INSTALL = "$HOME\folder\install" # Ruta donde se instalará el repositorio
$REPO_URL = "https://github.com/DengnisR/react-tests.git"
$BRANCH = "main" # Cambia esto por la rama que deseas monitorear

# Crear los directorios si no existen
if (-Not (Test-Path $APP_DIR)) {
    New-Item -ItemType Directory -Path $APP_DIR | Out-Null
}
if (-Not (Test-Path $APP_DIR_INSTALL)) {
    New-Item -ItemType Directory -Path $APP_DIR_INSTALL | Out-Null
}

# Crear el archivo de actualización (update.ps1)
$UPDATE_SCRIPT = "$APP_DIR\update.ps1"
@"
# Variables
`$REPO_URL = '$REPO_URL'
`$APP_DIR = '$APP_DIR_INSTALL'
`$BRANCH = '$BRANCH'

# Entrar al directorio de la aplicación
Set-Location `$APP_DIR -ErrorAction Stop

# Verificar si el directorio ya contiene un repositorio Git
if (Test-Path "`$APP_DIR\.git") {
    Write-Output 'Actualizando repositorio...'
    try {
        git fetch origin `$BRANCH
        git reset --hard FETCH_HEAD
        git clean -fd
        git pull origin `$BRANCH
        Write-Output 'Repositorio actualizado correctamente.'
    } catch {
        Write-Output "Error al actualizar el repositorio: $_"
    }
} else {
    Write-Output 'Clonando repositorio...'
    try {
        git clone -b `$BRANCH `$REPO_URL `$APP_DIR
        Write-Output 'Repositorio clonado correctamente.'
    } catch {
        Write-Output "Error al clonar el repositorio: $_"
    }
}

# Instalar dependencias
Write-Output 'Instalando dependencias...'
try {
    # npm install --production
    Write-Output 'Dependencias instaladas correctamente.'
} catch {
    Write-Output "Error al instalar dependencias: $_"
}

# Reiniciar la aplicación con PM2
Write-Output 'Reiniciando la aplicación...'
try {
    # pm2 restart ecosystem.config.js || pm2 start ecosystem.config.js
    Write-Output 'Aplicación reiniciada correctamente.'
} catch {
    Write-Output "Error al reiniciar la aplicación: $_"
}
"@ | Out-File -FilePath $UPDATE_SCRIPT -Encoding UTF8

# Configurar la tarea programada (equivalente a cron)
$TaskName = "RepoUpdater"
$Trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 1)
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -File `"$UPDATE_SCRIPT`""
Register-ScheduledTask -TaskName $TaskName -Trigger $Trigger -Action $Action -User "SYSTEM" -Force | Out-Null

# Verificar que la tarea programada se haya configurado correctamente
Write-Output "Tarea programada configurada:"
Get-ScheduledTask -TaskName $TaskName

# Ejecutar el archivo de actualización inmediatamente
Write-Output "Ejecutando el archivo de actualización..."
powershell.exe -ExecutionPolicy Bypass -File $UPDATE_SCRIPT
