//
//  ZEGBot.swift
//  ZEGBot
//
//  Created by Shane Qi on 7/18/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import cURL
import PerfectCURL
import PerfectLib
import PerfectThread

public struct ZEGBot {
    
	private var token: String
	internal var urlPrefix: String
    
    init(token: String) {
        self.token = token
        self.urlPrefix = "https://api.telegram.org/bot"+token+"/"
    }

	
    func run(with handler: @escaping (ZEGBot, Update) -> Void ) {

		let curl = CURL()
		var offset = 0

		while true {

			curl.url = urlPrefix + "getupdates?timeout=60&offset=\(offset)"
			
			let responseBodyString = curl.performFully().2.reduce("", { a, b in a + String(UnicodeScalar(b)) })
			
			guard let updates = ZEGBot.decodeUpdates(from: responseBodyString) else { continue }

			if let lastUpdate = updates.last { offset = lastUpdate.update_id + 1 }
			
            for update in updates {
                Threading.dispatch {
                    handler(self, update)
                }
            }
			
		}
		
	}
    
	
}

extension ZEGBot {

    /* For getUpdates. */
    static func decodeUpdates(from jsonString: String) -> [Update]? {
        
        do {
            
            let jsonConvertibleObject = try jsonString.jsonDecode()
            
            guard let
                jsonDictionary = jsonConvertibleObject as? [String: Any],
                let updatesDictionaryArrayObject = jsonDictionary["result"],
                let updatesDictionaryArray = updatesDictionaryArrayObject as? [Any]
                else {
                    
                    Log.warning(on: jsonConvertibleObject)
                    return nil
                    
            }
            
            var updates = [Update]()
            
            for updateDictionaryObject in updatesDictionaryArray {
                
                if let update = Update(from: updateDictionaryObject) {
                    
                    updates.append(update)
                    
                }
                
            }
            
            return updates
            
        } catch {
            
            Log.warning(on: jsonString)
            return nil
            
        }
        
    }
    
    /* For webhook. */
    static func decodeUpdate(from jsonString: String) -> Update? {
        
        do {
            
            let jsonConvertibleObject = try jsonString.jsonDecode()
            
            return Update(from: jsonConvertibleObject)
            
        } catch {
            
            Log.warning(on: jsonString)
            return nil
            
        }
        
    }
    
}
