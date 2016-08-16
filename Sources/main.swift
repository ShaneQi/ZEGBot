let zegbot = ZEGBot(token: secret)


zegbot.run() {
    bot, update in
    if let photo = update.message?.photo?.last {
        print(bot.send(contentOnServer: photo, to: (update.message?.chat)!, disableNotification: true))
    }
}
