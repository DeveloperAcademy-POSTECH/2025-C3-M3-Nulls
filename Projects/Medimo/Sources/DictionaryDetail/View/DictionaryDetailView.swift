//
//  TermListView.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import SwiftUI
import CoreData

struct DictionaryDetailView: View {
    @Environment(\.managedObjectContext) var context
    
    @State var viewModel: DictionaryDetailViewModel
    
    init(term: Term) {
        _viewModel = State(wrappedValue: DictionaryDetailViewModel(term: term))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    //MARK: -- 사운드, 북마크
                    HStack {
                        Button(action: {
                            if let spelling = viewModel.term.spelling {
                                viewModel.speak(spelling)
                            }
                        }) {
                            Image(systemName:"speaker.wave.3.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24)
                                .foregroundStyle(AppColor.primary)
                                
                        }
                        Spacer()
                        Image(systemName: "bookmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22.5, height: 17.5)
                            .foregroundStyle(AppColor.primary)
                    }
                    .padding(.horizontal,32)
                    .padding(.top, 48)
                    .padding(.bottom, 20)

                    //MARK: -- 용어, 약어, 분과
                    VStack(alignment: .leading) {
                        Text(viewModel.term.spelling ?? "")
                            .font(.titleEng)
                            .foregroundColor(AppColor.primary)
                            .padding(.bottom, 8)

                        Text("[\(viewModel.term.abbreviation ?? "no abbreviation")]")
                            .font(.titleEng)
                            .foregroundColor(AppColor.primary)

                        Text(
                            (viewModel.term.glossarys as? Set<Glossary>)?
                                .compactMap { $0.title }
                                .joined(separator:  ", ") ?? ""
                        )
                        .font(.caption)
                        .foregroundColor(AppColor.secondary)
                        .padding(.top, 16)
                        .padding(.bottom, 10)

                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(AppColor.grey3)
                        
                    }
                    .padding(.horizontal,32)
                    
                    //MARK: -- 뜻
                    VStack(alignment: .leading) {
                        Text("의미")
                            .font(.caption)
                            .foregroundColor(AppColor.tertiaryLabel)
                            .padding(.leading, 8)
                            .padding(.bottom, -8)
                            
                        LinearGradient(
                            gradient: Gradient(colors: [AppColor.blue, AppColor.white]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(height: 1)

                        Text(viewModel.term.meaning ?? "")
                            .font(.body)
                            .foregroundColor(AppColor.label)
                            .padding(.leading, 8)
                    }
                    .padding(.horizontal,32)
                    .padding(.top, 24)

                    //MARK: -- 어원
                    VStack(alignment: .leading, spacing: 10) {
                        Text("어원")
                            .font(.caption)
                            .foregroundColor(AppColor.tertiaryLabel)
                            .padding(.leading, 8)
                            .padding(.bottom, -8)

                        LinearGradient(
                            gradient: Gradient(colors: [AppColor.blue, AppColor.white]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(height: 1)

                        VStack(alignment: .leading, spacing: 4) {
                            if let morphemes = viewModel.term.morphemes as? Set<Morpheme> {
                                ForEach(Array(morphemes), id: \.self) { morpheme in
                                    HStack {
                                        Text(morpheme.spelling ?? "")
                                            .font(.MM_AT)
                                            .foregroundColor(AppColor.label)
                                        Text("-")
                                            .foregroundColor(AppColor.grey4)
                                        Text(morpheme.meaning ?? "")
                                            .font(.MM_AT)
                                            .foregroundColor(AppColor.label)
                                    }
                                    .padding(.leading, 8)
                                }
                            }
                        }
                    }
                    .padding(.horizontal,32)
                    .padding(.top, 24)

                    //MARK: -- 설명
                    VStack(alignment: .leading, spacing: 10) {
                        Text("설명")
                            .font(.caption)
                            .foregroundColor(AppColor.tertiaryLabel)
                            .padding(.leading, 8)
                            .padding(.bottom, -8)

                        LinearGradient(
                            gradient: Gradient(colors: [AppColor.blue, AppColor.white]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .frame(height: 1)

                        Text(viewModel.term.explanation ?? "")
                            .font(.caption)
                            .foregroundColor(AppColor.label)
                            .padding(.leading, 8)
                    }
                    .padding(.horizontal,32)
                    .padding(.top, 24)

                    Spacer()
                }
            }
        }
    }
    
   
}

//                    .navigationTitle(viewModel.term.spelling ?? "")
//                    .navigationBarTitleDisplayMode(.large)


#Preview {
    DictionaryDetailView(
        term: try! PersistenceController.preview.container.viewContext.fetch(Term.fetchRequest())[0]
    )
    .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}


//abbreviation: String?
//explanation: String?
//id: UUID?
//meaning: String?
//spelling: String?
//termKey: String?
//glossarys: NSSet?
//morphemes: NSSet?
