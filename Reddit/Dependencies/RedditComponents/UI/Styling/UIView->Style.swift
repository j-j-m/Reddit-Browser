//
//  UIView->Style.swift
//  FormLibrary
//
//  Created by Jacob Martin on 5/4/18.
//  Copyright © 2018 jjm. All rights reserved.
//

import UIKit

/// Style border of view
///
/// - Parameters:
///   - color: border color
///   - width: width of border
/// - Returns: Styling function
public func border(color: UIColor, width: CGFloat) -> (UIView) -> Void {
    return {
        $0.layer.borderColor = color.cgColor
        $0.layer.borderWidth = width
    }
}

/// Style corner of a view
///
/// - Parameter radius: radius of corner
public func corner(radius: CGFloat) -> (UIView) -> Void {
    return {
        $0.layer.cornerRadius = radius
    }
}

/// Style background of view
///
///   - Parameter color: background color of view
/// - Returns: Styling function
public func background(color: UIColor) -> (UIView) -> Void {
    return {
        $0.backgroundColor = color
    }
}

// FIXME: - Strangely this doesnt work...

/// Prepare view for autolayout
///
///   - Parameter view: view to prepare
/// - Returns: Styling function
//public func autolayoutStyle(_ view: UIView) -> (UIView) -> Void {
//    return {
//        $0.autolayoutMode()
//    }
//}
