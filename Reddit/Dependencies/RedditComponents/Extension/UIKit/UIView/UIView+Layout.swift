//
//  UIView+Layout.swift
//  FormLibrary
//
//  Created by Jacob Martin on 5/4/18.
//  Copyright © 2018 jjm. All rights reserved.
//

import UIKit

public extension UIView {
    
    /// helper for prepping views for autolayout
    public func autolayoutMode() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
