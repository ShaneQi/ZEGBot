//
//  PerfectHandler.swift
//  ZEGBotExample
//
//  Created by Shane Qi on 6/3/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import PerfectLib

/* TOKEN HAVE TO BE EDITED. */
let token = "123456789:ABCD_RFGHIvJKLM8_wN_OawriyPvfbpQR3S"

public func PerfectServerModuleInit() {
	
	Routing.Handler.registerGlobally()
	
	Routing.Routes["POST", ["/", "index.html"] ] = { _ in return ZEGBotHandler.sharedInstance }

}

class ZEGBotHandler: RequestHandler {
	
	static let sharedInstance = ZEGBotHandler()
	
	/* Count received updates. */
	private var count = 0;
	
	func handleRequest(request: WebRequest, response: WebResponse) {
		
		let update = ZEGDecoder.decodeUpdate(request.postBodyString)
		
		count += 1
		
		/* =============================== */
		/* Bot respond rules go from here. */
		/* =============================== */

		if let message = update?.message, locationA = message.location, locationB = message.reply_to_message?.location , userB = message.reply_to_message?.from?.first_name{
			
			let distance = Int(ZEGBotPlugin.distance(between: locationA, and: locationB))
			
			ZEGResponse.sendMessage(to: message, text: "\(userB) is *\(distance)* miles away from you.", parse_mode: .Markdown, disable_web_page_preview: nil, disable_notification: nil)
			
		}
		
		if let message = update?.message, text = message.text {
		
			switch text.uppercaseString {
			case "FOO":
				/* Reply "bar". */
				ZEGResponse.sendMessage(to: message.chat, text: "bar", parse_mode: nil, disable_web_page_preview: nil, disable_notification: nil)
			case "/COUNT":
				/* Reply the count of updates with Markdown syntax. */
				ZEGResponse.sendMessage(to: message, text: "I've received *\(count)* updates. - [ZEGBot](https://github.com/ShaneQi/ZEGBot)", parse_mode: .Markdown, disable_web_page_preview: true, disable_notification: nil)
			default:
				break
			}
		}
		
		/* =========================== */
		/* Bot respond rules end here. */
		/* =========================== */
		
		response.requestCompletedCallback()
		
	}
}
