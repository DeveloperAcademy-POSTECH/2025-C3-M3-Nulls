//
//  StudyEndView.swift
//  Medimo
//
//  Created by bear on 6/6/25.
//

import SwiftUI

struct StudyEndView: View {
    var body: some View {
        
        VStack{
        StudyEndGoodView()
            
                .padding()
        StudyEndCountView()
            
        StudyEndCharacterView()
                
    }
        ZStack {
            StudyEndCloudView()
            NextButton(buttonText: "학습 종료하기", action: {})
        }
        
    }
}
#Preview {
    StudyEndView()
}
