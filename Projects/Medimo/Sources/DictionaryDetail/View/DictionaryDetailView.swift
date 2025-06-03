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
                    HStack {
                        Button(action: {
                            if let spelling = viewModel.term.spelling {
                                viewModel.speak(spelling)
                            }
                        }) {
                            Image(systemName:"speaker.wave.3")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24)
                                .foregroundStyle(Color("MM_Navy"))
                                
                        }
                        Spacer()
                        Image(systemName: "bookmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22.5, height: 17.5)
                            .foregroundStyle(Color("MM_Navy"))
                    }
                    .padding(.horizontal,32)
                    .padding(.top, 48)

                    VStack(alignment: .leading, spacing: 10) {
                        Text(viewModel.term.spelling ?? "")
                            .font(.MM_EH2)
                            .foregroundColor(Color("MM_Navy"))

                        Text("[\(viewModel.term.abbreviation ?? "no abbreviation")]")
                            .font(.MM_EH2)
                            .foregroundColor(Color("MM_Navy"))

                        Text(
                            (viewModel.term.glossarys as? Set<Glossary>)?
                                .compactMap { $0.title }
                                .joined(separator:  ", ") ?? ""
                        )
                        .font(.MM_AT)
                        .foregroundColor(Color("MM_Blue"))
                        .padding(.top, 20)

                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray)
                    }
                    .padding(.horizontal,32)

                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("의미")
                            .font(.MM_AT)
                            .foregroundColor(Color("MM_Grey3"))
                            

                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray)

                        Text(viewModel.term.meaning ?? "")
                            .font(.MM_Pr)
                            .foregroundColor(Color("MM_Navy"))
                    }
                    .padding(.horizontal,32)
                    .padding(.top, 20)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("어원")
                            .font(.MM_AT)
                            .foregroundColor(Color("MM_Grey3"))

                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray)

                        VStack(alignment: .leading, spacing: 4) {
                            if let morphemes = viewModel.term.morphemes as? Set<Morpheme> {
                                ForEach(Array(morphemes), id: \.self) { morpheme in
                                    HStack {
                                        Text(morpheme.spelling ?? "")
                                            .font(.MM_AT)
                                            .foregroundColor(Color("MM_Navy"))
                                        Text("-")
                                            .foregroundColor(.gray)
                                        Text(morpheme.meaning ?? "")
                                            .font(.MM_AT)
                                            .foregroundColor(Color("MM_Navy"))
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal,32)
                    .padding(.top, 20)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("설명")
                            .font(.MM_AT)
                            .foregroundColor(Color("MM_Grey3"))

                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color.gray)

                        Text(viewModel.term.explanation ?? "")
                            .font(.MM_AT)
                            .foregroundColor(Color("MM_Navy"))
                    }
                    .padding(.horizontal,32)
                    .padding(.top, 20)

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
