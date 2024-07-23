//
//  SwiftDataUser.swift
//  SwiftUILearn
//
//  Created by QinY on 23/7/2024.
//

import Foundation
import SwiftData

@Model
class SwiftDataUser {
    var name : String
    var city : String
    var joinDate:Date
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}
