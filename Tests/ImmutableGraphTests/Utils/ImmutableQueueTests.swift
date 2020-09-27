import XCTest
import ImmutableGraph


class ImmutableQueueTests: XCTestCase {
    
    // MARK: - ==(lhs:rhs:)
    func testEquals_WithLhsAndRhsEmptyQueues_MustReturnTrue() {
    
        // given
        typealias T = Int
        let lhs = ImmutableQueue<T>()
        let rhs = ImmutableQueue<T>()
    
        // when/then
        XCTAssert(lhs == rhs)
    }
    
    func testEquals_WithDifferentLhsAndRhsOneElementQueues_MustReturnFalse() {
        
        // given
        let lElements = ["☝️"]
        let lhs = ImmutableQueue(lElements)
        let rElements = ["🙈"]
        let rhs = ImmutableQueue(rElements)
        
        // when/then
        XCTAssertFalse(lhs == rhs)
    }
    
    func testEquals_With2ElementsLhsAnd3ElementsRhsQueuesWithCommonElements_MustReturnFalse() {
        
        // given
        let lElements = ["🙉", "🙊"]
        let lhs = ImmutableQueue(lElements)
        let rElements = ["🙈", "🙉", "🙊"]
        let rhs = ImmutableQueue(rElements)
        
        // when/then
        XCTAssertFalse(lhs == rhs)
    }
    
    func testEquals_With2ElementsLhsAnd3ElementsRhsQueuesWithoutCommonElements_MustReturnFalse() {
        
        // given
        let lElements = ["☝️", "✌️"]
        let lhs = ImmutableQueue(lElements)
        let rElements = ["🙈", "🙉", "🙊"]
        let rhs = ImmutableQueue(rElements)
        
        // when/then
        XCTAssertFalse(lhs == rhs)
    }
    
    
    // MARK: - isEmpty
    func testIsEmpty_WithEmptyQueue_MustReturnTrue() {
        
        // given
        typealias T = Int
        
        // when
        let queue = ImmutableQueue<T>()
        
        // then
        XCTAssert(queue.isEmpty)
    }
    
    func testIsEmpty_WithOneElementQueue_MustReturnFalse() {
        
        // given
        let elements = ["☝️"]
        
        // when
        let queue = ImmutableQueue(elements)
        
        // then
        XCTAssertFalse(queue.isEmpty)
    }
    
    func testIsEmpty_WithTwoElementQueue_MustReturnFalse() {
        
        // given
        let elements = ["☝️", "✌️"]
        
        // when
        let queue = ImmutableQueue(elements)
        
        // then
        XCTAssertFalse(queue.isEmpty)
    }
    
    
    // MARK: - toArray()
    func testToArray_WithEmptyQueue_MustReturnEmptyArray() {
    
        // given
        typealias T = Int
        let queue = ImmutableQueue<T>()
        
        // when
        let result = queue.toArray()
        
        // then
        let expectedResult = [T]()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testToArray_With3ElementsQueue_MustReturnSame3ElementsArray() {
        
        // given
        let elements = ["🙈", "🙉", "🙊"]
        let queue = ImmutableQueue(elements)
        
        // when
        let result = queue.toArray()
        
        // then
        XCTAssertEqual(result, elements)
    }
    
    
    // MARK: - enqueue(_ element:)
    func testEnqueue_WithEmptyQueueAndElement3_MustReturnQueueWithJust3() {
    
        // given
        typealias T = Int
        let queue = ImmutableQueue<T>()
        let newElement = 3
    
        // when
        let result = queue.enqueue(newElement)
    
        // then
        let expectedResult = ImmutableQueue([newElement])
        XCTAssertEqual(result, expectedResult)
    }
    
    func testEnqueue_WithXAndYElementsQueueAndElementZ_MustReturnXYZQueue() {
        
        // given
        let x = 1
        let y = 2
        let queue = ImmutableQueue([x, y])
        let z = 3
        
        // when
        let result = queue.enqueue(z)
        
        // then
        let expectedResult = ImmutableQueue([x, y, z])
        XCTAssertEqual(result, expectedResult)
    }
    
    
    // MARK: - dequeue()
    func testDequeue_WithEmptyQueue_MustReturnNilElementAndEmptyQueue() {
    
        // given
        typealias T = Int
        let queue = ImmutableQueue<T>()
    
        // when
        let (head, newQueue) = queue.dequeue()
    
        // then
        let expectedHead = nil as T?
        XCTAssertEqual(head, expectedHead)
        
        let expectedNewQueue = ImmutableQueue<T>()
        XCTAssertEqual(newQueue, expectedNewQueue)
    }
    
    func testDequeue_WithOneElementQueue_MustReturnSameElementAndEmptyQueue() {
        
        // given
        typealias T = String
        let element = "☝️"
        let queue = ImmutableQueue([element])
        
        // when
        let (head, newQueue) = queue.dequeue()
        
        // then
        XCTAssertEqual(head, element)
        
        let expectedNewQueue = ImmutableQueue<T>()
        XCTAssertEqual(newQueue, expectedNewQueue)
    }
    
    func testDequeue_WithXAndYElementsQueue_MustReturnXElementAndYOnlyQueue() {
        
        // given
        let x = "☝️"
        let y = "✌️"
        let queue = ImmutableQueue([x, y])
        
        // when
        let (head, newQueue) = queue.dequeue()
        
        // then
        XCTAssertEqual(head, x)
        
        let expectedNewQueue = ImmutableQueue([y])
        XCTAssertEqual(newQueue, expectedNewQueue)
    }
    
    func testDequeue_WithXAndYAndZElementsQueue_MustReturnXElementAndYAndZQueue() {
        
        // given
        let x = "🙈"
        let y = "🙉"
        let z = "🙊"
        let queue = ImmutableQueue([x, y, z])
        
        // when
        let (head, newQueue) = queue.dequeue()
        
        // then
        XCTAssertEqual(head, x)
        
        let expectedNewQueue = ImmutableQueue([y, z])
        XCTAssertEqual(newQueue, expectedNewQueue)
    }
    
}
