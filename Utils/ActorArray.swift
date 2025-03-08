//
//  ActorArray.swift
//  ReduceProjectSize
//
//  Created by Home on 23/02/25.
//

import Foundation

actor ActorArray<Element: Any>: ExpressibleByArrayLiteral {
    init() {
        array = []
    }
    
    init(arrayLiteral elements: Element...) {
        self.array = elements
    }
    
    @inlinable init<S>(_ elements: S) where S : Sequence, Element == S.Element {
        array = Array(elements)
    }
    
    var array: [Element] = []
    
    func append(_ element: Element) {
        array.append(element)
    }
    
    var isEmpty: Bool {
        array.isEmpty
    }
    
    subscript(_ index: Int)-> Element {
        get {
            array[index]
        }
    }
    
    func set(value: Element, at index: Int) {
        array[index] = value
    }
    
    func insert(_ newElement: Element, at i: Int) {
        array.insert(newElement, at: i)
    }
    
    func insert<C>(contentsOf newElements: C, at i: Int) where C : Collection, Element == C.Element {
        array.insert(contentsOf: newElements, at: i)
    }
    
    func removeAll(keepingCapacity keepCapacity: Bool = false) {
        array.removeAll(keepingCapacity: keepCapacity)
    }
    
    func removeAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows {
        try array.removeAll(where: shouldBeRemoved)
    }
    
    @discardableResult
    func remove(at index: Int) -> Element {
        array.remove(at: index)
        
    }
    
    @discardableResult
    func removeLast() -> Element {
        array.removeLast()
    }
    
    func removeLast(_ k: Int) {
        array.removeLast(k)
    }
    
    func removeFirst(_ k: Int) {
        array.removeFirst(k)
    }
    
    func removeFirst() -> Element {
        array.removeFirst()
    }
    
    func removeSubrange(_ bounds: Range<Int>) {
        array.removeSubrange(bounds)
    }
}

//extension ActorArray: Sequence {
//    struct Iterator: IteratorProtocol {
//        private var i: IndexingIterator<[Element]>
//        
//        init(_ array: [Element]) {
////            self.array = array
//            i = array.makeIterator()
//        }
//        
//        mutating func next() -> Element? {
//            i.next()
//        }
//    }
//    
//    func makeIterator() async -> Iterator  {
//        Iterator(array)
//    }
//}
