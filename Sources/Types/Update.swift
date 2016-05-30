//
//  Update.swift
//  zeg_bot
//
//  Created by Shane Qi on 5/9/16.
//  Copyright © 2016 Shane. All rights reserved.
//

public struct Update {
	
	var update_id: Int
	
	/* Optional. */
	var message: Message?
	var edited_message: Message?
//	var inline_query: InlineQuery?
//	var chosen_inline_result: ChosenInlineResult?
//	var callback_query: CallbackQuery?
	
	init(update_id: Int,
	     message: Message?,
	     edited_message: Message?
//		 inline_query: InlineQuery?,
//		 chosen_inline_result: ChosenInlineResult?,
//		 callback_query: CallbackQuery?
		) {
		
		self.update_id = update_id
		self.edited_message = edited_message
		self.message = message
//		self.inline_query = inline_query
//		self.chosen_inline_result = chosen_inline_result
//		self.callback_query = callback_query
		
	}
	
}
