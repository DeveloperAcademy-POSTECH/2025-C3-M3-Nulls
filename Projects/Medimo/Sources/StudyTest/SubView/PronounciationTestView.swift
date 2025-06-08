//
//  PronounciationTestView.swift
//  Projects
//
//  Created by 이서현 on 6/5/25.
//

import SwiftUI

struct PronounciationTestView: View {
    var term: Term
    
    @State var viewModel: DictionaryDetailViewModel
    
    init(term: Term) {
        self.term = term
        _viewModel = State(wrappedValue: DictionaryDetailViewModel(term: term))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("음성을 듣고 철자를 적어주세요")
                .font(.caption)
                .padding(.bottom, 25)
                .padding(.leading, 8)
            HStack(alignment: .center) {
                Spacer()
                
                Button(action: {
                    if let spelling = viewModel.term.spelling {
                        viewModel.speak(spelling)
                    }
                }) {
                    Image("volume-2")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 67, height: 67)
                        .foregroundStyle(AppColor.navy)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 35)
                        .background(AppColor.white)
                        .cornerRadius(28)
                }
                .padding(.bottom, 37)
                .shadow(color: AppColor.blue.opacity(0.45), radius: 5, x: 2, y: 4)
                
                Spacer()
            }
        }
        .background(AppColor.bgColor)
    }
}

struct PronounciationTestViewPreview: View {
    var body: some View {
        let context = PersistenceController.preview.container.viewContext

        let sampleTerm: Term = {
            let term = Term(context: context)
            term.spelling = "Electrocardiogram"
            term.meaning = "심전도"
            return term
        }()

        return PronounciationTestView(term: sampleTerm)
            .environment(\.managedObjectContext, context)
    }
}

#Preview {
    PronounciationTestViewPreview()
}
