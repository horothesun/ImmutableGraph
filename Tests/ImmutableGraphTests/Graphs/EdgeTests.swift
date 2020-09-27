import XCTest
import ImmutableGraph


class EdgeTests: XCTestCase {
    
    // MARK: - ==(lhs:rhs:)
    func testEquals_WithSameSourceDestination_MustReturnTrue() {
        
        // given
        let source = "🐥"
        let destination = "🐓"
        
        let e1 = Edge(source: source, destination: destination)
        let e2 = Edge(source: source, destination: destination)
        
        // when/then
        XCTAssert(e1 == e2)
        XCTAssertEqual(e1.hashValue, e2.hashValue)
    }
    
    func testEquals_WithSameSourceAndDifferentDestination_MustReturnFalse() {
        
        // given
        let source = "🐥"
        
        let e1 = Edge(source: source, destination: "🐓")
        let e2 = Edge(source: source, destination: "🦆")
        
        // when/then
        XCTAssertFalse(e1 == e2)
        XCTAssertNotEqual(e1.hashValue, e2.hashValue)
    }
    
    func testEquals_WithSameDestinationAndDifferentSource_MustReturnFalse() {
        
        // given
        let destination = "🐓"
        
        let e1 = Edge(source: "🐥", destination: destination)
        let e2 = Edge(source: "🦍", destination: destination)
        
        // when/then
        XCTAssertFalse(e1 == e2)
        XCTAssertNotEqual(e1.hashValue, e2.hashValue)
    }
    
}
