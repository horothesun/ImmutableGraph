
public func bfs<G, V>(_ graph: G, source s: V) -> SimpleGraphAnnotation<V>
    where G: GraphProtocol, V == G.V {
        
        let queue = ImmutableQueue([s])
        let annotation = SimpleGraphAnnotation(graph).discover(s)
        return bfsAux(graph, queue: queue, annotation: annotation)
}

private func bfsAux<G, Q, V>(
    _ graph: G,
    queue: Q,
    annotation: SimpleGraphAnnotation<V>) -> SimpleGraphAnnotation<V>
where G: GraphProtocol,
      Q: ImmutableQueueProtocol,
      V == G.V,
      V == Q.Element {
    
    var result = annotation
    
    if !queue.isEmpty {
        let (u, queueTail) = queue.dequeue()
        let (newQueue, newAnnotation) = graph
            .adjacencyList(u!)
            .reduce( (queueTail, annotation) ) { partialResult, v in
                
                let (partialQueue, partialAnnotation) = partialResult
                let isVDiscovered = partialAnnotation.discoveredByVertex[v]!
                let newQueue = isVDiscovered ?
                    partialQueue :
                    partialQueue.enqueue(v)
                let newAnnotation = isVDiscovered ?
                    partialAnnotation :
                    partialAnnotation.discover(v).associate(parent: u!, to: v)
                return (newQueue, newAnnotation)
        }
        result = bfsAux(graph, queue: newQueue, annotation: newAnnotation)
    }
    
    return result
}
