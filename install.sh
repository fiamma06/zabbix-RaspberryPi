#!/usr/bin/env bash
# Скрипт инсталяции скриптов и файлов-конфигурации мониторинга Raspberry Pi в Zabbix
#
# author: Alexey Shulik
# e-mail: me@hellsman.ru
# date: 10.08.2015



# Создаем папку, где будут располагаться скрпиты
mkdir -p /usr/share/zabbix-agent/scripts/
chown -R zabbix:zabbix /usr/share/zabbix-agent/

# Создаем конфигурацию для Zabbix Agent
cp conf/*.conf `cat /etc/zabbix/zabbix_agentd.conf | grep -v "#" | grep Include| awk -F"/" '{print "/"$2"/"$3"/"$4}'`

# Переносим исполняемый скрпит
cp scripts/*.sh /usr/share/zabbix-agent/scripts/
chown -R zabbix:zabbix /usr/share/zabbix-agent/scripts
chmod +x /usr/share/zabbix-agent/scripts/*.sh
#Добавляем пользователя zabbix в группу video, без этого нельзя получить температуру GPU
usermod -G video zabbix

# Перезапускаем Zabbix Agent
service zabbix-agent restart
echo "Установка закончена"
