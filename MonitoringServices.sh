#!/bin/bash
servicios=('apache2' 'mysql')
FicheroLog='/var/log/monitoratge-serveis'

Mensage() {
    Correo='ewcmfg@gmail.com'
    Subject='Urgente Mira El correo'
}

for i in ${servicios[@]};do
    if (systemctl -q is-active $i) ;then
        echo $i active
    else
        echo $i No esta activo
    fi
done