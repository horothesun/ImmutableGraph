
public protocol GraphProtocol: Equatable where V == E.V {
    
    associatedtype V: Hashable, Comparable
    associatedtype E: EdgeProtocol
    
    var vertices: Set<V> { get }
    var edges: Set<E> { get }
    
    var adjacencyList: (V) -> [V] { get }
    
}

public func ==<G: GraphProtocol>(lhs: G, rhs: G) -> Bool {
    
    return (lhs.vertices == rhs.vertices && lhs.edges == rhs.edges)
}


public struct Graph<V, E>: GraphProtocol where
    V: Hashable,
    V: Comparable,
    E: EdgeProtocol,
    V == E.V {
    
    public let vertices: Set<V>
    public let edges: Set<E>
    
    public let adjacencyList: (V) -> [V]
    
    public init(vertices: Set<V>, edges: Set<E>) {
        
        self.vertices = vertices
        self.edges = edges
        
        adjacencyList = memoize(Graph.pureAdjacencyList(edges: edges))
    }
    
    private static func pureAdjacencyList(edges: Set<E>) -> (V) -> [V] {
        
        return { vertex in
            
            return edges
                .filter { edge in return (edge.source == vertex) }
                .map { $0.destination }
                .sorted()
        }
    }
    
}
