//
//  TaskGroup.swift
//  VideoPlayer
//
//  Created by macm4 on 26/12/25.
//

extension TaskGroup {
    func arrayValue() async -> [ChildTaskResult] {
        var collected: [ChildTaskResult] = []
        for await item in self {
            collected.append(item)
        }
        
        return collected
    }
}
