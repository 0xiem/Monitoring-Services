#!/bin/bash

SERVEIS=("apache2" "mysql")
log="/var/log/monitoratge-serveis"
EMAIL="admin@example.com"
HOSTNAME=

while true; do
    for i in "${SERVEIS[@]}"; do
        if ! systemctl is-active -q $i; then
            echo "$(date) [Alerta] El servei $i NO està actiu al servidor $(hostname)" >> $log
            echo "El servei $i està parat. S'ha enviat una notificació a l'administrador."
            echo "El servei $i està parat al servidor $(hostname)" | mail -s "Alerta de servei parat" $EMAIL
            
            for x in {1..4}; do
                systemctl start $i
                if systemctl is-active -q $i; then
                    echo "$(date) [Alerta] El servei $i s'ha recuperat al servidor $(hostname)" | mail -s "Recuperació de servei" $EMAIL
                    break
                fi
            done
            
            if ! systemctl is-active --quiet $i; then
                echo "$(date) [Alerta Crítica] No s'ha pogut reiniciar el servei $i després de 4 intents al servidor $(hostname)" >> $log
                echo "No s'ha pogut reiniciar el servei $i després de 4 intents. Revisar el LOG." | mail -s "Error de servei" -a $log $EMAIL
            fi
        fi
    done
    sleep 60
done
