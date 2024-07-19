//
//  EmojiRatingView.swift
//  SwiftUILearn
//
//  Created by QinY on 18/7/2024.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating:Int
    var body: some View {
        switch rating {
        case 1 :
            Image(systemName: "1.circle")
        case 2 :
            Image(systemName: "2.circle")
        case 3 :
            Image(systemName: "3.circle")
        case 4 :
            Image(systemName: "4.circle")
        default:
            Image(systemName: "5.circle")
        }
    }
}

#Preview {
    EmojiRatingView(rating: 3)
}
