let zegbot = ZEGBot(token: secret)

zegbot.run() {
    bot, update in
    bot.send()
    print(update)
}
