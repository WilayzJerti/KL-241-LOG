# 👁️KL-241-LOG

> 🤖 Простой и надёжный Discord-бот на Python, который **автоматически логирует вход/выход участников в голосовые каналы** в указанный текстовый канал.

![Python](https://img.shields.io/badge/Python-3.11%2B-blue?logo=python)
![Docker](https://img.shields.io/badge/Docker-Required-blue?logo=docker)
![License](https://img.shields.io/badge/License-MIT-green)
![Language EN](https://github.com/WilayzJerti/KL-241-LOG/blob/main/README.md)

<img width="1155" height="265" alt="изображение" src="https://github.com/user-attachments/assets/9969a213-5467-4a7e-bf5a-968ee855a835" />


---

## 🌟 Возможности

- ✅ Логирование входа в голосовой канал  
- ✅ Логирование выхода из голосового канала  
- ✅ Логирование перемещения между каналами  
- 🕒 Точное время события (локальное на сервере)  
- 🐳 Полная поддержка Docker — легко развернуть за 10 секунд  
- 🔒 Безопасная передача токена через переменные окружения  

---

## 🚀 Быстрая установка (Linux/macOS)

> Требуется: `curl`, `bash`, и **Docker** (скрипт может установить его автоматически на Ubuntu/Debian).

Выполните **одну команду** в терминале:

```bash
curl -fsSL https://raw.githubusercontent.com/WilayzJerti/KL-241-LOG/main/install.sh | bash -s "ВАШ_ТОКЕН_БОТА" "ID_ТЕКСТОВОГО_КАНАЛА" "Язык"
```



**🔑 Где взять данные?**   
  - Токен бота: [Discord Developer Portal → Applications → Bot → Token](https://discord.com/developers/applications?spm=a2ty_o01.29997173.0.0.59cb5171Rbn7to "Discord Developer")
        
  - ID канала: Включите режим разработчика в Discord  → ПКМ по каналу → «Копировать ID»



**🌍 Выбор языка:**

Поддерживаются два языка логов: 

  - ru — русский
  - en — английский
      
Пример комады запуска:
```bash
curl -fsSL https://raw.githubusercontent.com/WilayzJerti/KL-241-LOG/main/install.sh | bash -s "abc123.xYz_DEF456" "987654321098765432" "ru"
```
*✅ После выполнения бот запустится в фоне и начнёт писать логи!*

---

## 🛠️ Ручная установка

1. Клонируйте репозиторий:
   ```bash
   git clone https://github.com/WilayzJerti/KL-241-LOG
   cd KL-241-LOG
   ```
2. Выберите нужную языковую версию бота и переименуйте её в bot.py:
   ```bash
    # Для русского языка:
    cp bot_ru.py bot.py

    # Или для английского:
    cp bot_en.py bot.py
   ```
3. Соберите образ:
   ```bash
   docker build -t kl-241-log .
   ```
4. Запустите контейнер:
   ```bash
   docker run -d \
   --name kl-241-log \
   --restart unless-stopped \
   -e DISCORD_BOT_TOKEN="ваш_токен" \
   -e LOG_CHANNEL_ID="id_канала" \
   kl-241-log
   ```

---

## 🔍 Работает ли бот?

```bash
docker logs kl-241-log
```
Вы должны увидеть сообщение:
`✅ Бот kl-241-log запущен и готов к работе!`

---

## 💬 Поддержка

Нашли баг? Есть идеи для дополнения бота?

→ [Откройте Issue !](https://github.com/WilayzJerti/KL-241-LOG/issues)
