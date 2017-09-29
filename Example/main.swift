//
//  main.swift
//  ZEGBotExample
//
//  Created by Shane Qi on 9/28/17.
//

import ZEGBot
import Foundation

let bot = ZEGBot(token: "229521725:AAHM_LCcQ1vT3hV8_wP_YawriyBvfbpJN3A")

bot.run { update, _ in
	dump(update)
}
