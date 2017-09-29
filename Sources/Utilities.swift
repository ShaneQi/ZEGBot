//
//  Utilities.swift
//  ZEGBot
//
//  Created by Shane Qi on 8/10/16.
//
//

public enum Result<Value> {
	case success(Value)
	case failure(Error)
}

//extension String {
//
//	func bytes() -> [UInt8] {
//		return [UInt8](utf8)
//	}
//
//}

//struct Log {
//
//	static func warning(message: String) {
//		print("[⚠️WARN] \(message)")
//	}
//
//	static func warning(on object: Any) {
//		warning(message: "====>>>====<<<====")
//		warning(message: "Failed to convert:")
//		warning(message: "\(object)")
//	}
//
//	static func warning(onMethod method: String) {
//		warning(message: "====>>>====<<<====")
//		warning(message: "Failed in method: \(method)")
//	}
//
//}

//extension Dictionary {
//
//
//	/// Append content of another dictionary to self.
//	///
//	/// The value will override the original value if the key is duplicated.
//	///
//	/// - Parameter dictionary: the another dictionary
//	mutating func append(contentOf dictionary: [Key: Value]) {
//		for (key, value) in dictionary {
//			self[key] = value
//		}
//	}
//
//	/// Append content of another dictionary to self.
//	///
//	/// If the optional value has some value, it will override the original value if the key is duplicated.
//	/// But if the optional value is nil, it won't override the original value if the key is duplicated.
//	///
//	/// - Parameter dictionary: the another dictionary
//	mutating func append(contentOf dictionary: [Key: Value?]) {
//		for (key, optionalValue) in dictionary {
//			if let value = optionalValue { self[key] = value }
//		}
//	}
//
//}
