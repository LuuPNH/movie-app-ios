//
//  dlog.swift
//  
//
//  Created by Luu Phan on 16/02/2023.
//

import Foundation

public func dLog(_ message: String) {
    #if DEBUG
    print("DEBUG: \(message)");
    #endif
}

public class Logger {
    
    static public func d(_ content: Any, fileName: String = "Unkown path") -> Void {
        #if DEBUG
        print("🐛🐛🐛 <-- ++ DEBUG --> \n 👉 Path: \(fileName) \n 👉 Content: \(content)\n 🐛🐛🐛 <--- End ---> \n")
        #endif
    }
    
    static public func i(_ content: Any, fileName: String = "Unkown path") -> Void {
        #if DEBUG
        print("💡💡💡 <-- ++ INFO --> \n 👉 Path file: \(fileName) \n 👉 Content: \(content)\n 💡💡💡 <--- End --->\n")
        #endif
    }
    
    static public func e(_ content: Any, fileName: String = "Unkown path") -> Void {
        #if DEBUG
        print("⛔⛔⛔ <-- ++ ERROR --> \n 👉 Path file: \(fileName) \n 👉 Content: \(content)\n ⛔⛔⛔ <--- End --->\n")
        #endif
    }
    
    static public func w(_ content: Any, fileName: String = "Unkown path") -> Void {
        #if DEBUG
        print("⚠️⚠️⚠️ <-- ++ WARNING --> \n 👉 Path file: \(fileName) :\n 👉 Content: \(content)\n ⚠️⚠️⚠️ <--- End --->\n")
        #endif
    }
    
    static public func v(_ content: Any, fileName: String = "Unkown path") -> Void {
        #if DEBUG
        print("👾👾👾 <-- ++ VERBOSE --> \n 👉 Path file: \(fileName) :\n 👉 Content: \(content)\n 👾👾👾 <--- End --->\n")
        #endif
    }
}
