//
//  AbbreviationView.swift
//  Projects
//
//  Created by 이서현 on 6/5/25.
//

import SwiftUI

struct AbbreviationTestView: View {
    var term: Term

    var body: some View {
        VStack(alignment: .leading) {
            Text("용어의 약어를 적어주세요")
                .font(.caption)
                .padding(.bottom, 25)
                .padding(.leading, 8)
            TestTermBox(term: term.spelling ?? "No Abbreviation")
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    let context = CoreDataManager.preview.container.viewContext

    let sampleTerm = Term(context: context)
    sampleTerm.spelling = "Electrocardiogram"
    sampleTerm.meaning = "심전도"

    return AbbreviationTestView(term: sampleTerm)
        .environment(\.managedObjectContext, context)
}
