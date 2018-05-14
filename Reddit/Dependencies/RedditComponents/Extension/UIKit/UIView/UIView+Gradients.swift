//
//  UIView+Gradients.swift
//  Reddit
//
//  Created by Jacob Martin on 5/12/18.
//  Copyright © 2018 jjm. All rights reserved.
//

import UIKit

/// Point to Point for gradient.  start -> end
public typealias GradientType = (x: CGPoint, y: CGPoint)

/// Gradient Types
public enum GradientPoint {
    case leftRight
    case rightLeft
    case topBottom
    case bottomTop
    case topLeftBottomRight
    case bottomRightTopLeft
    case topRightBottomLeft
    case bottomLeftTopRight
    
    
    public func draw() -> GradientType {
        switch self {
        case .leftRight:
            return (x: CGPoint(x: 0, y: 0.5), y: CGPoint(x: 1, y: 0.5))
        case .rightLeft:
            return (x: CGPoint(x: 1, y: 0.5), y: CGPoint(x: 0, y: 0.5))
        case .topBottom:
            return (x: CGPoint(x: 0.5, y: 0), y: CGPoint(x: 0.5, y: 1))
        case .bottomTop:
            return (x: CGPoint(x: 0.5, y: 1), y: CGPoint(x: 0.5, y: 0))
        case .topLeftBottomRight:
            return (x: CGPoint(x: 0, y: 0), y: CGPoint(x: 1, y: 1))
        case .bottomRightTopLeft:
            return (x: CGPoint(x: 1, y: 1), y: CGPoint(x: 0, y: 0))
        case .topRightBottomLeft:
            return (x: CGPoint(x: 1, y: 0), y: CGPoint(x: 0, y: 1))
        case .bottomLeftTopRight:
            return (x: CGPoint(x: 0, y: 1), y: CGPoint(x: 1, y: 0))
        }
    }
}

public class GradientLayer: CAGradientLayer {
    public var gradient: GradientType? {
        didSet {
            startPoint = gradient?.x ?? CGPoint.zero
            endPoint = gradient?.y ?? CGPoint.zero
        }
    }
    
    public func randomize() {
        colors = [UIColor.random.cgColor, UIColor.random.cgColor]
        gradient = GradientPoint.topLeftBottomRight.draw()
    }
    
    public func setGradient(with point: GradientPoint, start: UIColor, end: UIColor) {
        colors = [start.cgColor, end.cgColor]
        gradient = point.draw()
    }
}

public protocol GradientBacked {
    func randomizeColors()
    func setGradient(with point: GradientPoint, start: UIColor, end: UIColor)
}

public extension GradientBacked where Self: UIView {
    public func randomizeColors() {
        guard let layer = self.layer as? GradientLayer else { return }
        layer.randomize()
    }
    
    func setGradient(with point: GradientPoint, start: UIColor, end: UIColor) {
        guard let layer = self.layer as? GradientLayer else { return }
        layer.setGradient(with: point, start: start, end: end)
    }
}

public class GradientView: UIView, GradientBacked {
    override public class var layerClass: Swift.AnyClass {
        return GradientLayer.self
    }
}

public class GradientImageView: UIImageView, GradientBacked {
   override public class var layerClass: Swift.AnyClass {
        return GradientLayer.self
    }
}

