import SceneKit

extension SCNVector3: DimensionalVector {
    public var arr: [Float] {
        get {
            [x, y, z]
        } set {
            (x, y, z) = (newValue[0], newValue[1], newValue[2])
        }
    }
    static let elementsCount: Int = 3
}


extension SCNVector3 {
    // works for capsule and cones have not tested for other shapes
    var rotation: SCNVector3 {
        SCNVector3(
            x: atan2(z, hypot(x, y)),
            y: 0,
            z: atan2(y, x) - .pi/2
        )
    }
}
