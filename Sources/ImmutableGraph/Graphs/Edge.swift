
public protocol EdgeProtocol: Hashable {
    
    associatedtype V
    
    var source: V { get }
    var destination: V { get }
    
}

public protocol Weightable { var weight: Double { get } }

public protocol WeightedEdgeProtocol: EdgeProtocol, Weightable { }


public struct Edge<V>: EdgeProtocol, Hashable
    where V: Equatable {

    public let source: V
    public let destination: V
    
    public init(source: V, destination: V) {
        
        self.source = source
        self.destination = destination
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine("\(source)->\(destination)")
    }

    public static func ==(lhs: Edge, rhs: Edge) -> Bool {

        return
            (lhs.source == rhs.source &&
            lhs.destination == rhs.destination)
    }

}


public struct WeightedEdge<V>: WeightedEdgeProtocol, Hashable
    where V: Equatable {

    public let source: V
    public let destination: V

    public let weight: Double
    
    public init(source: V, destination: V, weight: Double) {
        
        self.source = source
        self.destination = destination
        self.weight = weight
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine("\(source)-(\(weight))->\(destination)")
    }

    public static func ==(lhs: WeightedEdge, rhs: WeightedEdge) -> Bool {

        return
            (lhs.source == rhs.source &&
            lhs.destination == rhs.destination &&
            lhs.weight == rhs.weight)
    }

}

