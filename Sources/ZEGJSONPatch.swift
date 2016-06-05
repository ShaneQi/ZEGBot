//
//  ZEGJSONPatch.swift
//  ZEGBot
//
//  Created by Shane Qi on 6/4/16.
//  Copyright © 2016 com.github.shaneqi. All rights reserved.
//

#if os(Linux)
	import SwiftGlibc
#else
	import Darwin
#endif

import PerfectLib

private let jsonBackSlash = UnicodeScalar(UInt32(92))
private let jsonBackSpace = UnicodeScalar(UInt32(8))
private let jsonFormFeed = UnicodeScalar(UInt32(12))
private let jsonLF = UnicodeScalar(UInt32(10))
private let jsonCR = UnicodeScalar(UInt32(13))
private let jsonTab = UnicodeScalar(UInt32(9))
private let jsonQuoteDouble = UnicodeScalar(UInt32(34))

private let jsonOpenObject = UnicodeScalar(UInt32(123))
private let jsonOpenArray = UnicodeScalar(UInt32(91))
private let jsonCloseObject = UnicodeScalar(UInt32(125))
private let jsonCloseArray = UnicodeScalar(UInt32(93))
private let jsonWhiteSpace = UnicodeScalar(UInt32(32))
private let jsonColon = UnicodeScalar(UInt32(58))
private let jsonComma = UnicodeScalar(UInt32(44))

private let highSurrogateLowerBound = UInt32(strtoul("d800", nil, 16))
private let highSurrogateUpperBound = UInt32(strtoul("dbff", nil, 16))
private let lowSurrogateLowerBound = UInt32(strtoul("dc00", nil, 16))
private let lowSurrogateUpperBound = UInt32(strtoul("dfff", nil, 16))
private let surrogateStep = UInt32(strtoul("400", nil, 16))
private let surrogateBase = UInt32(strtoul("10000", nil, 16))

extension String {
	public func zegJsonDecode() throws -> JSONConvertible {
		
		let state = ZEGJSONDecodeState()
		state.g = self.unicodeScalars.generate()
		
		let o = try state.readObject()
		if let _ = o as? ZEGJSONDecodeState.EOF {
			throw JSONConversionError.SyntaxError
		}
		return o
	}
}

public struct JSONConvertibleNull: JSONConvertible {
	public func jsonEncodedString() throws -> String {
		return "null"
	}
}

private class ZEGJSONDecodeState {
	
	struct EOF: JSONConvertible {
		func jsonEncodedString() throws -> String { return "" }
	}
	
	var g = String().unicodeScalars.generate()
	var pushBack: UnicodeScalar?
	
	func movePastWhite() {
		while let c = self.next() {
			if !c.isWhiteSpace() {
				self.pushBack = c
				break
			}
		}
	}
	
	func readObject() throws -> JSONConvertible {
		
		self.movePastWhite()
		
		guard let c = self.next() else {
			return EOF()
		}
		
		switch(c) {
		case jsonOpenArray:
			var a = [Any]()
			self.movePastWhite()
			guard let c = self.next() else {
				throw JSONConversionError.SyntaxError
			}
			if c != jsonCloseArray {
				self.pushBack = c
				while true {
					a.append(try readObject())
					self.movePastWhite()
					guard let c = self.next() else {
						throw JSONConversionError.SyntaxError
					}
					if c == jsonCloseArray {
						break
					}
					if c != jsonComma {
						throw JSONConversionError.SyntaxError
					}
				}
			}
			return a
		case jsonOpenObject:
			var d = [String:Any]()
			self.movePastWhite()
			guard let c = self.next() else {
				throw JSONConversionError.SyntaxError
			}
			if c != jsonCloseObject {
				self.pushBack = c
				while true {
					guard let key = try readObject() as? String else {
						throw JSONConversionError.SyntaxError
					}
					self.movePastWhite()
					guard let c = self.next() else {
						throw JSONConversionError.SyntaxError
					}
					guard c == jsonColon else {
						throw JSONConversionError.SyntaxError
					}
					self.movePastWhite()
					d[key] = try readObject()
					do {
						self.movePastWhite()
						guard let c = self.next() else {
							throw JSONConversionError.SyntaxError
						}
						if c == jsonCloseObject {
							break
						}
						if c != jsonComma {
							throw JSONConversionError.SyntaxError
						}
					}
				}
			}
			if let objid = d[JSONDecoding.objectIdentifierKey] as? String {
				if let o = JSONDecoding.createJSONConvertibleObject(objid, values: d) {
					return o
				}
			}
			return d
		case jsonQuoteDouble:
			return try readString()
		default:
			if c.isWhiteSpace() {
				// nothing
			} else if c.isDigit() || c == "-" || c == "+" {
				return try readNumber(c)
			} else if c == "t" || c == "T" {
				return try readTrue()
			} else if c == "f" || c == "F" {
				return try readFalse()
			} else if c == "n" || c == "N" {
				try readNull()
				return JSONConvertibleNull()
			}
		}
		throw JSONConversionError.SyntaxError
	}
	
	func next() -> UnicodeScalar? {
		if pushBack != nil {
			let c = pushBack!
			pushBack = nil
			return c
		}
		return g.next()
	}
	
