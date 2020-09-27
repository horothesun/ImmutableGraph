import XCTest
import ImmutableGraph


class FindPathTests: XCTestCase {
    
    func testFindPath_WithEmptyParentByVertexAndSourceSAndDestinationD_MustReturnEmptyPath() {
    
        // given
        typealias V = String
        let s = "S"
        let d = "D"
        let parentByVertex = [V: V?]()
        
        // when
        let result = findPath(
            parentByVertex: parentByVertex,
            source: s,
            destination: d)
    
        // then
        let expectedResult = [V]()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testFindPath_WithOneUnparentedVertexSAndSourceSAndDestinationD_MustReturnEmptyPath() {
        
        // given
        typealias V = String
        let s = "S"
        let d = "D"
        let parentByVertex = [s: nil as V?]
        
        // when
        let result =
            findPath(parentByVertex: parentByVertex, source: s, destination: d)
        
        // then
        let expectedResult = [V]()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testFindPath_WithOneUnparentedVertexDAndSourceSAndDestinationD_MustReturnEmptyPath() {
        
        // given
        typealias V = String
        let s = "S"
        let d = "D"
        let parentByVertex = [d: nil as V?]
        
        // when
        let result =
            findPath(parentByVertex: parentByVertex, source: s, destination: d)
        
        // then
        let expectedResult = [V]()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testFindPath_WithUnparentedSAndSParentOfDAndSourceSAndDestinationD_MustReturnSToDPath() {
        
        // given
        typealias V = String
        let s = "S"
        let d = "D"
        let parentByVertex = [s: nil as V?, d: s]
        
        // when
        let result =
            findPath(parentByVertex: parentByVertex, source: s, destination: d)
        
        // then
        let expectedResult = [s, d]
        XCTAssertEqual(result, expectedResult)
    }
    
    func testFindPath_WithV1AndV2AndV3VerticesAndSourceV1AndUnreachableDestinationV3_MustReturnEmptyPath() {
        
        // given
        typealias V = Int
        let v1 = 1
        let v2 = 2
        let v3 = 3
        let parentByVertex = [v1: v3, v2: v1, v3: nil as V?]
        
        // when
        let result =
            findPath(parentByVertex: parentByVertex, source: v1, destination: v3)
        
        // then
        let expectedResult = [V]()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testFindPath_With16VerticesGraphAndSourceSAndReachableDestinationJ_MustReturnSToFToIToJPath() {
        
        // given
        typealias V = String
        let s = "S",
            a = "A", b = "B", c = "C",
            d = "D", e = "E", f = "F",
            g = "G", h = "H", i = "I",
            j = "J", k = "K", l = "L",
            m = "M", n = "N", o = "O"
        let parentByVertex = [
            s: nil as V?,
            a: b,         b: s,         c: f,
            d: h,         e: f,         f: s,
            g: b,         h: s,         i: f,
            j: i,         k: nil as V?, l: m,
            m: s,         n: s,         o: nil as V?
        ]
        
        // when
        let result =
            findPath(parentByVertex: parentByVertex, source: s, destination: j)
        
        // then
        let expectedResult = [s, f, i, j]
        XCTAssertEqual(result, expectedResult)
    }
    
    func testFindPath_With16VerticesGraphAndSourceFAndReachableDestinationJ_MustReturnFToIToJPath() {
        
        // given
        typealias V = String
        let s = "S",
            a = "A", b = "B", c = "C",
            d = "D", e = "E", f = "F",
            g = "G", h = "H", i = "I",
            j = "J", k = "K", l = "L",
            m = "M", n = "N", o = "O"
        let parentByVertex = [
            s: nil as V?,
            a: b,         b: s,         c: f,
            d: h,         e: f,         f: s,
            g: b,         h: s,         i: f,
            j: i,         k: nil as V?, l: m,
            m: s,         n: s,         o: nil as V?
        ]
        
        // when
        let result =
            findPath(parentByVertex: parentByVertex, source: f, destination: j)
        
        // then
        let expectedResult = [f, i, j]
        XCTAssertEqual(result, expectedResult)
    }
    
    func testFindPath_With16VerticesGraphAndSourceOAndUnreachableDestinationS_MustReturnEmptyPath() {
        
        // given
        typealias V = String
        let s = "S",
            a = "A", b = "B", c = "C",
            d = "D", e = "E", f = "F",
            g = "G", h = "H", i = "I",
            j = "J", k = "K", l = "L",
            m = "M", n = "N", o = "O"
        let parentByVertex = [
            s: nil as V?,
            a: b,         b: s,         c: f,
            d: h,         e: f,         f: s,
            g: b,         h: s,         i: f,
            j: i,         k: nil as V?, l: m,
            m: s,         n: s,         o: nil as V?
        ]
        
        // when
        let result =
            findPath(parentByVertex: parentByVertex, source: o, destination: s)
        
        // then
        let expectedResult = [V]()
        XCTAssertEqual(result, expectedResult)
    }
    
    func testFindPath_With16VerticesGraphAndSourceKAndUnreachableDestinationS_MustReturnEmptyPath() {
        
        // given
        typealias V = String
        let s = "S",
            a = "A", b = "B", c = "C",
            d = "D", e = "E", f = "F",
            g = "G", h = "H", i = "I",
            j = "J", k = "K", l = "L",
            m = "M", n = "N", o = "O"
        let parentByVertex = [
            s: nil as V?,
            a: b,         b: s,         c: f,
            d: h,         e: f,         f: s,
            g: b,         h: s,         i: f,
            j: i,         k: nil as V?, l: m,
            m: s,         n: s,         o: nil as V?
        ]
        
        // when
        let result =
            findPath(parentByVertex: parentByVertex, source: k, destination: s)
        
        // then
        let expectedResult = [V]()
        XCTAssertEqual(result, expectedResult)
    }
    
}
