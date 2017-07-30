
public extension Array where Element: Hashable {
    
    func toSet() -> Set<Element> { return Set(self) }
    
}
