//
//  Array.swift
//  Utils
//
//  Created by Home on 06/09/25.
//

import Foundation

extension Array {
     func first<T>(mapping: (Element)->T?) -> T? {
         for element in self {
             if let mappedValue = mapping(element) {
                 return mappedValue
             }
         }
         
         return nil
     }
 }
