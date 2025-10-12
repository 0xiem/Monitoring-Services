#!/bin/bash
CheckServiceWeb=$(systemctl is-active apache2)
CheckServiceBD=$(systemctl is-active mysql)

if [ $CheckServiceWeb = 'inactive' && $CheckServiceBD = 'inactive' ];then
    echo  '['date'] [Alerta] Els serveis apache2 i mysql no estan actius al servidor ' hostname
elif [ $CheckServiceWeb = 'inactive'  ];then
    echo  '['date'] [Alerta] El servei apache2  no esta actiu al servidor ' hostname
elif [ $CheckServiceBD = 'inactive'  ];then
    echo  '['date'] [Alerta] El servei mysql  no esta actiu al servidor ' hostname
fi