import XCTest
import ImmutableGraph


class GraphTests: XCTestCase {
    
    // MARK: - ==(lhs:rhs:)
    func testEquals_WithEmptyGraphAndEmptyGraph_MustReturnTrue() {
    
        // given
        let graph1 = Graph(vertices: Set<Int>(), edges: Set<Edge<Int>>())
        let graph2 = Graph(vertices: Set<Int>(), edges: Set<Edge<Int>>())
    
        // when
        let result = (graph1 == graph2)
    
        // then
        XCTAssert(result)
    }
    
    func testEquals_WithEmptyGraphAndGraphWithOnlyOneVertex_MustReturnFalse() {
        
        // given
        let graph1 = Graph(vertices: Set<Int>(), edges: Set<Edge<Int>>())
        let graph2 =
            Graph(vertices: Set(arrayLiteral: 1), edges: Set<Edge<Int>>())
        
        // when
        let result = (graph1 == graph2)
        
        // then
        XCTAssertFalse(result)
    }
    
    func testEquals_WithEmptyGraphAndGraphWith2VerticesAnd1Edge_MustReturnFalse() {
        
        // given
        let graph1 = Graph(vertices: Set<Int>(), edges: Set<Edge<Int>>())
        let graph2 =
            Graph(vertices: Set(arrayLiteral: 1, 2),
                  edges: Set(arrayLiteral: Edge(source: 1, destination: 2)))
        
        // when
        let result = (graph1 == graph2)
        
        // then
        XCTAssertFalse(result)
    }
    
    func testEquals_WithGraphWithOnlyOneVertexVAndGraphWithOnlyOneVertexV_MustReturnTrue() {
        
        // given
        let v = "🌼"
        let graph1 =
            Graph(vertices: Set(arrayLiteral: v), edges: Set<Edge<String>>())
        let graph2 =
            Graph(vertices: Set(arrayLiteral: v), edges: Set<Edge<String>>())
        
        // when
        let result = (graph1 == graph2)
        
        // then
        XCTAssert(result)
    }
    
    func testEquals_WithGraphWithOnlyOneVertexV1AndGraphWithOnlyOneVertexV2AndV1IsDifferentFromV2_MustReturnFalse() {
        
        // given
        let v1 = "🌼"
        let v2 = "🐛"
        let graph1 =
            Graph(vertices: Set(arrayLiteral: v1), edges: Set<Edge<String>>())
        let graph2 =
            Graph(vertices: Set(arrayLiteral: v2), edges: Set<Edge<String>>())
        
        // when
        let result = (graph1 == graph2)
        
        // then
        XCTAssertFalse(result)
    }
    
    func testEquals_WithV1AndV2VerticesAndV1ToV2GraphAndGraphWithSame2VerticesAndEdge_MustReturnTrue() {
        
        // given
        let v1 = "🌼"
        let v2 = "🐛"
        let graph1 =
            Graph(vertices: Set(arrayLiteral: v1, v2),
                  edges: Set(arrayLiteral: Edge(source: v1, destination: v2)))
        let graph2 =
            Graph(vertices: Set(arrayLiteral: v1, v2),
                  edges: Set(arrayLiteral: Edge(source: v1, destination: v2)))
        
        // when
        let result = (graph1 == graph2)
        
        // then
        XCTAssert(result)
    }
    
    func testEquals_WithV1AndV2VerticesAndV1ToV2GraphAndGraphWithSame2VerticesAndInvertedEdge_MustReturnFalse() {
        
        // given
        let v1 = "🌼"
        let v2 = "🐛"
        let graph1 =
            Graph(vertices: Set(arrayLiteral: v1, v2),
                  edges: Set(arrayLiteral: Edge(source: v1, destination: v2)))
        let graph2 =
            Graph(vertices: Set(arrayLiteral: v1, v2),
                  edges: Set(arrayLiteral: Edge(source: v2, destination: v1)))
        
        // when
        let result = (graph1 == graph2)
        
        // then
        XCTAssertFalse(result)
    }
    
    
    // MARK: - adjacencyList(vertex:)
    func testAdjacencyList_WithEmptyGraphFromFakeVertex_MustReturnEmptyVerticesList() {
    
        // given
        let vertices = Set<String>()
        let edges = Set<Edge<String>>()
        let graph = Graph(vertices: vertices, edges: edges)
        let fakeVertex = "👻"
        
        // when
        let adjacencyList = graph.adjacencyList(fakeVertex)
        
        // then
        XCTAssert(adjacencyList.isEmpty)
    }
    
    func testAdjacencyList_WithOneVertexAndNoEdgesGraphFromOnlyVertex_MustReturnEmptyVerticesList() {
        
        // given
        let vertices = Set(arrayLiteral: "☝️")
        let edges = Set<Edge<String>>()
        let graph = Graph(vertices: vertices, edges: edges)
        let v = "☝️"
        
        // when
        let adjacencyList = graph.adjacencyList(v)
        
        // then
        XCTAssert(adjacencyList.isEmpty)
    }
    
    func testAdjacencyList_WithUAndVVerticesAndU_VEdgeGraphFromU_MustReturnListWithOnlyV() {
        
        // given
        let u = "☝️"
        let v = "✌️"
        let vertices = Set(arrayLiteral: u, v)
        let e = Edge(source: u, destination: v)
        let edges = Set(arrayLiteral: e)
        let graph = Graph(vertices: vertices, edges: edges)
        
        // when
        let adjacencyList = graph.adjacencyList(u)
        
        // then
        XCTAssertEqual(adjacencyList, [v])
    }
    
    func testAdjacencyList_With5VerticesAndOnly3EdgesWithSameSourceVGraphFromV_MustReturn3VerticesSortedList() {
        
        // given
        let v = 0
        let d1 = 1
        let d2 = 2
        let d3 = 3
        let u = 10
        let vertices = Set(arrayLiteral: v, d1, d2, d3, u)
        let e1 = Edge(source: v, destination: d1)
        let e2 = Edge(source: v, destination: d2)
        let e3 = Edge(source: v, destination: d3)
        let edges = Set(arrayLiteral: e1, e2, e3)
        let graph = Graph(vertices: vertices, edges: edges)
        
        // when
        let adjacencyList = graph.adjacencyList(v)
        
        // then
        let expectedResult = [d1, d2, d3].sorted()
        XCTAssertEqual(adjacencyList, expectedResult)
    }
    
    func testAdjacencyList_With5VerticesAnd3EdgesWithSameSourceVPlusOneExtraEdgeToVGraphFromV_MustReturn3VerticesSortedList() {
        
        // given
        let v = 0
        let d1 = 1
        let d2 = 2
        let d3 = 3
        let u = 10
        let vertices = Set(arrayLiteral: v, d1, d2, d3, u)
        let e1 = Edge(source: v, destination: d1)
        let e2 = Edge(source: v, destination: d2)
        let e3 = Edge(source: v, destination: d3)
        let extraEdgeToV = Edge(source: d2, destination: v)
        let edges = Set(arrayLiteral: e1, e2, e3, extraEdgeToV)
        let graph = Graph(vertices: vertices, edges: edges)
        
        // when
        let adjacencyList = graph.adjacencyList(v)
        
        // then
        let expectedResult = [d1, d2, d3].sorted()
        XCTAssertEqual(adjacencyList, expectedResult)
    }
    
}
