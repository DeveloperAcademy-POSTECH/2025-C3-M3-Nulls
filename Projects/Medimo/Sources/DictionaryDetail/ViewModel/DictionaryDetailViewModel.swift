
//
//  TermListViewModel.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//
import AVFoundation
import CoreData
import Foundation
import Observation

@Observable
class DictionaryDetailViewModel {
    var term: Term
    var morphemes: String = ""

    init(term: Term) {
        self.term = term
    }

    static let synthesizer = AVSpeechSynthesizer()

    func speak(_ text: String) {
        DictionaryDetailViewModel.sharedSpeak(text)
    }

    static func sharedSpeak(_ text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }

        do {
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(.playback, mode: .default, options: [.duckOthers])
            try session.setActive(true)
        } catch {
            print("AVAudioSession 설정 실패: \(error)")
        }

        let utterance = AVSpeechUtterance(string: trimmedText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.35
        utterance.pitchMultiplier = 1.2
        utterance.volume = 1.0

        let synthesizer = DictionaryDetailViewModel.synthesizer

        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                synthesizer.speak(utterance)
            }
        } else {
            synthesizer.speak(utterance)
        }
    }
}
