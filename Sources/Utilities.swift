//
//  Utilities.swift
//  ZEGBot
//
//  Created by Shane Qi on 8/10/16.
//
//

extension String {

	func bytes() -> [UInt8] {
		return [UInt8](self.utf8)
	}

}

struct Log {

	static func warning(message: String) {
		print("[⚠️WARN] \(message)")
	}

	static func warning(on object: Any) {
		self.warning(message: "====>>>====<<<====")
		self.warning(message: "Failed to convert:")
		self.warning(message: "\(object)")
	}

	static func warning(onMethod method: String) {
		self.warning(message: "====>>>====<<<====")
		self.warning(message: "Failed in method: \(method)")
	}

}

extension Dictionary {

	mutating func append(contentOf dictionary: [Key: Value]) {
		for (key, value) in dictionary {
			self[key] = value
		}
	}

	mutating func append(contentOf dictionary: [Key: Value?]) {
		for (key, optionalValue) in dictionary {
			if let value = optionalValue { self[key] = value }
		}
	}

}
