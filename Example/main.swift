//
//  main.swift
//  ZEGBotExample
//
//  Created by Shane Qi on 9/28/17.
//

import ZEGBot
import Foundation

let bot = ZEGBot(token: "229521725:AAHM_LCcQ1vT3hV8_wP_YawriyBvfbpJN3A")

bot.run { updateResult, _ in
	switch updateResult {
	case .success(let update):
		dump(update)
	case .failure(let error):
		dump(error)
	}
}
