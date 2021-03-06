//
//  UIColor+Hex.swift
//  Reddit
//
//  Created by Jacob Martin on 5/13/18.
//  Copyright © 2018 jjm. All rights reserved.
//

import UIKit

public extension UIColor {
    
    /// Color from hex
    ///
    /// - Parameter hex: hexidecimal interger representing color code
    public convenience init(_ hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
