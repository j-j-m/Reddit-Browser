//
//  Operators.swift
//  RedditComponents
//
//  Created by Jacob Martin on 5/11/18.
//  Copyright © 2018 jjm. All rights reserved.
//

import UIKit

/// Function Forward Application
precedencegroup ApplyForward {
    associativity: left
}

infix operator |>: ApplyForward

public func |> <A, B>(x: A, f: (A) -> B) -> B {
    return f(x)
}

/// Function Forward Composition
precedencegroup ComposeForward {
    associativity: left
    higherThan: ComposeSingleType
}
infix operator >>>: ComposeForward
public func >>> <A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return { g(f($0)) }
}

/// Single Type Function Composition
precedencegroup ComposeSingleType {
    associativity: right
    higherThan: ApplyForward
}

infix operator <>: ComposeSingleType
public func <> <A>(f: @escaping (A) -> A, g: @escaping (A) -> A) -> (A) -> A {
    return f >>> g
}

/// Compose two functions from one type to Void. functions will be applied in order internally.
///
/// - Parameters:
///   - f: first function
///   - g: second function
public func <> <A: AnyObject>(f: @escaping (A) -> Void, g: @escaping (A) -> Void) -> (A) -> Void {
    return { a in
        f(a)
        g(a)
    }
}

/// Compose two functions from one type (inout) to Void. functions will be applied in order internally.
///
/// - Parameters:
///   - f: first function
///   - g: second function
public func <> <A>(f: @escaping (inout A) -> Void, g: @escaping (inout A) -> Void) -> (inout A) -> Void {
    return { a in
        f(&a)
        g(&a)
    }
}

