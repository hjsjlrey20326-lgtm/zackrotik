#!/bin/bash
# Рендерим конфиг nginx с переменными окружения
envsubst '${PORT}' < /etc/nginx/nginx.conf.template > /etc/nginx/nginx.conf

# Запускаем 3x-ui в фоне
/usr/local/x-ui/x-ui &

# Запускаем nginx на переднем плане
nginx -g 'daemon off;'