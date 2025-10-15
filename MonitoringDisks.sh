#!/bin/bash

email="admin@example.com"
CarpetaHome="/home"


while true; do
    USAGE=$(df "$CarpetaHome" | awk 'NR==2 {print $5}' | sed 's/%//')

    if [[ $USAGE -ge 85 ]]; then
        echo "Espai en disc baix a $CarpetaHome: $USAGE%" | mail -s "Alerta d'espai en disc" $email
        
        # Buidar la papera
        rm -rf ~/.local/share/Trash/*
        echo "Papera buidada a $CarpetaHome"
        
        # Moure arxius grans
        while [[ $(df "$CarpetaHome" | awk 'NR==2 {print $4}' | sed 's/G//') -lt 15 ]]; do
            Ficheros=$(find "$CarpetaHome" -type f ! -name '.*' -exec du -h {} + | sort -rh | head -n 1 | awk '{print $2}')
            if [[ -z "$Ficheros" ]]; then
                break
            fi
            mv "$Ficheros" /path/to/other/disk/
        done
    fi
    
    sleep 1800
done
