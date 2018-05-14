//
//  String+Service.swift
//  Reddit
//
//  Created by Jacob Martin on 5/11/18.
//  Copyright © 2018 jjm. All rights reserved.
//

import Foundation

public extension String {
    
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
