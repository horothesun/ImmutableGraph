
public func findPath<V>(parentByVertex: [V: V?], source: V, destination: V) -> [V] {
    
    var result = [V]()
    
    let isSourceDefined = parentByVertex.keys.contains(source)
    let isDestinationDefined = parentByVertex.keys.contains(destination)
    if !isSourceDefined || !isDestinationDefined {
        return result
    }
    
    if source == destination {
        result = [source]
    } else {
        if let π_destination = parentByVertex[destination],
            π_destination != nil {
            
            result = ImmutableQueue(
                findPath(parentByVertex: parentByVertex,
                         source: source,
                         destination: π_destination!)
                ).enqueue(destination)
                .toArray()
        }
    }
    return result
}
