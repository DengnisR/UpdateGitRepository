#!/bin/bash

# Variables
APP_DIR="/home/$USER/folder" # Ruta base de la aplicación
APP_DIR_INSTALL="/home/$USER/folder/install" # Ruta donde se instalará el repositorio
REPO_URL="https://github.com/user/test.git"
BRANCH="main" # Cambia esto por la rama que deseas monitorear
CRON_SCHEDULE="*/1 * * * *" # Ejecutar cada minuto (ajusta según tus necesidades)

# Crear los directorios si no existen
mkdir -p $APP_DIR
mkdir -p $APP_DIR_INSTALL

# Crear el archivo de actualización (update.sh)
UPDATE_SCRIPT="$APP_DIR/update.sh"
cat <<EOF > $UPDATE_SCRIPT
#!/bin/bash
# Variables
REPO_URL="$REPO_URL"
APP_DIR="$APP_DIR_INSTALL"
BRANCH="$BRANCH"

# Entrar al directorio de la aplicación
cd \$APP_DIR || exit 1

# Verificar si el directorio ya contiene un repositorio Git
if [ -d "\$APP_DIR/.git" ]; then
  echo "Actualizando repositorio..."
  # Descartar todos los cambios locales y archivos sin seguimiento
  git fetch origin \$BRANCH
  git reset --hard FETCH_HEAD
  git clean -fd
  # Realizar la actualización
  git pull origin \$BRANCH
else
  # Clonar el repositorio
  echo "Clonando repositorio..."
  git clone -b \$BRANCH \$REPO_URL \$APP_DIR
fi

# Instalar dependencias
echo "Instalando dependencias..."
# npm install --production

# Reiniciar la aplicación con PM2
echo "Reiniciando la aplicación..."
# pm2 restart ecosystem.config.js || pm2 start ecosystem.config.js
EOF

# Hacer el archivo de actualización ejecutable
chmod +x $UPDATE_SCRIPT

# Configurar el cron job
CRON_JOB="$CRON_SCHEDULE $UPDATE_SCRIPT"
(crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

# Verificar que el cron job se haya configurado correctamente
echo "Cron job configurado:"
crontab -l

# Ejecutar el archivo de actualización inmediatamente
echo "Ejecutando el archivo de actualización..."
$UPDATE_SCRIPT