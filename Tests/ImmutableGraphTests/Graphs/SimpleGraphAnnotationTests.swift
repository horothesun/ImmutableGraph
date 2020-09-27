import XCTest
import ImmutableGraph


class SimpleGraphAnnotationTests: XCTestCase {
    
    // MARK: - init(_ graph:)
    func testInitFromGraph_WithEmptyGraph_MustReturnEmptySimpleGraphAnnotation() {
    
        // given
        let vertices = Set<Int>()
        let edges = Set<Edge<Int>>()
        let graph = Graph(vertices: vertices, edges: edges)
    
        // when
        let result = SimpleGraphAnnotation(graph)
    
        // then
        XCTAssert(result.parentByVertex.isEmpty)
        XCTAssert(result.discoveredByVertex.isEmpty)
    }
    
    func testInitFromGraph_With2Vertices1EdgeGraph_MustReturnSimpleGraphAnnotationWith2UndiscoveredAndUnparentedVertices() {

        // given
        typealias V = String
        let v1 = "🐥"
        let v2 = "🐓"
        let vertices = Set(arrayLiteral: v1, v2)
        let e1 = Edge(source: v1, destination: v2)
        let edges = Set(arrayLiteral: e1)
        let graph = Graph(vertices: vertices, edges: edges)

        // when
        let result = SimpleGraphAnnotation(graph)

        // then
        let expectedParentByVertex = [v1: nil as V?, v2: nil as V?]
        XCTAssertEqual(
            expectedParentByVertex.count,
            result.parentByVertex.count)
        result.parentByVertex.forEach {
            let (v, parent) = $0
            XCTAssertEqual(parent, expectedParentByVertex[v]!)
        }
        
        let expecterDiscoveredByVertex = [v1: false, v2: false]
        XCTAssertEqual(
            expecterDiscoveredByVertex,
            result.discoveredByVertex)
    }
    
    // MARK: - init(parentByVertex:discoveredByVertex:)
    func testInitWithParentByVertexAndDiscoveredByVertex_WithEmptyParentByVertexAndDiscoveredByVertex_MustReturnEmptySimpleGraphAnnotation() {
    
        // given
        typealias V = String
        let parentByVertex = [V: V?]()
        let discoveredByVertex = [V: Bool]()
        
        // when
        let result = SimpleGraphAnnotation(
            parentByVertex: parentByVertex,
            discoveredByVertex: discoveredByVertex)
    
        // then
        XCTAssert(result.parentByVertex.isEmpty)
        XCTAssert(result.discoveredByVertex.isEmpty)
    }
    
    func testInitWithParentByVertexAndDiscoveredByVertex_With5ParentByVertexAndDiscoveredByVertexEntries_MustReturnSimpleGraphAnnotationWithSameParentByVertexAndDiscoveredByVertex() {
        
        // given
        let s = "s", t = "t", u = "u", v = "v", w = "w"
        typealias V = String
        let parentByVertex = [
            s: nil as V?,
            t: nil as V?,
            u: nil as V?,
            v: s,
            w: v
        ]
        let discoveredByVertex = [
            s: true,
            t: false,
            u: false,
            v: true,
            w: true
        ]
        
        // when
        let result = SimpleGraphAnnotation(
            parentByVertex: parentByVertex,
            discoveredByVertex: discoveredByVertex)
        
        // then
        XCTAssertEqual(
            parentByVertex.count,
            result.parentByVertex.count)
        result.parentByVertex.forEach {
            let (v, parent) = $0
            XCTAssertEqual(parent, parentByVertex[v]!)
        }
        
        XCTAssertEqual(
            discoveredByVertex,
            result.discoveredByVertex)
    }
    
    
    // MARK: - ==(lhs:rhs:)
    func testEquals_WithTwoEmptySimpleGraphAnnotations_MustReturnTrue() {
    
        // given
        typealias V = Int
        let parentByVertex = [V: V?]()
        let discoveredByVertex = [V: Bool]()
        let lhs = SimpleGraphAnnotation(
            parentByVertex: parentByVertex,
            discoveredByVertex: discoveredByVertex)
        let rhs = SimpleGraphAnnotation(
            parentByVertex: parentByVertex,
            discoveredByVertex: discoveredByVertex)
    
        // when/then
        XCTAssert(lhs == rhs)
    }
    
