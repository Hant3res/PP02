#!/bin/bash
# Скрипт создания пользователя в системе страхования

if [ $# -ne 2 ]; then
    echo "Usage: $0 <username> <password>"
    exit 1
fi

USERNAME=$1
PASSWORD=$2

echo "Creating user: $USERNAME"

# Проверяем, запущен ли скрипт от root
if [ "$EUID" -eq 0 ]; then
    useradd -m -s /bin/bash $USERNAME
    echo "$USERNAME:$PASSWORD" | chpasswd
    echo "User $USERNAME created successfully"
else
    echo "Not running as root. Simulating user creation: $USERNAME"
    echo "Password set: $PASSWORD"
fi

# Логируем действие
echo "$(date): User $USERNAME created" >> user_creation.log
