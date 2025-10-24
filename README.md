# 👁️KL-241-LOG

> 🤖 A simple and reliable Discord bot in Python that **automatically logs members joining/leaving voice channels**.

![Python](https://img.shields.io/badge/Python-3.11%2B-blue?logo=python)
![Docker](https://img.shields.io/badge/Docker-Required-blue?logo=docker)
![License](https://img.shields.io/badge/License-MIT-green)
![Language EN](https://github.com/WilayzJerti/KL-241-LOG/blob/main/README.md)
---

## 🌟 Features

- ✅ Logging voice channel joins  
- ✅ Logging voice channel leaves  
- ✅ Logging moves between channels  
- 🕒 Accurate event timestamps (server-local time)  
- 🐳 Full Docker support — easy to deploy in 10 seconds  
- 🔒 Secure token handling via environment variables

---

## 🚀 Quick install (Linux/macOS)

> Requirements: `curl`, `bash`, and **Docker** (the script can install it automatically on Ubuntu/Debian).

Run **one command** in the terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/WilayzJerti/KL-241-LOG/main/install.sh | bash -s "YOUR_BOT_TOKEN" "TEXT_CHANNEL_ID" "Language"
```


**🔑 Where to get them?**   
  - Bot token: [Discord Developer Portal → Applications → Bot → Token](https://discord.com/developers/applications?spm=a2ty_o01.29997173.0.0.59cb5171Rbn7to "Discord Developer")
        
  - Channel ID: Enable Developer Mode in Discord  → Right-click the channel → "Copy ID"



**🌍 Language selection:**

Two log languages are supported: 

  - ru — Russian
  - en — English
      
Example run command:
```bash
curl -fsSL https://raw.githubusercontent.com/WilayzJerti/KL-241-LOG/main/install.sh | bash -s "abc123.xYz_DEF456" "987654321098765432" "en"
```
*✅ After completion the bot will run in the background and start writing logs!*

---

## 🛠️ Manual installation

1. Clone the repository:
   ```bash
   git clone https://github.com/WilayzJerti/KL-241-LOG
   cd KL-241-LOG
   ```
2. Choose the desired language version of the bot and rename it to bot.py:
   ```bash
    # For Russian language:
    cp bot_ru.py bot.py

    # Or for English:
    cp bot_en.py bot.py
   ```
3. Build the image:
   ```bash
   docker build -t kl-241-log .
   ```
4. Run the container:
   ```bash
   docker run -d \
   --name kl-241-log \
   --restart unless-stopped \
   -e DISCORD_BOT_TOKEN="your_token" \
   -e LOG_CHANNEL_ID="channel_id" \
   kl-241-log
   ```

---

## 🔍 Is the bot running?

```bash
docker logs kl-241-log
```
You should see the message:
`✅ Bot kl-241-log started and ready to work!`

---

## 💬 Support

Found a bug? Have ideas to improve the bot?

→ [Open an Issue!](https://github.com/WilayzJerti/KL-241-LOG/issues)