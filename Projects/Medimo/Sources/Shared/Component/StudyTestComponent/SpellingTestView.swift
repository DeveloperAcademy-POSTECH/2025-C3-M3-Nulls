//
//  SpellingTestView.swift
//  Projects
//
//  Created by 이서현 on 6/5/25.
//

import SwiftUI

struct SpellingTestView: View {
    var term: Term

    var body: some View {
        VStack(alignment: .leading) {
            Text("의미를 보고 용어를 적어주세요")
                .font(.caption)
                .padding(.bottom, 25)
                .padding(.leading, 8)
            TestTermBox(term: term.meaning ?? "No Meaning")
                .padding(.bottom, 40)
        }
    }
}

#Preview {
    let context = CoreDataManager.preview.container.viewContext

    let sampleTerm = Term(context: context)
    sampleTerm.spelling = "Electrocardiogram"
    sampleTerm.meaning = "심전도"

    return SpellingTestView(term: sampleTerm)
        .environment(\.managedObjectContext, context)
}
