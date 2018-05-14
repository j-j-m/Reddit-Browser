//
//  UIView+Borders.swift
//  FormLibrary
//
//  Created by Jacob Martin on 5/6/18.
//  Copyright © 2018 jjm. All rights reserved.
//

import Foundation

public extension UIView {
    
    /// add border subviews
    ///
    /// - Parameters:
    ///   - edges: edges to add
    ///   - color: color of edges added
    ///   - thickness: thickness of edges added
    /// - Returns: array of views added
    public func addBorder(edges: UIRectEdge,
                   color: UIColor = UIColor.white,
                   thickness: CGFloat = 1.0,
                   insetTop: UIEdgeInsets = UIEdgeInsets(),
                   insetBottom: UIEdgeInsets = UIEdgeInsets(),
                   insetLeft: UIEdgeInsets = UIEdgeInsets(),
                   insetRight: UIEdgeInsets = UIEdgeInsets()) -> [UIView] {
        
        var borders = [UIView]()
        
        func border() -> UIView {
            let border = UIView(frame: CGRect.zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            return border
        }
        
        if edges.contains(.top) || edges.contains(.all) {
            let top = border()
            addSubview(top)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(t)-[top(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness,
                                                         "t": insetTop.top],
                                               views: ["top": top]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(l)-[top]-(r)-|",
                                               options: [],
                                               metrics: ["l": insetTop.left,
                                                         "r": insetTop.right],
                                               views: ["top": top]))
            borders.append(top)
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            let left = border()
            addSubview(left)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(l)-[left(==thickness)]",
                                               options: [],
                                               metrics: ["thickness": thickness,
                                                         "l": insetLeft.left],
                                               views: ["left": left]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(t)-[left]-(b)-|",
                                               options: [],
                                               metrics: ["t": insetLeft.top,
                                                         "b": insetLeft.bottom],
                                               views: ["left": left]))
            borders.append(left)
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            let right = border()
            addSubview(right)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:[right(==thickness)]-(r)-|",
                                               options: [],
                                               metrics: ["thickness": thickness,
                                                         "r": insetRight.right],
                                               views: ["right": right]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:|-(t)-[right]-(b)-|",
                                               options: [],
                                               metrics: ["t": insetRight.top,
                                                         "b": insetRight.bottom],
                                               views: ["right": right]))
            borders.append(right)
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            let bottom = border()
            addSubview(bottom)
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "V:[bottom(==thickness)]-(b)-|",
                                               options: [],
                                               metrics: ["thickness": thickness,
                                                         "b": insetBottom.bottom],
                                               views: ["bottom": bottom]))
            addConstraints(
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-(l)-[bottom]-(r)-|",
                                               options: [],
                                               metrics: ["l": insetBottom.left,
                                                         "r": insetBottom.right],
                                               views: ["bottom": bottom]))
            borders.append(bottom)
        }
        
        return borders
    }
    
}

