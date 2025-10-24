#!/bin/bash

# install.sh — установка Discord Voice Logger Bot с выбором языка

set -e

BOT_DIR="$HOME/KL-241-LOG"

GITHUB_RAW="https://raw.githubusercontent.com/WilayzJerti/KL-241-LOG/main"

echo "🚀 Установка KL-241-LOG из репозитория: WilayzJerti/KL-241-LOG..."

# === 1. Проверка Docker ===
if ! command -v docker &> /dev/null; then
    echo "❌ Docker не найден."
    if [[ "$OSTYPE" == "linux-gnu"* ]] && command -v apt &> /dev/null; then
        read -p "Установить Docker автоматически? (только для Ubuntu/Debian) [y/N]: " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "📥 Установка Docker..."
            sudo apt update
            sudo apt install -y ca-certificates curl gnupg
            sudo install -m 0755 -d /etc/apt/keyrings
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
            sudo chmod a+r /etc/apt/keyrings/docker.gpg
            . /etc/os-release
            echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $VERSION_CODENAME stable" | \
                sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
            sudo apt update
            sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
            sudo usermod -aG docker "$USER"
            echo "✅ Docker установлен."
            echo "⚠️  Выполните 'newgrp docker' или перезапустите сессию, затем запустите скрипт снова."
            exit 0
        fi
    fi
    echo "❌ Docker обязателен. Установите его вручную и повторите попытку."
    exit 1
else
    echo "✅ Docker уже установлен."
fi

# === 2. Проверка аргументов ===
if [ $# -ne 3 ]; then
    echo "Использование: $0 <DISCORD_BOT_TOKEN> <LOG_CHANNEL_ID> <LANG>"
    echo "LANG: 'ru' — русский, 'eu' — английский/международный"
    echo "Пример: $0 'your.token.here' '123456789012345678' 'ru'"
    exit 1
fi

DISCORD_TOKEN="$1"
LOG_CHANNEL_ID="$2"
LANG="$3"

if [[ "$LANG" != "ru" && "$LANG" != "eu" ]]; then
    echo "❌ Неподдерживаемый язык: '$LANG'. Используйте 'ru' или 'eu'."
    exit 1
fi

# === 3. Создание директории ===
mkdir -p "$BOT_DIR"
cd "$BOT_DIR"

# === 4. Скачивание файлов ===
echo "📥 Загрузка файлов из GitHub..."

# Скачиваем нужную версию бота
BOT_SOURCE="bot-${LANG}.py"
if ! curl -fsSL -o "bot.py" "$GITHUB_RAW/$BOT_SOURCE"; then
    echo "❌ Не удалось скачать $BOT_SOURCE. Убедитесь, что файл существует в репозитории."
    exit 1
fi
echo "✅ Загружен bot.py (язык: $LANG)"

# Остальные файлы — общие
for file in Dockerfile requirements.txt; do
    if ! curl -fsSL -o "$file" "$GITHUB_RAW/$file"; then
        echo "❌ Не удалось скачать $file."
        exit 1
    fi
    echo "✅ Загружен $file"
done

# === 5. Сборка и запуск ===
echo "🔨 Сборка Docker-образа..."
docker build -t kl-241-log .

echo "🐳 Запуск контейнера..."
docker run -d \
  --name kl-241-log \
  --restart unless-stopped \
  -e DISCORD_BOT_TOKEN="$DISCORD_TOKEN" \
  -e LOG_CHANNEL_ID="$LOG_CHANNEL_ID" \
  kl-241-log

echo "✅ Бот успешно установлен! Язык: $( [[ "$LANG" == "ru" ]] && echo "Русский" || echo "Английский/Международный" )"
echo "📝 Логи: docker logs kl-241-log"