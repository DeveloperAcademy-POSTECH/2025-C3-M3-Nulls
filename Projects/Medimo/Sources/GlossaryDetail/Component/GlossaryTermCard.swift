//
//  GlossaryTermCard.swift
//  Projects
//
//  Created by Ell Han on 6/5/25.
//


//
//  GlossaryTermCard.swift
//  Medimo
//
//  Created by Ell Han on 2025/06/05.
//

import SwiftUI

struct GlossaryTermCard: View {
    let spelling: String?
    let abbreviation: String?
    let meaning: String?

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                // 영어 용어
                if let spelling = spelling {
                    Text(spelling)
                        .font(.subheadlineEng)
                        .foregroundColor(AppColor.navy)
                        .frame(width: 373, alignment: .leading)
                }

                // 약어와 뜻
                if let meaning = meaning {
                    HStack(alignment: .top, spacing: 10) {
                        if let abbreviation = abbreviation, !abbreviation.isEmpty {
                            Text("[\(abbreviation)]")
                                .font(.subheadlineEng)                                .foregroundColor(AppColor.navy)
                        }
                        
                        Text(meaning)
                            .font(.caption)
                            .foregroundColor(AppColor.grey4)
                    }
                    .frame(width: 373, alignment: .leading)
                }
            }
            .padding(0)
            .overlay(
                GeometryReader { geometry in
                    VStack {
                        Spacer()
                            .padding(17)
                        Rectangle()
                            .fill(AppColor.grey2)
                            .frame(height: 1)
                    }
                }
            )
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding(0)
        .frame(width: 373, alignment: .bottom)
        .padding(16)
    }
}

// MARK: - Preview
#Preview {
    return GlossaryTermCard(
        spelling: "Arterial Blood Gas Analysis",
        abbreviation: "ABGA",
        meaning: "동맥혈 가스 분석"
    )
    .padding()
    .previewLayout(.sizeThatFits)
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
