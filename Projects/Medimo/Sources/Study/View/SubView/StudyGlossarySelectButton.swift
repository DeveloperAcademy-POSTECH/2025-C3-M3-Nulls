//
//  StudyGlossarySelectButton.swift
//  Projects
//
//  Created by 양시준 on 6/8/25.
//

import SwiftUI

struct StudyGlossarySelectButton: View {
    var glossary: Glossary!
    let studiedCount = 2
    @Binding var selectedGlossary: Glossary?
    let studyManager = StudyManager.shared

    var body: some View {
        Button {
            StudyManager.shared.studyingGlossaryId = glossary.id
            selectedGlossary = glossary
        } label: {
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(glossary.title ?? "")
                        .font(.body)
                        .foregroundStyle(AppColor.label)
                    ProgressBar(index: studiedCount, total: glossary.terms?.count ?? 0, format: "%d")
                }
                Image("chevron-right")
                    .frame(width: 24, height: 24)
                    .foregroundStyle(AppColor.systemFill)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .inset(by: 1)
                    .fill(AppColor.secondarySystemGroupedBackground)
                    .stroke(
                        studyManager.studyingGlossaryId ?? 0 == glossary.id ? AppColor.systemFill : Color.clear,
                        lineWidth: 2
                    )
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    @Previewable @State var selectedGlossary: Glossary? = nil
    let context = CoreDataManager.preview.container.viewContext
//    StudyManager.shared.setContext(context)
    var glossary = try! context.fetch(Glossary.fetchRequest()).first!

    return StudyGlossarySelectButton(glossary: glossary, selectedGlossary: $selectedGlossary)
}
