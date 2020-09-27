import ImmutableGraph

let u = "☝️", v = "✌️"
let vertices = Set(arrayLiteral: u, v)
let e = Edge(source: u, destination: v)
let edges = Set(arrayLiteral: e)
let graph = Graph(vertices: vertices, edges: edges)
let simpleGraphAnnotation = dfs(graph, source: u)
print(simpleGraphAnnotation)
