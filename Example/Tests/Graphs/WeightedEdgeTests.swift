import XCTest
import ImmutableGraph


class WeightedEdgeTests: XCTestCase {
    
    // MARK: - ==(lhs:rhs:)
    func testEquals_WithSameSourceDestinationAndWeight_MustReturnTrue() {
    
        // given
        let source = "🐥"
        let destination = "🐓"
        let weight = 3.4
        
        let e1 = WeightedEdge(
            source: source,
            destination: destination,
            weight: weight)
        let e2 = WeightedEdge(
            source: source,
            destination: destination,
            weight: weight)
    
        // when/then
        XCTAssert(e1 == e2)
        XCTAssertEqual(e1.hashValue, e2.hashValue)
    }
    
    func testEquals_WithSameSourceWeightDifferentDestination_MustReturnFalse() {
        
        // given
        let source = "🐥"
        let weight = 3.4
        
        let e1 = WeightedEdge(
            source: source,
            destination: "🐓",
            weight: weight)
        let e2 = WeightedEdge(
            source: source,
            destination: "🦆",
            weight: weight)
        
        // when/then
        XCTAssertFalse(e1 == e2)
        XCTAssertNotEqual(e1.hashValue, e2.hashValue)
    }
    
    func testEquals_WithSameDestinationDifferentSourceWeight_MustReturnFalse() {
        
        // given
        let destination = "🐓"
        
        let e1 = WeightedEdge(
            source: "🐥",
            destination: destination,
            weight: 3.4)
        let e2 = WeightedEdge(
            source: "🦍",
            destination: destination,
            weight: 1.0)
        
        // when/then
        XCTAssertFalse(e1 == e2)
        XCTAssertNotEqual(e1.hashValue, e2.hashValue)
    }
    
}
