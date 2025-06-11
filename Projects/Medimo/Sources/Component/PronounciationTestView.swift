//
//  PronounciationTestView.swift
//  Projects
//
//  Created by 이서현 on 6/5/25.
//

import AVFAudio
import Combine
import SwiftUI

struct PronounciationTestView: View {
    var term: Term

    @Binding var showSoundAlert: Bool

    @State var viewModel: DictionaryDetailViewModel
    @State private var volumeCancellable: AnyCancellable?

    init(term: Term, showSoundAlert: Binding<Bool>, isAnswered: Binding<Bool>) {
        self.term = term
        self._showSoundAlert = showSoundAlert
        self._isAnswered = isAnswered
        _viewModel = State(initialValue: DictionaryDetailViewModel(term: term))
    }
    
    @Binding var isAnswered: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("음성을 듣고 철자를 적어주세요")
                .font(.caption)
                .padding(.bottom, 25)
                .padding(.leading, 8)
            HStack(alignment: .center) {
                Spacer()

                Button(action: {
                    let session = AVAudioSession.sharedInstance()
                    do {
                        try session.setActive(true)
                        let volume = session.outputVolume

                        if volume < 0.05 {
                            showSoundAlert = true
                        } else {
                            if let spelling = term.spelling {
                                DictionaryDetailViewModel.sharedSpeak(spelling)
                            }
                            showSoundAlert = false
                        }
                    } catch {
                        print("AVAudioSession 실패: \(error)")
                        showSoundAlert = true
                    }
                }) {
                    Image("volume-2")
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 67, height: 67)
                        .foregroundStyle(AppColor.navy)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 35)
                        .background(AppColor.white)
                        .cornerRadius(28)
                }
                .padding(.bottom, 37)
                .shadow(color: AppColor.blue.opacity(0.45), radius: 5, x: 2, y: 4)

                Spacer()
            }
        }
        .background(AppColor.bgColor)
        .onAppear {
            let session = AVAudioSession.sharedInstance()
            try? session.setActive(true)

            volumeCancellable = Timer.publish(every: 0.5, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    guard !isAnswered else { return }
                    let volume = session.outputVolume
                    showSoundAlert = volume < 0.05
                }
        }
        .onDisappear {
            volumeCancellable?.cancel()
        }
    }
}
