//
//  StudyGlossarySelectSheetView.swift
//  Projects
//
//  Created by 양시준 on 6/8/25.
//

import CoreData
import SwiftUI

struct StudyGlossarySelectSheetView: View {
    @Binding var isPresented: Bool
    @State var selectedCategory: MedicineCategory = .all
    @State var selectedGlossary: Glossary? = nil

    var glossaries: [Glossary] = []
    
    var filteredGlossaries: [Glossary] {
        if selectedCategory == .all {
            glossaries
        } else {
            glossaries.filter { $0.category == selectedCategory.rawValue }
        }
    }

    init(context: NSManagedObjectContext, isPresented: Binding<Bool>) {
        glossaries = try! context.fetch(Glossary.fetchRequest())
        _isPresented = isPresented
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Image("cloudBottom")
                    .resizable()
                    .scaledToFit()
            }
            VStack(spacing: 0) {
                CategorySelectButtonGroup(selectedCategory: $selectedCategory)
                    .padding(.horizontal, 32)
                    .padding(.top, 42)
                ScrollView {
                    VStack(spacing: 14) {
                        ForEach(filteredGlossaries) { glossary in
                            StudyGlossarySelectButton(glossary: glossary, selectedGlossary: $selectedGlossary)
                                .padding(.horizontal, 32)
                        }
                    }
                    .padding(.vertical, 24)
                }
                Spacer()
            }
            .scrollIndicators(.hidden)
        }
        .ignoresSafeArea(edges: .bottom)
        .background(AppColor.systemGroupedBackground)
        .onChange(of: selectedGlossary) {
            isPresented = false
        }
    }
}

#Preview {
    @Previewable @State var isPresented = true
    let context = CoreDataManager.preview.container.viewContext
    StudyManager.shared.setContext(context, 0)

    return StudyGlossarySelectSheetView(context: context, isPresented: $isPresented)
}
