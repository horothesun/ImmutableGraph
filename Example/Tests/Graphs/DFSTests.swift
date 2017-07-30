import XCTest
import ImmutableGraph


class DFSTests: XCTestCase {
    
    // MARK: - DFS on Graph<V, Edge<V>>
    func testDFS_WithEmptyGraph_MustReturnEmptySimpleGraphAnnotation() {
    
        // given
        typealias V = Int
        let vertices = Set<V>()
        let edges = Set<Edge<V>>()
        let graph = Graph(vertices: vertices, edges: edges)
        
        // when
        let result = dfs(graph)
        
        // then
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: [V: V?](),
            discoveredByVertex: [V: Bool]())
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testDFS_WithAToZGraph_MustReturnCorrectSimpleGraphAnnotation() {
        
        // given
        typealias V = String
        let vA = "A"
        let vZ = "Z"
        let vertices = Set(arrayLiteral: vA, vZ)
        let e1 = Edge(source: vA, destination: vZ)
        let edges = Set(arrayLiteral: e1)
        let graph = Graph(vertices: vertices, edges: edges)
        
        // when
        let result = dfs(graph)
        
        // then
        let expectedParentByVertex = [vA: nil as V?, vZ: vA]
        let expecterDiscoveredByVertex = [vA: true, vZ: true]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testDFS_WithZToAGraph_MustReturnCorrectSimpleGraphAnnotation() {
        
        // given
        typealias V = String
        let vA = "A"
        let vZ = "Z"
        let vertices = Set(arrayLiteral: vZ, vA)
        let e1 = Edge(source: vZ, destination: vA)
        let edges = Set(arrayLiteral: e1)
        let graph = Graph(vertices: vertices, edges: edges)
        
        // when
        let result = dfs(graph)
        
        // then
        let expectedParentByVertex = [vA: nil as V?, vZ: nil as V?]
        let expecterDiscoveredByVertex = [vA: true, vZ: true]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testDFS_With6Vertices4EdgesGraph_MustReturnCorrectSimpleGraphAnnotation() {
        
        // given
        typealias V = String
        let vA = "A", vB = "B", vC = "C",
            vD = "D", vE = "E", vF = "F",
            vG = "G", vH = "H", vI = "I"
        let verticesList = [vA, vB, vC, vD, vE, vF, vG, vH, vI]
        let edges = Set(arrayLiteral:
            Edge(source: vA, destination: vD),
            Edge(source: vD, destination: vF),
            Edge(source: vD, destination: vB),
            Edge(source: vD, destination: vG),
            Edge(source: vB, destination: vA),
            Edge(source: vB, destination: vG),
            Edge(source: vF, destination: vC),
            Edge(source: vC, destination: vD),
            Edge(source: vC, destination: vB),
            Edge(source: vC, destination: vG),
            Edge(source: vI, destination: vE),
            Edge(source: vH, destination: vE),
            Edge(source: vH, destination: vF),
            Edge(source: vH, destination: vD),
            Edge(source: vE, destination: vH)
        )
        let graph = Graph(vertices: verticesList.toSet(), edges: edges)
        
        // when
        let result = dfs(graph)
        
        // then
        let expectedParentByVertex = [
            vA: nil as V?, vB: vD,        vC: vF,
            vD: vA,        vE: nil as V?, vF: vD,
            vG: vB,        vH: vE,        vI: nil as V?
        ]
        let expecterDiscoveredByVertex = [
            vA: true, vB: true, vC: true,
            vD: true, vE: true, vF: true,
            vG: true, vH: true, vI: true
        ]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    
    // MARK: - DFS on Graph<V, WeightedEdge<V>>
    func testDFS_WithEmptyWeightedGraph_MustReturnEmptySimpleGraphAnnotation() {
        
        // given
        typealias V = Int
        let vertices = Set<V>()
        let edges = Set<WeightedEdge<V>>()
        let weightedGraph = Graph(vertices: vertices, edges: edges)
        
        // when
        let result = dfs(weightedGraph)
        
        // then
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: [V: V?](),
            discoveredByVertex: [V: Bool]())
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testDFS_WithAToZWeightedGraph_MustReturnCorrectSimpleGraphAnnotation() {
        
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
        let result = dfs(weightedGraph)
        
        // then
        let expectedParentByVertex = [vA: nil as V?, vZ: vA]
        let expecterDiscoveredByVertex = [vA: true, vZ: true]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testDFS_WithZToAWeightedGraph_MustReturnCorrectSimpleGraphAnnotation() {
        
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
        let result = dfs(weightedGraph)
        
        // then
        let expectedParentByVertex = [vA: nil as V?, vZ: nil as V?]
        let expecterDiscoveredByVertex = [vA: true, vZ: true]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    
    // MARK: - dfs(_ graph:from:)
    func testDFSFromSource_WithEmptyGraphAndSourceV_MustReturnEmptySimpleGraphAnnotation() {
        
        // given
        typealias V = Int
        let vertices = Set<V>()
        let edges = Set<Edge<V>>()
        let graph = Graph(vertices: vertices, edges: edges)
        let s = 3
        
        // when
        let result = dfs(graph, from: s)
        
        // then
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: [V: V?](),
            discoveredByVertex: [V: Bool]())
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testDFSFromSource_WithAToZGraphAndSourceA_MustReturnCorrectSimpleGraphAnnotation() {
        
        // given
        typealias V = String
        let vA = "A"
        let vZ = "Z"
        let vertices = Set(arrayLiteral: vA, vZ)
        let e1 = Edge(source: vA, destination: vZ)
        let edges = Set(arrayLiteral: e1)
        let graph = Graph(vertices: vertices, edges: edges)
        
        // when
        let result = dfs(graph, from: vA)
        
        // then
        let expectedParentByVertex = [vA: nil as V?, vZ: vA]
        let expecterDiscoveredByVertex = [vA: true, vZ: true]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testDFSFromSource_WithZToAGraphAndSourceA_MustReturnCorrectSimpleGraphAnnotation() {
        
        // given
        typealias V = String
        let vA = "A"
        let vZ = "Z"
        let vertices = Set(arrayLiteral: vA, vZ)
        let e1 = Edge(source: vZ, destination: vA)
        let edges = Set(arrayLiteral: e1)
        let graph = Graph(vertices: vertices, edges: edges)
        
        // when
        let result = dfs(graph, from: vA)
        
        // then
        let expectedParentByVertex = [vA: nil as V?, vZ: nil as V?]
        let expecterDiscoveredByVertex = [vA: true, vZ: false]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
    func testDFSFromSource_With6Vertices4EdgesGraphAndSourceA_MustReturnCorrectSimpleGraphAnnotation() {
        
        // given
        typealias V = String
        let vA = "A", vB = "B", vC = "C",
            vD = "D", vE = "E", vF = "F",
            vG = "G", vH = "H", vI = "I"
        let verticesList = [vA, vB, vC, vD, vE, vF, vG, vH, vI]
        let edges = Set(arrayLiteral:
            Edge(source: vA, destination: vD),
            Edge(source: vD, destination: vF),
            Edge(source: vD, destination: vB),
            Edge(source: vD, destination: vG),
            Edge(source: vB, destination: vA),
            Edge(source: vB, destination: vG),
            Edge(source: vF, destination: vC),
            Edge(source: vC, destination: vD),
            Edge(source: vC, destination: vB),
            Edge(source: vC, destination: vG),
            Edge(source: vI, destination: vE),
            Edge(source: vH, destination: vE),
            Edge(source: vH, destination: vF),
            Edge(source: vH, destination: vD),
            Edge(source: vE, destination: vH)
        )
        let graph = Graph(vertices: verticesList.toSet(), edges: edges)
        
        // when
        let result = dfs(graph, from: vA)
        
        // then
        let expectedParentByVertex = [
            vA: nil as V?, vB: vD,        vC: vF,
            vD: vA,        vE: nil as V?, vF: vD,
            vG: vB,        vH: nil as V?, vI: nil as V?
        ]
        let expecterDiscoveredByVertex = [
            vA: true, vB: true,  vC: true,
            vD: true, vE: false, vF: true,
            vG: true, vH: false, vI: false
        ]
        let expectedAnnotation = SimpleGraphAnnotation(
            parentByVertex: expectedParentByVertex,
            discoveredByVertex: expecterDiscoveredByVertex)
        XCTAssertEqual(result, expectedAnnotation)
    }
    
}
