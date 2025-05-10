//
//  delay.swift
//  Utils
//
//  Created by Home on 10/05/25.
//

import Foundation

func delay(of delaySeconds: Double, qos: DispatchQoS = .unspecified, flags: DispatchWorkItemFlags = [], execute work: @escaping @Sendable @convention(block) () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delaySeconds,qos: qos, flags: flags, execute: work)
}

func delay(of delaySeconds: Double, execute: DispatchWorkItem) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delaySeconds, execute: execute)
}