    func testEquals_WithEmptySimpleGraphAnnotationAndOneVertexSimpleGraphAnnotation_MustReturnFalse() {
        
        // given
        typealias V = Int
        let lParentByVertex = [V: V?]()
        let lDiscoveredByVertex = [V: Bool]()
        let lhs = SimpleGraphAnnotation(
            parentByVertex: lParentByVertex,
            discoveredByVertex: lDiscoveredByVertex)
        let rParentByVertex = [3: nil as V?]
        let rDiscoveredByVertex = [3: false]
        let rhs = SimpleGraphAnnotation(
            parentByVertex: rParentByVertex,
            discoveredByVertex: rDiscoveredByVertex)
        
        // when/then
        XCTAssertFalse(lhs == rhs)
    }
    
    func testEquals_WithTwoEqualOneVertexSimpleGraphAnnotations_MustReturnTrue() {
        
        // given
        typealias V = Int
        let parentByVertex = [3: nil as V?]
        let discoveredByVertex = [3: false]
        let lhs = SimpleGraphAnnotation(
            parentByVertex: parentByVertex,
            discoveredByVertex: discoveredByVertex)
        let rhs = SimpleGraphAnnotation(
            parentByVertex: parentByVertex,
            discoveredByVertex: discoveredByVertex)
        
        // when/then
        XCTAssert(lhs == rhs)
    }
    
    func testEquals_WithOneVertexSimpleGraphAnnotationAndTwoVertexSimpleGraphAnnotation_MustReturnFalse() {
        
        // given
        typealias V = Int
        let lParentByVertex = [1: nil as V?]
        let lDiscoveredByVertex = [1: false]
        let lhs = SimpleGraphAnnotation(
            parentByVertex: lParentByVertex,
            discoveredByVertex: lDiscoveredByVertex)
        let rParentByVertex = [1: 2, 2: nil as V?]
        let rDiscoveredByVertex = [1: true, 2: false]
        let rhs = SimpleGraphAnnotation(
            parentByVertex: rParentByVertex,
            discoveredByVertex: rDiscoveredByVertex)
        
        // when/then
        XCTAssertFalse(lhs == rhs)
    }
    
    func testEquals_WithTwoEqualThreeVertexSimpleGraphAnnotations_MustReturnTrue() {
        
        // given
        typealias V = Int
        let parentByVertex = [1: nil as V?, 2: 1, 3: 1]
        let discoveredByVertex = [1: false, 2: false, 3: true]
        let lhs = SimpleGraphAnnotation(
            parentByVertex: parentByVertex,
            discoveredByVertex: discoveredByVertex)
        let rhs = SimpleGraphAnnotation(
            parentByVertex: parentByVertex,
            discoveredByVertex: discoveredByVertex)
        
        // when/then
        XCTAssert(lhs == rhs)
    }
    
    func testEquals_WithTwoThreeVertexSimpleGraphAnnotationsWithDifferentDiscoveredByVertex_MustReturnFalse() {
        
        // given
        typealias V = Int
        let parentByVertex = [1: nil as V?, 2: 1, 3: 1]
        let lDiscoveredByVertex = [1: false, 2: false, 3: true]
        let lhs = SimpleGraphAnnotation(
            parentByVertex: parentByVertex,
            discoveredByVertex: lDiscoveredByVertex)
        let rDiscoveredByVertex = [1: true, 2: false, 3: true]
        let rhs = SimpleGraphAnnotation(
            parentByVertex: parentByVertex,
            discoveredByVertex: rDiscoveredByVertex)
        
        // when/then
        XCTAssertFalse(lhs == rhs)
    }
    
