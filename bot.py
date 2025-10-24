import discord
from discord.ext import commands
import datetime
import os

TOKEN = os.getenv('DISCORD_BOT_TOKEN')
if not TOKEN:
    raise ValueError("Token not set! Specify the environment variable DISCORD_BOT_TOKEN.")

LOG_CHANNEL_ID = int(os.getenv('LOG_CHANNEL_ID', '0'))
if LOG_CHANNEL_ID == 0:
    raise ValueError("Log channel ID not set! Specify the environment variable LOG_CHANNEL_ID.")

intents = discord.Intents.default()
intents.voice_states = True 

bot = commands.Bot(command_prefix='!', intents=intents)

@bot.event
async def on_ready():
    print(f'Bot {bot.user} successfully launched!')

@bot.event
async def on_voice_state_update(member, before, after):
    log_channel = bot.get_channel(LOG_CHANNEL_ID)
    if not log_channel:
        print("❌ Log channel not found!")
        return

    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    # The user entered the voice channel
    if before.channel is None and after.channel is not None:
        message = f"🕒 [{now}] **{member.display_name}** (`{member.id}`) joined the voice channel **{after.channel.name}**."
        await log_channel.send(message)

    # The user has left the voice channel
    elif before.channel is not None and after.channel is None:
        message = f"🕒 [{now}] **{member.display_name}** (`{member.id}`) left the voice channel **{before.channel.name}**."
        await log_channel.send(message)

    # The user switched between channels
    elif before.channel != after.channel and after.channel is not None:
        message = f"🕒 [{now}] **{member.display_name}** (`{member.id}`) transferred from **{before.channel.name}** in **{after.channel.name}**."
        await log_channel.send(message)


bot.run(TOKEN)