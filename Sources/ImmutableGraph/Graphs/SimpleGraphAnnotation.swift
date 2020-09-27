
public protocol VerticesParentsProtocol where V: Hashable {
    
    associatedtype V
    
    var parentByVertex: [V: V?] { get }
    
    func associate(parent: V, to vertex: V) -> Self
    
}

public protocol VerticesDiscoveredStatusProtocol where V: Hashable {
    
    associatedtype V
    
    var discoveredByVertex: [V: Bool] { get }
    
    func discover(_ vertex: V) -> Self
    
}

public struct SimpleGraphAnnotation<V>:
    Equatable,
    VerticesParentsProtocol,
    VerticesDiscoveredStatusProtocol
    where V: Hashable {
    
    public let parentByVertex: [V : V?]
    public let discoveredByVertex: [V: Bool]
    
    private let vertices: Set<V>
    
    public init<G>(_ graph: G) where G: GraphProtocol, V == G.V {
        
        var parentByVertex = [V: V?]()
        var discoveredByVertex = [V: Bool]()
        graph.vertices.forEach { vertex in
            parentByVertex[vertex] = nil as V?
            discoveredByVertex[vertex] = false
        }
        self.parentByVertex = parentByVertex
        self.discoveredByVertex = discoveredByVertex
        vertices = graph.vertices
    }
    
    public init(parentByVertex: [V: V?], discoveredByVertex: [V: Bool]) {
        
        self.parentByVertex = parentByVertex
        self.discoveredByVertex = discoveredByVertex
        vertices = parentByVertex.map { $0.key }.toSet()
    }
    
    public func associate(parent: V, to vertex: V) -> SimpleGraphAnnotation<V> {
        
        return
            (vertices.contains(vertex) && vertices.contains(parent) ?
                associate(validParent: parent, toValid: vertex) :
                self)
    }
    
    private func associate(
        validParent parent: V,
        toValid vertex: V) -> SimpleGraphAnnotation<V> {
        
        var newParentByVertex = parentByVertex
        newParentByVertex[vertex] = parent
        return SimpleGraphAnnotation(
            parentByVertex: newParentByVertex,
            discoveredByVertex: discoveredByVertex)
    }
    
    public func discover(_ vertex: V) -> SimpleGraphAnnotation<V> {
        
        return (vertices.contains(vertex) ? discover(valid: vertex) : self)
    }
    
    private func discover(valid vertex: V) -> SimpleGraphAnnotation {
        
        var newDiscoveredByVertex = discoveredByVertex
        newDiscoveredByVertex[vertex] = true
        return SimpleGraphAnnotation(
            parentByVertex: parentByVertex,
            discoveredByVertex: newDiscoveredByVertex)
    }
    
    public static func ==(
        lhs: SimpleGraphAnnotation,
        rhs: SimpleGraphAnnotation) -> Bool {
        
        if !(lhs.parentByVertex.count == rhs.parentByVertex.count) {
            return false
        }
        
        let sameParentByVertexContent =
            lhs.parentByVertex.reduce(true) { partialResult, arg in
            let (v, parent) = arg
            return (partialResult && parent == rhs.parentByVertex[v]!)
        }
        
        let sameDiscoveredByVertexContent =
            (lhs.discoveredByVertex == rhs.discoveredByVertex)
        
        return (sameParentByVertexContent && sameDiscoveredByVertexContent)
    }
    
}
