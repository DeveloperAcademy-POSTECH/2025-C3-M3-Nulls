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
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading) {
                        //MARK: -- 사운드, 북마크
                        HStack {
                            Button(action: {
                                if let spelling = viewModel.term.spelling {
                                    viewModel.speak(spelling)
                                }
                            }) {
                                Image(systemName:"speaker.wave.2.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24)
                                    .foregroundStyle(AppColor.primary)
                                
                            }
                            Spacer()
                            Image("bookmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)
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
                            
                            if viewModel.term.abbreviation != nil {
                                Text("[ \(viewModel.term.abbreviation ?? "") ]")
                                    .font(.titleEng)
                                    .foregroundColor(AppColor.primary)
                            }
                            Text(
                                (viewModel.term.glossarys as? Set<Glossary>)?
                                    .compactMap { $0.title }
                                    .joined(separator:  ", ") ?? ""
                            )
                            .font(.caption)
                            .foregroundColor(AppColor.secondary)
                            .padding(.top, 16)
                            .padding(.leading, 8)
                            
                            
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(AppColor.grey3)
                            
                        }
                        .padding(.horizontal,32)
                        
                        //MARK: -- 의미
                        VStack(alignment: .leading) {
                            Text("의미")
                                .font(.caption)
                                .foregroundColor(AppColor.tertiaryLabel)
                                .padding(.leading, 8)
                            
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
                                .padding(.top, 2)
                        }
                        .padding(.horizontal,32)
                        .padding(.top, 24)
                        
                        //MARK: -- 어원
                        if let morphemes = viewModel.term.morphemes as? Set<Morpheme>, !morphemes.isEmpty {
                            VStack(alignment: .leading) {
                                Text("어원")
                                    .font(.caption)
                                    .foregroundColor(AppColor.tertiaryLabel)
                                    .padding(.leading, 8)
                                
                                LinearGradient(
                                    gradient: Gradient(colors: [AppColor.blue, AppColor.white]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                .frame(height: 1)
                                
                                VStack(alignment: .leading) {
                                    ForEach(Array(morphemes), id: \.self) { morpheme in
                                        HStack {
                                            Text(morpheme.spelling ?? "")
                                                .font(.caption)
                                                .foregroundColor(AppColor.label)
                                            Text("-")
                                                .font(.caption)
                                                .foregroundColor(AppColor.grey4)
                                            Text(morpheme.meaning ?? "")
                                                .font(.caption)
                                                .foregroundColor(AppColor.label)
                                        }
                                        .padding(.leading, 8)
                                    }
                                }
                                .padding(.top, 2)
                            }
                            .padding(.horizontal,32)
                            .padding(.top, 24)
                        }
                        
                        
                        //MARK: -- 설명
                        VStack(alignment: .leading) {
                            Text("설명")
                                .font(.caption)
                                .foregroundColor(AppColor.tertiaryLabel)
                                .padding(.leading, 8)
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
                                .padding(.top, 2)
                        }
                        .padding(.horizontal,32)
                        .padding(.top, 24)
                        
                        Spacer()
                    }
                }
                Image("character5")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding(.trailing, 32)
                    .padding(.bottom, -35)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

#Preview {
    DictionaryDetailView(
        term: try! PersistenceController.preview.container.viewContext.fetch(Term.fetchRequest())[4]
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
