//
//  StudyEndCharacterView.swift
//  Medimo
//
//  Created by bear on 6/6/25.
//

import SwiftUI

struct StudyEndCharacterView: View {
    var body: some View {
        Image("character1")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 252, height:215)
    }
}

#Preview {
    StudyEndCharacterView()
}
