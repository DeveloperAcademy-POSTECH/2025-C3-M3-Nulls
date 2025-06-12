//
//  TermCardView.swift
//  Projects
//

import CoreData
import SwiftUI
import Combine

struct TermCardView: View {
    @ObservedObject var term: Term
    @Environment(\.managedObjectContext) var context

    @State private var isFlipped = false
    @State var viewModel: DictionaryDetailViewModel

    @Binding var showSoundAlert: Bool
    @Binding var isSoundButtonTapped: Bool

    var backgroundColor: Color = AppColor.white

    init(term: Term, showSoundAlert: Binding<Bool>, isSoundButtonTapped: Binding<Bool>, backgroundColor: Color) {
        self.term = term
        self._showSoundAlert = showSoundAlert
        self._isSoundButtonTapped = isSoundButtonTapped
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
                .shadow(color: .black.opacity(0.35), radius: 20, x: 0, y: 4)

            VStack(spacing: 0) {
                HStack {
                    DictionaryDetailViewComponents.soundButton(spelling: viewModel.term.spelling) {
                        isSoundButtonTapped = true
                        VolumeHelper.checkVolumeAndPlay(
                            spelling: viewModel.term.spelling,
                            onTooLowVolume: { showSoundAlert = true },
                            onSuccess: { showSoundAlert = false }
                        )
                    }
                    Spacer()
                    
                    BookmarkButtonView(user: user, term: viewModel.term)
                }
                .padding(.top, 30)

                VStack(alignment: .leading) {
                    Text((isFlipped ? term.meaning : term.spelling) ?? "")
                        .font(isFlipped ? .title : .titleEng)
                    if !isFlipped, let abbreviation = term.abbreviation, !abbreviation.isEmpty {
                        Text("[\(abbreviation)]").font(.headlineEng).padding(.vertical)
                    }
                }
                .foregroundStyle(AppColor.label)
                .padding(.vertical, 55)
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                VStack(alignment: .leading) {
                    if isFlipped {
                        Text(term.explanation ?? "")
                    } else {
                        if let morphemes = (term.morphemes)?.array as? [Morpheme] {
                            let morphemeArray = morphemes.sorted { ($0.spelling ?? "") < ($1.spelling ?? "") }
                            VStack(alignment: .leading, spacing: 7) {
                                ForEach(morphemeArray, id: \.self) { morpheme in
                                    Text("\(morpheme.spelling ?? "") \(morpheme.meaning ?? "")")
                                }
                            }
                        }
                    }
                }
                .font(.caption)
                .foregroundStyle(AppColor.grey4)
                .padding(.vertical, 30)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(30)
        }
        .frame(height: 480)
        .onTapGesture { isFlipped.toggle() }
    }
}
