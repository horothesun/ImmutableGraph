import XCTest
import ImmutableGraph


class MemoizeTests: XCTestCase {
    
    // MARK: - Non recursive argument function
    func testMemoize_WithNonRecursiveFunctionFAndInputX_MustReturnFOfX() {
        
        // given
        let f: (Int) -> Int = { $0 * $0 }
        let memoizedSquare = memoize(f)
        let x = 10
        
        // when
        let memoizedFOfX = memoizedSquare(x)
        
        // then
        XCTAssertEqual(f(x), memoizedFOfX)
    }
    
    func testMemoizeCalled3TimesOnSameInput_WithNonRecursiveFunctionFAndInputX_MustCallFOnlyOnce() {
        
        // given
        var fCalls = 0
        let f: (Int) -> Int = { x in fCalls += 1; return x * x }
        let memoizedF = memoize(f)
        let x = 10
        
        // when
        let _ = memoizedF(x)
        let _ = memoizedF(x)
        let _ = memoizedF(x)
        
        // then
        XCTAssertEqual(1, fCalls)
    }
    
    func testMemoizeCalled3Times_WithNonRecursiveFunctionFAndInputX_MustAlwaysReturnTheSameValue() {
        
        // given
        let f: (Int) -> Int = { $0 * $0 }
        let memoizedSquare = memoize(f)
        let x = 10
        
        // when
        let result0 = memoizedSquare(x)
        let result1 = memoizedSquare(x)
        let result2 = memoizedSquare(x)
        
        // then
        XCTAssertEqual(result0, result1)
        XCTAssertEqual(result1, result2)
    }
    
    
    // MARK: - Recursive argument function
    func testMemoize_WithRecursiveFibonacciFunctionAndInputX_MustReturnFibonacciOfX() {
    
        // given
        func fibonacci(_ i: UInt) -> UInt {
            return ( i == 0 || i == 1 ? 1 : fibonacci(i-1) + fibonacci(i-2) )
        }
        
        let memoizedFibonacci = memoize { (fib, i: UInt) in
            return UInt( i == 0 || i == 1 ? 1 : fib(i-1) + fib(i-2) )
        }
        
        let x = UInt(10)
        
        // when
        let result = memoizedFibonacci(x)
        
        // then
        XCTAssertEqual(result, fibonacci(x))
    }
    
    func testMemoize_WithRecursiveFibonacciFunctionAndInputX_MustRecursiveCallXPlus1Times() {
        
        // given
        var memoizedFibonacciCalls = UInt(0)
        
        let memoizedFibonacci: (UInt) -> UInt = memoize { fib, i in
            memoizedFibonacciCalls += 1
            return UInt( i == 0 || i == 1 ? 1 : fib(i-1) + fib(i-2) )
        }
        
        let x = UInt(10)
        let expectedMemoizedFibonacciCalls = UInt(x + 1)
        
        // when
        let _ = memoizedFibonacci(x)
        
        // then
        XCTAssertEqual(
            memoizedFibonacciCalls,
            expectedMemoizedFibonacciCalls)
    }
    
}
