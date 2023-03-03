//
//  Data++.swift
//  
//
//  Created by Luu Phan on 01/03/2023.
//

import Foundation

public extension Data {
    func callAsFunction<T: Codable>() -> T? {
        guard let value = try? JSONDecoder().decode(T.self, from: self) else { return nil }
        return value
    }
    
    func jsonFormatter() -> String {
            do {
                let dataAsJSON = try JSONSerialization.jsonObject(with: self)
                let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
                return String(data: prettyData, encoding: .utf8) ?? String(data: self, encoding: .utf8) ?? ""
            } catch {
                return String(data: self, encoding: .utf8) ?? ""
            }
        }
}
