//
//  UIColor+Random.swift
//  Reddit
//
//  Created by Jacob Martin on 5/12/18.
//  Copyright © 2018 jjm. All rights reserved.
//

import UIKit

public extension CGFloat {
    public static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

public extension UIColor {
    public static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}
