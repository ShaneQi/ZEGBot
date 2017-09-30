//
//  main.swift
//  ZEGBotExample
//
//  Created by Shane Qi on 9/28/17.
//

import ZEGBot
import Foundation

let bot = ZEGBot(token: "229521725:AAHM_LCcQ1vT3hV8_wP_YawriyBvfbpJN3A")

bot.run { updateResult, bot in
	switch updateResult {
	case .success(let update):
		dump(update)
		bot.send(chatAction: .uploadVideo, toChat: update.message!.chatId)
		bot.send(message: "hello", to: update.message!)
		bot.forward(message: update.message!, to: update.message!)
		bot.send(photo: "AgADBQAD86cxGxcecFYNl5Ur6EaRZMsMzDIABAjm04jdYU5dgdUCAAEC", caption: "picture", to: update.message!)
		bot.send(sticker: "CAADBQADlAEAAhETzQRnLs_zdvA7bAI", to: update.message!)
		dump(bot.getFile(ofId: "AgADBQAD86cxGxcecFYNl5Ur6EaRZMsMzDIABAjm04jdYU5dgdUCAAEC"))
	case .failure(let error):
		dump(error)
	}
}
