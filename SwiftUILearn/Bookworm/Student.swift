//
//  Student.swift
//  SwiftUILearn
//
//  Created by QinY on 18/7/2024.
//

import Foundation
import SwiftData

@Model
class Student {
    
    var id:UUID
    var name:String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    
    
}
