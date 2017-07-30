import XCTest
import ImmutableGraph


class BFSTests: XCTestCase {
    
    // MARK: - BFS on Graph<V, Edge<V>>
    func testBFS_WithEmptyGraphAndSourceV_MustReturnEmptySimpleGraphAnnotation() {
        
        // given
        typealias V = Int
        let vertices = Set<V>()
        let edges = Set<Edge<V>>()
        let graph = Graph(vertices: vertices, edges: edges)
        let v = 5
        
        // when
        let result = bfs(graph, source: v)
        
        // then
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: [V: V?](),
            discoveredByVertex: [V: Bool]())
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testBFS_WithAToZGraphAndSourceA_MustReturnCorrectSimpleGraphAnnotation() {
        
        // given
        typealias V = String
        let vA = "A"
        let vZ = "Z"
        let vertices = Set(arrayLiteral: vA, vZ)
        let e1 = Edge(source: vA, destination: vZ)
        let edges = Set(arrayLiteral: e1)
        let graph = Graph(vertices: vertices, edges: edges)
        
        // when
        let result = bfs(graph, source: vA)
        
        // then
        let expectedParentByVertex = [vA: nil as V?, vZ: vA]
        let expecterDiscoveredByVertex = [vA: true, vZ: true]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testBFS_WithAToZGraphAndSourceZ_MustReturnCorrectSimpleGraphAnnotation() {
        
        // given
        typealias V = String
        let vA = "A"
        let vZ = "Z"
        let vertices = Set(arrayLiteral: vA, vZ)
        let e1 = Edge(source: vA, destination: vZ)
        let edges = Set(arrayLiteral: e1)
        let graph = Graph(vertices: vertices, edges: edges)
        
        // when
        let result = bfs(graph, source: vZ)
        
        // then
        let expectedParentByVertex = [vA: nil as V?, vZ: nil as V?]
        let expecterDiscoveredByVertex = [vA: false, vZ: true]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testBFS_WithZToAGraphAndSourceA_MustReturnCorrectSimpleGraphAnnotation() {
        
        // given
        typealias V = String
        let vA = "A"
        let vZ = "Z"
        let vertices = Set(arrayLiteral: vA, vZ)
        let e1 = Edge(source: vZ, destination: vA)
        let edges = Set(arrayLiteral: e1)
        let graph = Graph(vertices: vertices, edges: edges)
        
        // when
        let result = bfs(graph, source: vA)
        
        // then
        let expectedParentByVertex = [vA: nil as V?, vZ: nil as V?]
        let expecterDiscoveredByVertex = [vA: true, vZ: false]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testBFS_WithZToAGraphAndSourceZ_MustReturnCorrectSimpleGraphAnnotation() {
        
        // given
        typealias V = String
        let vA = "A"
        let vZ = "Z"
        let vertices = Set(arrayLiteral: vA, vZ)
        let e1 = Edge(source: vZ, destination: vA)
        let edges = Set(arrayLiteral: e1)
        let graph = Graph(vertices: vertices, edges: edges)
        
        // when
        let result = bfs(graph, source: vZ)
        
        // then
        let expectedParentByVertex = [vA: vZ, vZ: nil as V?]
        let expecterDiscoveredByVertex = [vA: true, vZ: true]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testBFS_With16Vertices34EdgesGraphAndSourceS_MustReturnCorrectSimpleGraphAnnotation() {

        // given
        typealias V = String
        let s = "S",
            a = "A", b = "B", c = "C",
            d = "D", e = "E", f = "F",
            g = "G", h = "H", i = "I",
            j = "J", k = "K", l = "L",
            m = "M", n = "N", o = "O"
        let verticesList = [s, a, b, c, d, e, f, g, h, i, j, k, l, m, n, o]
        let edges = Set(arrayLiteral:
            Edge(source: k, destination: o),
            Edge(source: k, destination: s),
            Edge(source: k, destination: b),
            Edge(source: k, destination: c),
            Edge(source: s, destination: b),
            Edge(source: s, destination: f),
            Edge(source: s, destination: h),
            Edge(source: s, destination: m),
            Edge(source: s, destination: n),
            Edge(source: b, destination: a),
            Edge(source: b, destination: g),
            Edge(source: f, destination: a),
            Edge(source: f, destination: c),
            Edge(source: f, destination: e),
            Edge(source: f, destination: i),
            Edge(source: f, destination: s),
            Edge(source: h, destination: a),
            Edge(source: h, destination: e),
            Edge(source: h, destination: d),
            Edge(source: m, destination: h),
            Edge(source: m, destination: l),
            Edge(source: a, destination: g),
            Edge(source: g, destination: e),
            Edge(source: e, destination: c),
            Edge(source: e, destination: f),
            Edge(source: e, destination: i),
            Edge(source: i, destination: d),
            Edge(source: i, destination: j),
            Edge(source: d, destination: s),
            Edge(source: l, destination: s),
            Edge(source: l, destination: h),
            Edge(source: l, destination: m),
            Edge(source: j, destination: s),
            Edge(source: j, destination: a)
        )
        let graph = Graph(vertices: verticesList.toSet(), edges: edges)

        // when
        let result = bfs(graph, source: s)

        // then
        let expectedParentByVertex = [
            s: nil as V?,
            a: b,         b: s,         c: f,
            d: h,         e: f,         f: s,
            g: b,         h: s,         i: f,
            j: i,         k: nil as V?, l: m,
            m: s,         n: s,         o: nil as V?
        ]
        let expecterDiscoveredByVertex = [
            s: true,
            a: true, b: true,  c: true,
            d: true, e: true,  f: true,
            g: true, h: true,  i: true,
            j: true, k: false, l: true,
            m: true, n: true,  o: false
        ]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    
    // MARK: - BFS on Graph<V, WeightedEdge<V>>
    func testBFS_WithEmptyWeightedGraphAndSourceV_MustReturnEmptySimpleGraphAnnotation() {
        
        // given
        typealias V = Int
        let vertices = Set<V>()
        let weightedEdges = Set<WeightedEdge<V>>()
        let weightedGraph = Graph(vertices: vertices, edges: weightedEdges)
        let v = 5
        
        // when
        let result = bfs(weightedGraph, source: v)
        
        // then
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: [V: V?](),
            discoveredByVertex: [V: Bool]())
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testBFS_WithAToZWeightedGraphAndSourceA_MustReturnCorrectSimpleGraphAnnotation() {
        
        // given
        typealias V = String
        let vA = "A"
        let vZ = "Z"
        let vertices = Set(arrayLiteral: vA, vZ)
        let weight = 3.0
        let e1 = WeightedEdge(source: vA, destination: vZ, weight: weight)
        let edges = Set(arrayLiteral: e1)
        let weightedGraph = Graph(vertices: vertices, edges: edges)
        
        // when
        let result = bfs(weightedGraph, source: vA)
        
        // then
        let expectedParentByVertex = [vA: nil as V?, vZ: vA]
        let expecterDiscoveredByVertex = [vA: true, vZ: true]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testBFS_WithAToZWeightedGraphAndSourceZ_MustReturnCorrectSimpleGraphAnnotation() {
        
        // given
        typealias V = String
        let vA = "A"
        let vZ = "Z"
        let vertices = Set(arrayLiteral: vA, vZ)
        let weight = 3.0
        let e1 = WeightedEdge(source: vA, destination: vZ, weight: weight)
        let edges = Set(arrayLiteral: e1)
        let weightedGraph = Graph(vertices: vertices, edges: edges)
        
        // when
        let result = bfs(weightedGraph, source: vZ)
        
        // then
        let expectedParentByVertex = [vA: nil as V?, vZ: nil as V?]
        let expecterDiscoveredByVertex = [vA: false, vZ: true]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testBFS_WithZToAWeightedGraphWithSourceZ_MustReturnCorrectSimpleGraphAnnotation() {
        
        // given
        typealias V = String
        let vA = "A"
        let vZ = "Z"
        let vertices = Set(arrayLiteral: vA, vZ)
        let weight = 3.0
        let e1 = WeightedEdge(source: vZ, destination: vA, weight: weight)
        let edges = Set(arrayLiteral: e1)
        let weightedGraph = Graph(vertices: vertices, edges: edges)
        
        // when
        let result = bfs(weightedGraph, source: vZ)
        
        // then
        let expectedParentByVertex = [vA: vZ, vZ: nil as V?]
        let expecterDiscoveredByVertex = [vA: true, vZ: true]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testBFS_WithZToAWeightedGraphWithSourceA_MustReturnCorrectSimpleGraphAnnotation() {
        
        // given
        typealias V = String
        let vA = "A"
        let vZ = "Z"
        let vertices = Set(arrayLiteral: vA, vZ)
        let weight = 3.0
        let e1 = WeightedEdge(source: vZ, destination: vA, weight: weight)
        let edges = Set(arrayLiteral: e1)
        let weightedGraph = Graph(vertices: vertices, edges: edges)
        
        // when
        let result = bfs(weightedGraph, source: vA)
        
        // then
        let expectedParentByVertex = [vA: nil as V?, vZ: nil as V?]
        let expecterDiscoveredByVertex = [vA: true, vZ: false]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
}
