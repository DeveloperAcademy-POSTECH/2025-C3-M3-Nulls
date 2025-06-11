//
//  StudyGlossarySelectButton.swift
//  Projects
//
//  Created by 양시준 on 6/8/25.
//

import CoreData
import SwiftUI

struct StudyGlossarySelectButton: View {
    @AppStorage("selectedGlossaryId") private var selectedGlossaryId: Int = 0

    var user: User {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let users = (try? CoreDataManager.shared.context.fetch(fetchRequest)) ?? []

        return users.first ?? User(context: CoreDataManager.shared.context)
    }

    var glossary: Glossary!

    var currentCount: Int {
        Int(user.progressForGlossary(glossary.id)?.studiedCount ?? 0)
    }

    var totalCount: Int {
        glossary.terms?.count ?? 0
    }

    @Binding var selectedGlossary: Glossary?
    let studyManager = StudyManager.shared

    var studiedCount: Int {
        return Int(studyManager.user.progressForGlossary(glossary.id)?.studiedCount ?? 0)
    }

    var body: some View {
        Button {
            selectedGlossary = glossary
            selectedGlossaryId = Int(glossary.id)

            studyManager.studyingGlossaryId = selectedGlossary?.id

            print("⚠️ selected glossary ID: \(selectedGlossaryId)")
        } label: {
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(glossary.title ?? "")
                        .font(.body)
                        .foregroundStyle(AppColor.label)
                    HStack {
                        Capsule()
                            .fill(AppColor.secondarySystemFill)
                            .frame(height: 8)
                            .overlay(
                                GeometryReader { geometry in
                                    Capsule()
                                        .fill(AppColor.systemFill)
                                        .frame(width: geometry.size.width * CGFloat(currentCount) / CGFloat(totalCount), height: 8)
                                }
                                .clipShape(Capsule())
                            )
                        Text("\(currentCount)/\(totalCount)")
                            .font(.caption)
                            .foregroundStyle(AppColor.systemFill)
                    }
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

// #Preview {
//    @Previewable @State var selectedGlossary: Glossary? = nil
//    let context = CoreDataManager.preview.container.viewContext
////    StudyManager.shared.setContext(context)
//    var glossary = try! context.fetch(Glossary.fetchRequest()).first!
//
//    return StudyGlossarySelectButton(glossary: glossary, selectedGlossary: $selectedGlossary)
// }
