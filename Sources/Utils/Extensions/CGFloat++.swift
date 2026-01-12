//
//  Public+CGFloat.swift
//  AB2CommonIOS
//
//  Created by iOS Developer on 01/04/25.
//

import UIKit

public extension CGFloat {
    static func dynamic(_ base: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        switch screenWidth {
        case ...375: return base * 0.8
        case 376...440: return base
        default: return base * 1.2
        }
    }
    
    static func accessibleSpacing(_ base: CGFloat, isAccessibilityEnabled: Bool) -> CGFloat {
        return isAccessibilityEnabled ? base * 1.5 : base
    }
}


extension CGFloat {
    // MARK: - Properties
    public static let zero: CGFloat = 0
    public static let ultraSmall: CGFloat = .dynamic(2)
    public static let extraSmall: CGFloat = .dynamic(4)
    public static let small: CGFloat = .dynamic(8)
    public static let medium: CGFloat = .dynamic(16)
    public static let large: CGFloat = .dynamic(32)
    public static let extraLarge: CGFloat = .dynamic(64)
    public static let ultraLarge: CGFloat = .dynamic(128)
    public static let full: CGFloat = 9999
    
    // MARK: - Corner Radius
    public static let radius: CGFloat = 12
}