    func testEquals_WithTwoThreeVertexSimpleGraphAnnotationsWithDifferentParentByVertex_MustReturnFalse() {
        
        // given
        typealias V = Int
        let lParentByVertex = [1: nil as V?, 2: 1, 3: 1]
        let discoveredByVertex = [1: false, 2: false, 3: true]
        let lhs = SimpleGraphAnnotation(
            parentByVertex: lParentByVertex,
            discoveredByVertex: discoveredByVertex)
        let rParentByVertex = [1: nil as V?, 2: 1, 3: nil as V?]
        let rhs = SimpleGraphAnnotation(
            parentByVertex: rParentByVertex,
            discoveredByVertex: discoveredByVertex)
        
        // when/then
        XCTAssertFalse(lhs == rhs)
    }
    
    
    // MARK: - associate(parent:to vertex:)
    func testAssociateParentToVertex_WithEmptySimpleGraphAnnotationInitFromGraph_MustReturnEmptyDFSOuptut() {
    
        // given
        typealias V = String
        let vertices = Set<V>()
        let edges = Set<Edge<V>>()
        let graph = Graph(vertices: vertices, edges: edges)
        let simpleGraphAnnotation = SimpleGraphAnnotation(graph)
        let v = "👶🏻"
        let parent = "👨🏻"
    
        // when
        let result = simpleGraphAnnotation.associate(parent: parent, to: v)
    
        // then
        XCTAssert(result.parentByVertex.isEmpty)
        XCTAssert(result.discoveredByVertex.isEmpty)
    }
    
    func testAssociateParentToVertex_WithEmptySimpleGraphAnnotationInitFromParentByVertexAndDiscoveredByVertex_MustReturnEmptyDFSOuptut() {
        
        // given
        typealias V = String
        let parentByVertex = [V: V?]()
        let discoveredByVertex = [V: Bool]()
        let simpleGraphAnnotation = SimpleGraphAnnotation(
            parentByVertex: parentByVertex,
            discoveredByVertex: discoveredByVertex)
        let v = "👶🏻"
        let parent = "👨🏻"
        
        // when
        let result = simpleGraphAnnotation.associate(parent: parent, to: v)
        
        // then
        XCTAssert(result.parentByVertex.isEmpty)
        XCTAssert(result.discoveredByVertex.isEmpty)
    }
    
    func testAssociateParentToVertex_WithSimpleGraphAnnotationInitFromV1ToV2GraphAndV1AsParentForV2_MustReturnDFSOuptutWithCorrectParentByVertexAndAllVerticesUndiscovered() {
        
        // given
        typealias V = String
        let v1 = "👨🏻"
        let v2 = "👶🏻"
        let vertices = Set(arrayLiteral: v1, v2)
        let e1 = Edge(source: v1, destination: v2)
        let edges = Set(arrayLiteral: e1)
        let graph = Graph(vertices: vertices, edges: edges)
        let simpleGraphAnnotation = SimpleGraphAnnotation(graph)
        
        // when
        let result = simpleGraphAnnotation.associate(parent: v1, to: v2)
        
        // then
        let expectedParentByVertex = [v1: nil as V?, v2: v1]
        XCTAssertEqual(
            expectedParentByVertex.count,
            result.parentByVertex.count)
        result.parentByVertex.forEach {
            let (v, parent) = $0
            XCTAssertEqual(parent, expectedParentByVertex[v]!)
        }
        
        let expecterDiscoveredByVertex = [v1: false, v2: false]
        XCTAssertEqual(
            expecterDiscoveredByVertex,
            result.discoveredByVertex)
    }
    
    func testAssociateParentToVertex_WithSimpleGraphAnnotationInitFromV1AndV2UnparentedAndDiscovered_MustReturnDFSOuptutWithCorrectParentByVertexAndAllVerticesDiscovered() {
        
        // given
        typealias V = String
        let v1 = "👨🏻"
        let v2 = "👶🏻"
        let parentByVertex = [v1: nil as V?, v2: nil as V?]
        let discoveredByVertex = [v1: true, v2: true]
        let simpleGraphAnnotation = SimpleGraphAnnotation(
            parentByVertex: parentByVertex,
            discoveredByVertex: discoveredByVertex)
        
        // when
        let result = simpleGraphAnnotation.associate(parent: v1, to: v2)
        
        // then
        let expectedParentByVertex = [v1: nil as V?, v2: v1]
        XCTAssertEqual(
            expectedParentByVertex.count,
            result.parentByVertex.count)
        result.parentByVertex.forEach {
            let (v, parent) = $0
            XCTAssertEqual(parent, expectedParentByVertex[v]!)
        }
        
        XCTAssertEqual(
            discoveredByVertex,
            result.discoveredByVertex)
    }
    
