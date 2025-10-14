#!/bin/bash
servicios=('apache2' 'mysql')
FicheroLog='/var/log/monitoratge-serveis'

Mensage() {
    Correo='ewcmfg@gmail.com'
    Subject='Urgente Mira El correo'
}

for i in ${servicios[@]};do
    if (systemctl -q is-failed $i) ;then
        echo $i active
    fi
done