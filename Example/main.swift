//
//  main.swift
//  ZEGBotExample
//
//  Created by Shane Qi on 9/28/17.
//

import ZEGBot
import Foundation

let bot = ZEGBot(token: "TYPE YOUR TOKEN HERE")

// swiftlint:disable force_try
try! bot.run { update, bot in
	dump(update)
}
