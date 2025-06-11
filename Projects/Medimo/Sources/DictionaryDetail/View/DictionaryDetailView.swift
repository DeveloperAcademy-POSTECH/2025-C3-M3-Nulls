//
//  TermListView.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
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
    @State private var isSoundButtonTapped = false

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
                } // VStack
                .background(AppColor.white)

                VStack(spacing: 0) {
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack {
                                DictionaryDetailViewComponents.soundButton(
                                    spelling: viewModel.term.spelling
                                ) {
                                    isSoundButtonTapped = true

                                    VolumeHelper.checkVolumeAndPlay(
                                        spelling: viewModel.term.spelling,
                                        onTooLowVolume: { showSoundAlert = true },
                                        onSuccess: { showSoundAlert = false }
                                    )
                                }
                                Spacer()
                                BookmarkButtonView(user: user, term: viewModel.term)
                            } // HStack
                            .padding(.top, 48)
                            .padding(.bottom, 20)

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
                            } // VStack
                        } // VStack
                        .padding(.horizontal, 32)

                        DictionaryDetailViewComponents.meaningSection(viewModel.term.meaning)

                        if let morphemes = (viewModel.term.morphemes)?.array as? [Morpheme], !morphemes.isEmpty {
                            DictionaryDetailViewComponents.morphemeSection(morphemes)
                        }

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
            let session = AVAudioSession.sharedInstance()
            try? session.setActive(true)

            volumeCancellable = Timer.publish(every: 0.5, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    guard isSoundButtonTapped else { return }
                    let volume = session.outputVolume
                    showSoundAlert = (volume < 0.05)
                }
        }
        .onDisappear {
            volumeCancellable?.cancel()
        }
    }
}
