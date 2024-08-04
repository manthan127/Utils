//
//  ViewController.swift
//  UtilTest
//
//  Created by Home on 04/08/24.
//

import UIKit
import Utils

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = CGPointZero + CGPoint()
        
        let name = UUID()
        let x: Int? = UserDefaults.standard["myKey"]
        UserDefaults.standard["myKey"] = name
        let y = UserDefaults.standard["myKey"] ?? "abc"
        print(x ?? -123, y)
    }
}
