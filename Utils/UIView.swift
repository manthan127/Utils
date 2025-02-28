//
//  File.swift
//  
//
//  Created by Home on 17/09/24.
//

import UIKit

extension UIView {
    var size : CGSize {
        get {
            frame.size
        } set {
            frame.size = newValue
        }
    }
    
    var width: CGFloat {
        get {
            frame.width
        } set {
            frame.size.width = newValue
        }
    }
    
    var height: CGFloat {
        get {
            frame.height
        } set {
            frame.size.height = newValue
        }
    }
    
    
    var origin: CGPoint {
        get {
            frame.origin
        } set {
            frame.origin = newValue
        }
    }
    
    var x: CGFloat {
        get {
            frame.origin.x
        } set {
            frame.origin.x = newValue
        }
    }
    
    var y: CGFloat {
        get {
            frame.origin.y
        } set {
            frame.origin.y = newValue
        }
    }
}
