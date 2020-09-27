
// Reference: https://medium.com/@mvxlr/swift-memoize-walk-through-c5224a558194

// Non recursive
public func memoize<T: Hashable, U>(_ f: @escaping (T) -> U) -> (T) -> U {
    
    var cache = [T: U]()
    
    return { t in
        if let u = cache[t] { return u }
        let newU = f(t)
        cache[t] = newU
        return newU
    }
}

// Recursion supporting version
//
// E.g.:
// let factorial = memoize { factorial, x in x == 0 ? 1 : x * factorial(x-1) }
//
public func memoize<T: Hashable, U>(_ f: @escaping ((T) -> U, T) -> U) -> (T) -> U {
    
    var cache = [T: U]()
    
    func wrap(t: T) -> U {
        if let u = cache[t] { return u }
        let newU = f(wrap, t)
        cache[t] = newU
        return newU
    }
    
    return wrap
}
