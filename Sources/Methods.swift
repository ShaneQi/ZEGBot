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

let SEND_MESSAGE =                  "sendMessage"
let FORWARD_MESSAGE =               "forwardMessage"
let SEND_PHOTO =                    "sendPhoto"
let MESSAGE_ID =                    "message_id"
let FROM_CHAT_ID =                  "from_chat_id"
let PHOTO =                         "photo"
let AUDIO =                         "audio"
let CAPTION =                       "caption"
let TEXT =                          "text"
let PARSE_MODE =                    "parse_mode"
let DISABLE_WEB_PAGE_PREVIEW =      "disable_web_page_preview"
let DISABLE_NOTIFICATION =          "disable_notification"

let POST_JSON_HEADER_CONTENT_TYPE = "Content-Type: application/json"

let RESULT =                        "result"

extension ZEGBot {
    
    public func send(message text: String, to receiver: Sendable,
                            parseMode: ParseMode? = nil,
                            disableWebPagePreview: Bool = false,
                            disableNotification: Bool = false) -> Message? {
        
        var payload: [String: Any] = [
            TEXT: text
        ]
        
        if let parseMode = parseMode { payload[PARSE_MODE] = parseMode }
        if disableWebPagePreview { payload[DISABLE_WEB_PAGE_PREVIEW] = true }
        
        if disableNotification { payload[DISABLE_NOTIFICATION] = true }
        payload.append(contentOf: receiver.receiverIdentifier)
        
        guard let responseDictionary = perform(method: SEND_MESSAGE, payload: payload) as? [String: Any] else {
            return nil
        }
            
        return Message(from: responseDictionary[RESULT])
        
    }
    
    public func forward(message: Message, to receiver: Sendable,
                               disableNotification: Bool = false) -> Message? {
        
        var payload: [String: Any] = [
            MESSAGE_ID: message.message_id,
            FROM_CHAT_ID: message.chat.id
        ]
        
        if disableNotification { payload[DISABLE_NOTIFICATION] = true }
        payload.append(contentOf: receiver.receiverIdentifier)
        
        guard let responseDictionary = perform(method: FORWARD_MESSAGE, payload: payload) as? [String: Any] else {
            return nil
        }
        
        return Message(from: responseDictionary[RESULT])

    }
    
    public func sned(contentOnServer content: Identifiable, to receiver: Sendable,
                     disableNotification: Bool = false) -> Message? {
        
        var payload = content.identifier
        
        if disableNotification { payload[DISABLE_NOTIFICATION] = true }
        payload.append(contentOf: receiver.receiverIdentifier)
        
        guard let responseDictionary = perform(method: SEND_PHOTO, payload: payload) as? [String: Any] else {
            return nil
        }
        
        return Message(from: responseDictionary[RESULT])
        
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
        curl.setOption(CURLOPT_HTTPHEADER, s: POST_JSON_HEADER_CONTENT_TYPE)
        
        let responseString = curl.performFully().2.reduce("", { a, b in a + String(UnicodeScalar(b)) })
            
        do {
            return try responseString.jsonDecode()
        } catch {
            Log.warning(on: responseString)
            return nil
        }
        
    }
    
}
