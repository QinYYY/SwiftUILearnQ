//
//  Location.swift
//  SwiftUILearn
//
//  Created by QinY on 3/9/2024.
//

import Foundation
import MapKit
struct Location:Identifiable,Codable,Equatable {
    var id : UUID
    var name: String
    var description: String
    var latitude:Double
    var longitude:Double
    
    var coordinate:CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func ==(lhs:Location,rhs:Location) -> Bool {
        lhs.id == rhs.id
    }
    
}
