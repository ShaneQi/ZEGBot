//
//  Methods.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/29/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import PerfectCURL
import cURL
import PerfectLib

extension ZEGBot {
	
	internal struct PARAM {
		static let DISABLE_NOTIFICATION =          "disable_notification"
		static let POST_JSON_HEADER_CONTENT_TYPE = "Content-Type: application/json"
		static let RESULT =                        "result"
		
		static let SEND_MESSAGE =                  "sendMessage"
		static let TEXT =                          "text"
		static let PARSE_MODE =                    "parse_mode"
		static let DISABLE_WEB_PAGE_PREVIEW =      "disable_web_page_preview"
		
		static let FORWARD_MESSAGE =               "forwardMessage"
		static let MESSAGE_ID =                    "message_id"
		static let FROM_CHAT_ID =                  "from_chat_id"
		
		static let CAPTION =                       "caption"
		
	}
	
    public func send(message text: String, to receiver: Sendable,
                            parseMode: ParseMode? = nil,
                            disableWebPagePreview: Bool = false,
                            disableNotification: Bool = false) -> Message? {
        
        var payload: [String: Any] = [
            PARAM.TEXT: text
        ]
        
        if let parseMode = parseMode { payload[PARAM.PARSE_MODE] = parseMode }
        if disableWebPagePreview { payload[PARAM.DISABLE_WEB_PAGE_PREVIEW] = true }
        
        if disableNotification { payload[PARAM.DISABLE_NOTIFICATION] = true }
        payload.append(contentOf: receiver.receiverIdentifier)
        
        guard let responseDictionary = perform(method: PARAM.SEND_MESSAGE, payload: payload) as? [String: Any] else {
            return nil
        }
            
        return Message(from: responseDictionary[PARAM.RESULT])
        
    }
    
    public func forward(message: Message, to receiver: Sendable,
                               disableNotification: Bool = false) -> Message? {
        
        var payload: [String: Any] = [
            PARAM.MESSAGE_ID: message.message_id,
            PARAM.FROM_CHAT_ID: message.chat.id
        ]
        
        if disableNotification { payload[PARAM.DISABLE_NOTIFICATION] = true }
        payload.append(contentOf: receiver.receiverIdentifier)
        
        guard let responseDictionary = perform(method: PARAM.FORWARD_MESSAGE, payload: payload) as? [String: Any] else {
            return nil
        }
        
        return Message(from: responseDictionary[PARAM.RESULT])

    }
    
    public func send(contentOnServer content: Identifiable, to receiver: Sendable,
                     disableNotification: Bool = false) -> Message? {
        
        var payload = content.identifier
        
        if disableNotification { payload[PARAM.DISABLE_NOTIFICATION] = true }
        payload.append(contentOf: receiver.receiverIdentifier)
        
        guard let responseDictionary = perform(method: content.sendingMethod, payload: payload) as? [String: Any] else {
            return nil
        }
        
        return Message(from: responseDictionary[PARAM.RESULT])
        
    }
    
    private func perform(method: String, payload: [String: Any]) -> Any? {
        
        var bodyBytes = [UInt8]()
        
        do {
            bodyBytes.append(contentsOf: try payload.jsonEncodedString().bytes())
        } catch {
            Log.warning(on: payload)
            return nil
        }
        
        let curl = CURL()
        curl.url = urlPrefix + method
        curl.setOption(CURLOPT_POSTFIELDS, v: &bodyBytes)
        curl.setOption(CURLOPT_HTTPHEADER, s: PARAM.POST_JSON_HEADER_CONTENT_TYPE)
        
        let responseString = curl.performFully().2.reduce("", { a, b in a + String(UnicodeScalar(b)) })
            
        do {
            return try responseString.jsonDecode()
        } catch {
            Log.warning(on: responseString)
            return nil
        }
        
    }
    
}
