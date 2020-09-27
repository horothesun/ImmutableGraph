import XCTest
import ImmutableGraph


class Array_ToSetTests: XCTestCase {
    
    func testToSet_WithEmptyArray_MustReturnEmptySet() {
    
        // given
        let array = [Int]()
    
        // when
        let set = array.toSet()
    
        // then
        XCTAssert(set.isEmpty)
    }
    
    func testToSet_WithOneElementArray_MustReturnSetWithSameElement() {
        
        // given
        let element = "☝️"
        let array = [element]
        let expectedSet = Set(arrayLiteral: element)
        
        // when
        let set = array.toSet()
        
        // then
        XCTAssertEqual(set, expectedSet)
    }
    
    func testToSet_WithTwoElementsArray_MustReturnSetWithSameTwoElements() {
        
        // given
        let element1 = "☝️"
        let element2 = "✌️"
        let array = [element1, element2]
        let expectedSet = Set(arrayLiteral: element1, element2)
        
        // when
        let set = array.toSet()
        
        // then
        XCTAssertEqual(set, expectedSet)
    }
    
}
