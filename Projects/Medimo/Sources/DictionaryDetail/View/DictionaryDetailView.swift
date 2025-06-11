//
//  DictionaryDetailView.swift
//  Projects
//

import CoreData
import SwiftUI
import AVFAudio
import Combine

struct DictionaryDetailView: View {
    @Environment(\.managedObjectContext) var context
    let coreDataManager = CoreDataManager.shared

    @State var viewModel: DictionaryDetailViewModel
    @State private var showSoundAlert = false
    @State private var volumeCancellable: AnyCancellable?

    init(term: Term) {
        _viewModel = State(wrappedValue: DictionaryDetailViewModel(term: term))
    }

    var user: User {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        let users = (try? context.fetch(fetchRequest)) ?? []
        return users.first ?? User(context: context)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Spacer()
                    DictionaryDetailViewComponents.characterImage()
                }

                VStack(spacing: 0) {
                    ScrollView {
                        VStack(alignment: .leading) {

                            // MARK: - 사운드, 북마크 버튼
                            HStack {
                                DictionaryDetailViewComponents.soundButton(
                                    spelling: viewModel.term.spelling
                                ) {
                                    VolumeHelper.checkVolumeAndPlay(
                                        spelling: viewModel.term.spelling,
                                        onTooLowVolume: { showSoundAlert = true },
                                        onSuccess: { showSoundAlert = false }
                                    )
                                }
                                Spacer()
                                BookmarkButtonView(user: user, term: viewModel.term)
                            }
                            .padding(.top, 48)
                            .padding(.bottom, 20)

                            // MARK: - 용어, 약어, 분과
                            VStack(alignment: .leading) {
                                Text(viewModel.term.spelling ?? "")
                                    .font(.titleEng)
                                    .foregroundColor(AppColor.label)
                                    .padding(.bottom, 8)

                                if let abbreviation = viewModel.term.abbreviation, !abbreviation.isEmpty {
                                    Text("[ \(abbreviation) ]")
                                        .font(.titleEng)
                                        .foregroundColor(AppColor.label)
                                }

                                DictionaryDetailViewComponents.sectionGlossary(viewModel.term.glossaries)
                                DictionaryDetailViewComponents.sectionRectangle()
                            }
                        }
                        .padding(.horizontal, 32)

                        // MARK: - 의미
                        DictionaryDetailViewComponents.meaningSection(viewModel.term.meaning)

                        // MARK: - 어원
                        if let morphemes = (viewModel.term.morphemes)?.array as? [Morpheme], !morphemes.isEmpty {
                            DictionaryDetailViewComponents.morphemeSection(morphemes)
                        }

                        // MARK: - 설명
                        DictionaryDetailViewComponents.explanationSection(viewModel.term.explanation)

                        Spacer()
                    }
                }

                if showSoundAlert {
                    VStack {
                        Spacer()
                        SoundAlert()
                            .padding(.bottom, 80)
                            .padding(.horizontal, 35)
                    }
                }
            }
        }
        .onAppear {
            // 볼륨 감시 시작
            let session = AVAudioSession.sharedInstance()
            try? session.setActive(true)
            
            volumeCancellable = Timer.publish(every: 0.5, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    let volume = session.outputVolume
                    if volume >= 0.05 {
                        if showSoundAlert {
                            showSoundAlert = false
                        }
                    }
                }
        }
        .onDisappear {
            volumeCancellable?.cancel()
        }
    }
}
