import discord
from discord.ext import commands
import datetime
import os

TOKEN = os.getenv('DISCORD_BOT_TOKEN')
if not TOKEN:
    raise ValueError("Токен не задан! Укажите переменную окружения DISCORD_BOT_TOKEN.")

LOG_CHANNEL_ID = int(os.getenv('LOG_CHANNEL_ID', '0'))
if LOG_CHANNEL_ID == 0:
    raise ValueError("ID лог-канала не задан! Укажите переменную окружения LOG_CHANNEL_ID.")

intents = discord.Intents.default()
intents.voice_states = True  

bot = commands.Bot(command_prefix='!', intents=intents)

@bot.event
async def on_ready():
    print(f'Бот {bot.user} успешно запущен!')

@bot.event
async def on_voice_state_update(member, before, after):
    log_channel = bot.get_channel(LOG_CHANNEL_ID)
    if not log_channel:
        print("❌ Канал для логов не найден!")
        return

    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # Пользователь зашёл в голосовой канал
    if before.channel is None and after.channel is not None:
        message = f"🕒 [{now}] **{member.display_name}** (`{member.id}`) зашёл в голосовой канал **{after.channel.name}**."
        await log_channel.send(message)

    # Пользователь вышел из голосового канала
    elif before.channel is not None and after.channel is None:
        message = f"🕒 [{now}] **{member.display_name}** (`{member.id}`) вышел из голосового канала **{before.channel.name}**."
        await log_channel.send(message)

    # Пользователь перешёл между каналами
    elif before.channel != after.channel and after.channel is not None:
        message = f"🕒 [{now}] **{member.display_name}** (`{member.id}`) перешёл из **{before.channel.name}** в **{after.channel.name}**."
        await log_channel.send(message)


bot.run(TOKEN)