//
//  FlashCard.swift
//  Projects
//
//  Created by 이서현 on 6/1/25

import CoreData
import SwiftUI

struct TermCardView: View {
    @ObservedObject var term: Term
    @Environment(\.managedObjectContext) var context

    @State private var isPlaying = false
    @State private var isFlipped = false
    @State var viewModel: DictionaryDetailViewModel

    var backgroundColor: Color = AppColor.white

    init(term: Term, backgroundColor: Color) {
        self.term = term
        self.backgroundColor = backgroundColor
        _viewModel = State(wrappedValue: DictionaryDetailViewModel(term: term))
    }

    var user: User {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let users = (try? context.fetch(fetchRequest)) ?? []
        return users.first ?? User(context: context)
    }

    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor)
                .shadow(color: .black.opacity(0.2), radius: 5)

            VStack(spacing: 8) {
                HStack {
                    DictionaryDetailViewComponents.soundButton(
                        spelling: viewModel.term.spelling
                    ) {
                        if let spelling = viewModel.term.spelling {
                            viewModel.speak(spelling)
                        }
                    }

                    Spacer()

                    // TODO: - 북마크 로직 수정
                    BookmarkButtonView(user: user, term: viewModel.term)
                }
                .padding(20)

                VStack(alignment: .leading) {
                    Text((isFlipped ? term.meaning : term.spelling) ?? "")
                        .font(isFlipped ? .title : .titleEng)
                    if !isFlipped, let abbreviation = term.abbreviation {
                        if !abbreviation.isEmpty {
                            Text("[\(abbreviation)]")
                                .font(.headlineEng)
                                .padding(.vertical)
                        }
                    }
                }
                .foregroundStyle(AppColor.label)
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                VStack(alignment: .leading) {
                    if isFlipped {
                        Text(term.explanation ?? "")
                    } else {
                        if let morphemes = term.morphemes as? Set<Morpheme> {
                            let morphemeArray = morphemes.sorted { ($0.spelling ?? "") < ($1.spelling ?? "") }

                            VStack(alignment: .leading, spacing: 4) {
                                ForEach(morphemeArray, id: \.self) { morpheme in
                                    Text("\(morpheme.spelling ?? "") \(morpheme.meaning ?? "")")
                                }
                            }
                        }
                    }
                }
                .font(.caption)
                .foregroundStyle(AppColor.grey4)
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(28)
        }
        .frame(height: 480)
        .onTapGesture {
            isFlipped.toggle()
        }
    }
}

#Preview {
    let context = CoreDataManager.preview.container.viewContext
    var term = Term(context: context)

    let morpheme1 = Morpheme(context: context)
    morpheme1.spelling = "neur"
    morpheme1.meaning = "신경"

    let morpheme2 = Morpheme(context: context)
    morpheme2.spelling = "itis"
    morpheme2.meaning = "~의 염증"

    term = Term(context: context)
    term.spelling = "Neuritis"
    term.abbreviation = "NT"
    term.meaning = "신경의 염증"
    term.morphemes = NSOrderedSet(array: [morpheme1, morpheme2])
    term.explanation = """
    Neuritis는 신경에 염증이 생긴 상태를 의미합니다.
    이로 인해 통증, 감각 저하, 근육 약화 등의 증상이 나타날 수 있습니다.
    주로 감염, 외상 또는 자가면역 반응으로 인해 발생합니다.
    """

    return TermCardView(term: term, backgroundColor: AppColor.white)
        .environment(\.managedObjectContext, context)
}
