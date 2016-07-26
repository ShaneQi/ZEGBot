//
//  ZEGDecoder.swift
//  ZEGBot
//
//  Created by Shane Qi on 5/10/16.
//  Copyright © 2016 Shane. All rights reserved.
//
//  Licensed under Apache License v2.0
//

import PerfectLib

struct ZEGDecoder {
	
	/* For getUpdates. */
	static func decodeUpdates(from jsonString: String) -> [Update]? {
		
		do {
			
			let jsonConvertibleObject = try jsonString.jsonDecode()
			
			guard let
				jsonDictionary = jsonConvertibleObject as? [String: Any],
				updatesDictionaryArrayObject = jsonDictionary["result"],
				updatesDictionaryArray = updatesDictionaryArrayObject as? [Any]
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
