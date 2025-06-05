
//
//  TermListViewModel.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import Foundation
import CoreData
import Observation
import AVFoundation

@Observable
class DictionaryDetailViewModel {
    var term: Term
    var morphemes: String = ""
    
    init(term: Term) {
        self.term = term
    }
    func parseMorphemes(_ term: Term) -> String {
        let morphemes = (term.morphemes as? Set<Morpheme>)?
            .compactMap { "\($0.spelling ?? ""): \($0.meaning ?? "")" }
            .joined(separator: "\n")
        return morphemes ?? "없음"
    }
    
    static let synthesizer = AVSpeechSynthesizer()

    func speak(_ text: String) {
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }

        let utterance = AVSpeechUtterance(string: trimmedText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.35
        utterance.pitchMultiplier = 1.2
        utterance.volume = 1.0

        DictionaryDetailViewModel.synthesizer.stopSpeaking(at: .immediate)
        DictionaryDetailViewModel.synthesizer.speak(utterance)
    }
    
}
