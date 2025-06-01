//
//  FlashCardView.swift
//  Projects
//
//  Created by 이서현 on 6/1/25.
//

import SwiftUI

struct FlashCardView: View {
    var body: some View {
        Text("1/10")
        
        CardView(term: "String", abbreviation: "String?")
        .padding()
    }
}

#Preview {
    FlashCardView()
}
