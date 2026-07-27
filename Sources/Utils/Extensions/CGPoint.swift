import CoreGraphics

extension CGPoint: Dimension2D {
    public var a: CGFloat {
        get { x }
        set { x = newValue }
    }
    
    public var b: CGFloat {
        get { y }
        set { y = newValue }
    }
}

extension CGSize: Dimension2D {
    public var a: CGFloat {
        get { width }
        set { width = newValue }
    }
    
    public var b: CGFloat {
        get { height }
        set { height = newValue }
    }
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