	// the opening quote has been read
	func readString() throws -> String {
		var next = self.next()
		var esc = false
		var s = ""
		while let c = next {
			
			if esc {
				switch(c) {
				case jsonBackSlash:
					s.append(jsonBackSlash)
				case jsonQuoteDouble:
					s.append(jsonQuoteDouble)
				case "b":
					s.append(jsonBackSpace)
				case "f":
					s.append(jsonFormFeed)
				case "n":
					s.append(jsonLF)
				case "r":
					s.append(jsonCR)
				case "t":
					s.append(jsonTab)
				case "u":
					var hexStr = ""
					for _ in 1...4 {
						next = self.next()
						guard let hexC = next else {
							throw JSONConversionError.SyntaxError
						}
						guard hexC.isHexDigit() else {
							throw JSONConversionError.SyntaxError
						}
						hexStr.append(hexC)
					}
					var uint32Value = UInt32(strtoul(hexStr, nil, 16))
					// if unicode is a high/low surrogate, it can't be converted directly by UnicodeScalar
					// if it's a low surrogate (not expected), throw error
					if case lowSurrogateLowerBound...lowSurrogateUpperBound = uint32Value {
						throw JSONConversionError.SyntaxError
					}
					// if it's a high surrogate, find the low surrogate which the next unicode is supposed to be, then calculate the pair
					if case highSurrogateLowerBound...highSurrogateUpperBound = uint32Value {
						let highSurrogateValue = uint32Value
						guard self.next() == jsonBackSlash else {
							throw JSONConversionError.SyntaxError
						}
						guard self.next() == "u" else {
							throw JSONConversionError.SyntaxError
						}
						var lowSurrogateHexStr = ""
						for _ in 1...4 {
							next = self.next()
							guard let hexC = next else {
								throw JSONConversionError.SyntaxError
							}
							guard hexC.isHexDigit() else {
								throw JSONConversionError.SyntaxError
							}
							lowSurrogateHexStr.append(hexC)
						}
						let lowSurrogateValue = UInt32(strtoul(lowSurrogateHexStr, nil, 16))
						uint32Value = ( highSurrogateValue - highSurrogateLowerBound ) * surrogateStep + ( lowSurrogateValue - lowSurrogateLowerBound ) + surrogateBase
					}
					let result = UnicodeScalar(uint32Value)
					s.append(result)
				default:
					s.append(c)
				}
				esc = false
			} else if c == jsonBackSlash {
				esc = true
			} else if c == jsonQuoteDouble {
				return s
			} else {
				s.append(c)
			}
			
			next = self.next()
		}
		throw JSONConversionError.SyntaxError
	}
	
	func readNumber(firstChar: UnicodeScalar) throws -> JSONConvertible {
		var s = ""
		var needPeriod = true, needExp = true
		s.append(firstChar)
		
		if firstChar == "." {
			needPeriod = false
		}
		
		var next = self.next()
		var last = firstChar
		while let c = next {
			if c.isDigit() {
				s.append(c)
			} else if c == "." && !needPeriod {
				break
			} else if (c == "e" || c == "E") && !needExp {
				break
			} else if c == "." {
				needPeriod = false
				s.append(c)
			} else if c == "e" || c == "E" {
				needExp = false
				s.append(c)
				
				next = self.next()
				if next != nil && (next! == "-" || next! == "+") {
					s.append(next!)
				} else {
					pushBack = next!
				}
				
			} else if last.isDigit() {
				pushBack = c
				if needPeriod && needExp {
					return Int(s)!
				}
				return Double(s)!
			} else {
				break
			}
			last = c
			next = self.next()
		}
		
		throw JSONConversionError.SyntaxError
	}
	
	func readTrue() throws -> Bool {
		var next = self.next()
		if next != "r" && next != "R" {
			throw JSONConversionError.SyntaxError
		}
		next = self.next()
		if next != "u" && next != "U" {
			throw JSONConversionError.SyntaxError
		}
		next = self.next()
		if next != "e" && next != "E" {
			throw JSONConversionError.SyntaxError
		}
		next = self.next()
		guard next != nil && !next!.isAlphaNum() else {
			throw JSONConversionError.SyntaxError
		}
		pushBack = next!
		return true
	}
	
	func readFalse() throws -> Bool {
		var next = self.next()
		if next != "a" && next != "A" {
			throw JSONConversionError.SyntaxError
		}
		next = self.next()
		if next != "l" && next != "L" {
			throw JSONConversionError.SyntaxError
		}
		next = self.next()
		if next != "s" && next != "S" {
			throw JSONConversionError.SyntaxError
		}
		next = self.next()
		if next != "e" && next != "E" {
			throw JSONConversionError.SyntaxError
		}
		next = self.next()
		guard next != nil && !next!.isAlphaNum() else {
			throw JSONConversionError.SyntaxError
		}
		pushBack = next!
		return false
	}
	
	func readNull() throws {
		var next = self.next()
		if next != "u" && next != "U" {
			throw JSONConversionError.SyntaxError
		}
		next = self.next()
		if next != "l" && next != "L" {
			throw JSONConversionError.SyntaxError
		}
		next = self.next()
		if next != "l" && next != "L" {
			throw JSONConversionError.SyntaxError
		}
		next = self.next()
		guard next != nil && !next!.isAlphaNum() else {
			throw JSONConversionError.SyntaxError
		}
		pushBack = next!
	}
}
