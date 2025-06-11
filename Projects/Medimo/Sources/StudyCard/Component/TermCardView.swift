//
//  FlashCard.swift
//  Projects
//
//  Created by 이서현 on 6/1/25

import CoreData
import SwiftUI
import AVFAudio
import Combine

struct TermCardView: View {
    @ObservedObject var term: Term
    @Environment(\.managedObjectContext) var context

    @State private var isPlaying = false
    @State private var isFlipped = false
    @State var viewModel: DictionaryDetailViewModel

    @Binding var showSoundAlert: Bool
    @State private var volumeCancellable: AnyCancellable?

    var backgroundColor: Color = AppColor.white

    init(term: Term, showSoundAlert: Binding<Bool>, backgroundColor: Color) {
        self.term = term
        self._showSoundAlert = showSoundAlert
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
                        checkVolumeAndPlay()
                    }

                    Spacer()
                    BookmarkButtonView(user: user, term: viewModel.term)
                }
                .padding(20)

                VStack(alignment: .leading) {
                    Text((isFlipped ? term.meaning : term.spelling) ?? "")
                        .font(isFlipped ? .title : .titleEng)
                    if !isFlipped, let abbreviation = term.abbreviation, !abbreviation.isEmpty {
                        Text("[\(abbreviation)]")
                            .font(.headlineEng)
                            .padding(.vertical)
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
                        if let morphemes = (term.morphemes)?.array as? [Morpheme] {
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
        .onTapGesture { isFlipped.toggle() }
        .onAppear { startVolumeMonitoring() }
        .onDisappear { volumeCancellable?.cancel() }
    }

    private func checkVolumeAndPlay() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(true)
        } catch {
            showSoundAlert = true
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let volume = session.outputVolume
            print("볼륨 확인 (딜레이 후): \(volume)")
            if volume < 0.05 {
                showSoundAlert = true
            } else {
                if let spelling = term.spelling {
                    viewModel.speak(spelling)
                }
                showSoundAlert = false
            }
        }
    }

    private func startVolumeMonitoring() {
        let session = AVAudioSession.sharedInstance()
        try? session.setActive(true)

        volumeCancellable = Timer.publish(every: 0.5, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                let volume = session.outputVolume
                if volume < 0.05 {
                    if !showSoundAlert { showSoundAlert = true }
                } else {
                    if showSoundAlert { showSoundAlert = false }
                }
            }
    }
}
