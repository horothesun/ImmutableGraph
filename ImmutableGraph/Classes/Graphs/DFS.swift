
public func dfs<G, V>(_ graph: G) -> SimpleGraphAnnotation<V>
    where G: GraphProtocol, V == G.V {
    
    return graph.vertices.sorted()
        .reduce(SimpleGraphAnnotation(graph)) { partialAnnotation, v in
            return partialAnnotation.discoveredByVertex[v]! ?
                partialAnnotation :
                dfsAux(graph, source: v, annotation: partialAnnotation)
    }
}

public func dfs<G, V>(_ graph: G, source s: V) -> SimpleGraphAnnotation<V>
    where G: GraphProtocol, V == G.V {
    
    return dfsAux(
        graph,
        source: s,
        annotation: SimpleGraphAnnotation(graph))
}

private func dfsAux<G, V>(
    _ graph: G,
    source s: V,
    annotation: SimpleGraphAnnotation<V>) -> SimpleGraphAnnotation<V>
    where G: GraphProtocol, V == G.V {
        
    return graph
        .adjacencyList(s)
        .reduce(annotation.discover(s)) { partialAnnotation, v in
            
            return partialAnnotation.discoveredByVertex[v]! ?
                partialAnnotation :
                dfsAux(
                    graph,
                    source: v,
                    annotation: partialAnnotation.associate(parent: s, to: v))
    }
}
