//
//  main.swift
//  ZEGBotExample
//
//  Created by Shane Qi on 9/28/17.
//

import ZEGBot
import Foundation

let bot = ZEGBot(token: "TYPE YOUR TOKEN HERE")

bot.run { updateResult, bot in
	switch updateResult {
	case .success(let update):
		dump(update)
	case .failure(let error):
		dump(error)
	}
}