    // MARK: - discover(_ vertex:)
    func testDiscoverVertex_WithEmptySimpleGraphAnnotationInitFromGraph_MustReturnEmptyDFSOuptut() {
        
        // given
        typealias V = String
        let vertices = Set<V>()
        let edges = Set<Edge<V>>()
        let graph = Graph(vertices: vertices, edges: edges)
        let simpleGraphAnnotation = SimpleGraphAnnotation(graph)
        let v = "☝️"
        
        // when
        let result = simpleGraphAnnotation.discover(v)
        
        // then
        XCTAssert(result.parentByVertex.isEmpty)
        XCTAssert(result.discoveredByVertex.isEmpty)
    }
    
    func testDiscoverVertex_WithEmptySimpleGraphAnnotationInitFromParentByVertexAndDiscoveredByVertex_MustReturnEmptyDFSOuptut() {
        
        // given
        typealias V = String
        let parentByVertex = [V: V?]()
        let discoveredByVertex = [V: Bool]()
        let simpleGraphAnnotation = SimpleGraphAnnotation(
            parentByVertex: parentByVertex,
            discoveredByVertex: discoveredByVertex)
        let v = "✌️"
        
        // when
        let result = simpleGraphAnnotation.discover(v)
        
        // then
        XCTAssert(result.parentByVertex.isEmpty)
        XCTAssert(result.discoveredByVertex.isEmpty)
    }
    
    func testDiscoverVertex_WithSimpleGraphAnnotationInitFromV1ToV2GraphAndArgumentV1_MustReturnDFSOuptutWithAllVerticesUnparentedAndOnlyV1Discovered() {
        
        // given
        typealias V = String
        let v1 = "🐛"
        let v2 = "🦋"
        let vertices = Set(arrayLiteral: v1, v2)
        let e1 = Edge(source: v1, destination: v2)
        let edges = Set(arrayLiteral: e1)
        let graph = Graph(vertices: vertices, edges: edges)
        let simpleGraphAnnotation = SimpleGraphAnnotation(graph)
        
        // when
        let result = simpleGraphAnnotation.discover(v1)
        
        // then
        let expectedParentByVertex = [v1: nil as V?, v2: nil as V?]
        XCTAssertEqual(
            expectedParentByVertex.count,
            result.parentByVertex.count)
        result.parentByVertex.forEach {
            let (v, parent) = $0
            XCTAssertEqual(parent, expectedParentByVertex[v]!)
        }
        
        let expecterDiscoveredByVertex = [v1: true, v2: false]
        XCTAssertEqual(
            expecterDiscoveredByVertex,
            result.discoveredByVertex)
    }
    
    func testDiscoverVertex_WithSimpleGraphAnnotationInitFromV1AndV2UnparentedAndOnlyV1DiscoveredAndArgumentV2_MustReturnDFSOuptutWithAllVerticesUnparentedDiscovered() {
        
        // given
        typealias V = String
        let v1 = "🐛"
        let v2 = "🦋"
        let parentByVertex = [v1: nil as V?, v2: nil as V?]
        let discoveredByVertex = [v1: true, v2: false]
        let simpleGraphAnnotation = SimpleGraphAnnotation(
            parentByVertex: parentByVertex,
            discoveredByVertex: discoveredByVertex)
        
        // when
        let result = simpleGraphAnnotation.discover(v2)
        
        // then
        let expectedParentByVertex = [v1: nil as V?, v2: nil as V?]
        XCTAssertEqual(
            expectedParentByVertex.count,
            result.parentByVertex.count)
        result.parentByVertex.forEach {
            let (v, parent) = $0
            XCTAssertEqual(parent, expectedParentByVertex[v]!)
        }
        
        let expecterDiscoveredByVertex = [v1: true, v2: true]
        XCTAssertEqual(
            expecterDiscoveredByVertex,
            result.discoveredByVertex)
    }
    
}
