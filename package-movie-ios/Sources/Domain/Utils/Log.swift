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
    static public func d(_ content: Any) -> Void {
        #if DEBUG
        print("🐛🐛🐛 <-- ++ DEBUG -->\n \(content)\n🐛🐛🐛 <--- End ---> \n")
        #endif
    }
    
    static public func i(_ content: Any) -> Void {
        #if DEBUG
        print("💡💡💡 <-- ++ INFO --> \n \(content)\n💡💡💡<--- End --->\n")
        #endif
    }
    
    static public func e(_ content: Any) -> Void {
        #if DEBUG
        print("🔴🔴🔴 <-- ++ ERROR --> :\n \(content)\n🔴🔴🔴<--- End --->\n")
        #endif
    }
    
    static public func w(_ content: Any) -> Void {
        #if DEBUG
        print("⚠️⚠️⚠️ <-- ++ WARNING --> :\n \(content)\n⚠️⚠️⚠️<--- End --->\n")
        #endif
    }
    
    static public func v(_ content: Any) -> Void {
        #if DEBUG
        print("👾👾👾 <-- ++ VERBOSE --> :\n \(content)\n👾👾👾<--- End --->\n")
        #endif
    }
}
