/bin/echo -e '
              __          ____                                   
   __________/ /___ _____/ / /____  ____ _____ ___    _______  __
  / ___/ ___/ / __ `/ __  / __/ _ \/ __ `/ __ `__ \  / ___/ / / /
 (__  ) /__/ / /_/ / /_/ / /_/  __/ /_/ / / / / / / / /  / /_/ / 
/____/\___/_/\__,_/\__,_/\__/\___/\__,_/_/ /_/ /_(_)_/   \__,_/  
                                                                  
\n\n'
printf "RU: Добро пожаловать в скрипт по обновлению панели Pterodactyl!\n"
printf "ENG: Welcome to the script for updating the Pterodactyl panel!"
printf "The script wrote : t.me/senpachz\n"
printf ""
printf "\n Switching the panel to technical mode.. \n"
cd /var/www/pterodactyl
php artisan down

printf "\n Updating.. \n"
curl -L https://github.com/pterodactyl/panel/releases/latest/download/panel.tar.gz | tar -xzv 
chmod -R 755 storage/* bootstrap/cache 
composer install --no-dev --optimize-autoloader
php artisan view:clear
php artisan config:clear
php artisan migrate --seed --force
chown -R www-data:www-data /var/www/pterodactyl/*
php artisan queue:restart
php artisan up
printf "\n The control panel has been updated! \n"
