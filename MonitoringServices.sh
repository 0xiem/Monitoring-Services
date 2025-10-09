#!/bin/bash
CheckServiceWeb=$(systemctl is-active apache2)
CheckServiceBD=$(systemctl is-active mysql)

if [ "$CheckServiceWeb" = "active" ];then
    echo "[Activo] apache2"
elif [ "$CheckServiceBD" = "active" ];then
    echo "[Activo] mysql"
else
    echo "[Error] Alguna cosa no va"
fi