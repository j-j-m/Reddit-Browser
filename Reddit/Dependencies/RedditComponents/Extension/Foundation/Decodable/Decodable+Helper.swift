//
//  Decodable+Helper.swift
//  Reddit
//
//  Created by Jacob Martin on 5/13/18.
//  Copyright © 2018 jjm. All rights reserved.
//

import Foundation

public extension Decodable {
    

    /// Helper method to decode Data to Decodable type.
    ///
    /// - Parameter data: data to decode.
    /// - Returns: object of decodable type.
    /// - Throws: Decoding error.
    public static func decode(from data: Data) throws -> Self {
   
        let decoder = JSONDecoder()
        do {
            let o = try decoder.decode(Self.self, from: data)
            return o
        } catch {
            throw error
        }
    }
}
