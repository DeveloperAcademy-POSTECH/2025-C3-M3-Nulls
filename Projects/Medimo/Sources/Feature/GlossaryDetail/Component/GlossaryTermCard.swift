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
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                if let spelling = spelling {
                    Text(spelling)
                        .font(.subheadlineEng)
                        .foregroundColor(AppColor.label)
                }
                if let meaning = meaning {
                    HStack(alignment: .top, spacing: 10) {
                        if let abbreviation = abbreviation, !abbreviation.isEmpty {
                            Text("[\(abbreviation)]")
                                .font(.subheadlineEng).foregroundColor(AppColor.label)
                        }

                        Text(meaning)
                            .font(.caption)
                            .foregroundColor(AppColor.secondaryLabel)
                    }
                }
            }
            Rectangle()
                .fill(AppColor.grey2)
                .frame(height: 1)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .topLeading)
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
    .environment(\.managedObjectContext, CoreDataManager.preview.container.viewContext)
}
