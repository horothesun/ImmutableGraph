
public protocol ImmutableQueueProtocol: Equatable {
    
    associatedtype Element: Equatable
    
    var isEmpty: Bool { get }
    
    func toArray() -> [Element]
    func enqueue(_ element: Element) -> Self
    func dequeue() -> (Element?, Self)
    
}


public struct ImmutableQueue<T>: ImmutableQueueProtocol where T: Equatable {
    
    public typealias Element = T
    
    private let elements: [T]
    
    public init() { elements = [T]() }
    
    public init(_ elements: [T]) { self.elements = elements }
    
    public static func ==(lhs: ImmutableQueue<T>, rhs: ImmutableQueue<T>) -> Bool {
        
        return (lhs.toArray() == rhs.toArray())
    }
    
    public var isEmpty: Bool { get { return elements.isEmpty } }
    
    public func toArray() -> [T] { return elements }
    
    public func enqueue(_ element: T) -> ImmutableQueue<T> {
        
        var newElements = elements
        newElements.append(element)
        return ImmutableQueue(newElements)
    }
    
    public func dequeue() -> (T?, ImmutableQueue<T>) {
        
        let newQueue =
            (isEmpty ? self : ImmutableQueue(Array(elements.suffix(from: 1))))
        return (elements.first, newQueue)
    }
    
}
