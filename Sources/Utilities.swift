//
//  Utilities.swift
//  ZEGBot
//
//  Created by Shane Qi on 8/10/16.
//
//

import PerfectLib

extension String {

    func bytes() -> [UInt8]{
        return [UInt8](self.utf8)
    }
    
}

extension Log {
    
    static func warning(on object: Any) {
        self.warning(message: "Failed to convert: ===>>> \(object) <<<===")
    }
    
}

extension Dictionary {
    
    mutating func append(contentOf dictionary: [Key: Value]) {
        for (key, value) in dictionary {
            self[key] = value
        }
    }
    
}
