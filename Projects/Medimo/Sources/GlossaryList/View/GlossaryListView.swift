//
//  GlossaryListView.swift
//  Projects
//
//  Created by 양시준 on 5/30/25.
//

import CoreData
import SwiftUI

struct GlossaryListView: View {
    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject private var navigationManager: NavigationManager
    @State private var viewModel: GlossaryListViewModel
    @State private var selectedCategory: String = "전체"

    private let columns: [GridItem] = [
        GridItem(.fixed(170)),
        GridItem(.fixed(170))
    ]

    init(context: NSManagedObjectContext) {
        _viewModel = State(wrappedValue: GlossaryListViewModel(context: context))
    }

    var body: some View {
        ZStack(alignment: .top) {
            // MARK: - Background Layers
            VStack(spacing: 0) {
                Color("MM_Skyblue")
                    .frame(height: 183)
                Color.white
            }
            .ignoresSafeArea()

            VStack(spacing: 0) {
                // MARK: - Header Section
                VStack(alignment: .leading, spacing: 16) {
                    Text("단어장")
                        .font(.custom("S-Core Dream", size: 28).weight(.bold))
                        .foregroundColor(Color("MM_Navy"))
                        .padding(.top, 27)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 14)
//
                    ZStack(alignment: .bottom) {
                        
                        GlossaryCategoryBar(selectedCategory: $selectedCategory)
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(height: 16)
                            .offset(y: 8)
                    }
                    .padding(.horizontal, 19)
                    .zIndex(1)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                //.padding(.bottom, 24)

                // MARK: - Glossary Card Grid
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.glossaries) { glossary in
                            Button {
                                navigationManager.push(to: .GlossaryDetail(glossary: glossary))
                            } label: {
                                GlossaryCardView(
                                    title: glossary.title ?? "알 수 없음",
                                    currentCount: 1,
                                    totalCount: 200
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 20)
                    .padding(.bottom, 32)
                }
            }
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    GlossaryListView(context: context)
        .environmentObject(NavigationManager())
        .environment(\.managedObjectContext, context)
}
