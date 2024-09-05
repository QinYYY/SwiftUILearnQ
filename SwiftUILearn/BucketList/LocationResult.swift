//
//  Result.swift
//  SwiftUILearn
//
//  Created by QinY on 4/9/2024.
//

import Foundation

struct LocationResult:Codable {
    let query:LocationQuery
}

struct LocationQuery:Codable {
    let pages:[Int:Page]
}

struct Page:Codable {
    let pageid:Int
    let title:String
    let terms:[String:[String]]?
}
