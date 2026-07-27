import CoreGraphics

extension CGPoint: DimensionalVector {
    public var arr: [CGFloat] {
        get {
            [x, y]
        } set {
            (x, y) = (newValue[0], newValue[1])
        }
    }
    static let elementsCount: Int = 2
}

extension CGSize: DimensionalVector {
    public var arr: [CGFloat] {
        get {
            [width, height]
        } set {
            (width, height) = (newValue[0], newValue[1])
        }
    }
    static let elementsCount: Int = 2
}

extension CGPoint {
    // MARK: - Horizontal
    mutating func horizontallyClamp<R: RangeProtocol>(inside range: R) where R.Bound == CGFloat {
        self.x.clamp(inside: range)
    }
    
    func horizontallyClamped<R: RangeProtocol>(inside range: R) -> CGPoint where R.Bound == CGFloat {
        var copy = self
        copy.horizontallyClamp(inside: range)
        return copy
    }

    // MARK: - Vertical
    mutating func verticallyClamp<R: RangeProtocol>(inside range: R) where R.Bound == CGFloat {
        self.y.clamp(inside: range)
    }
    
    func verticallyClamped<R: RangeProtocol>(inside range: R) -> CGPoint where R.Bound == CGFloat {
        var copy = self
        copy.verticallyClamp(inside: range)
        return copy
    }
    
    // MARK: - Rect
    mutating func clamp(inside rect: CGRect) {
        horizontallyClamp(inside: rect.minX...rect.maxX)
        verticallyClamp(inside: rect.minY...rect.maxY)
    }
    
    func clamped(inside rect: CGRect) -> CGPoint {
        var copy = self
        copy.clamp(inside: rect)
        return copy
    }
}
