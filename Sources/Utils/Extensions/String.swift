//
//  String.swift
//  Utils
//
//  Created by Home on 05/01/26.
//

import Foundation

extension String {
    var nonEmptyTrimmed: String? {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : self
    }
}
