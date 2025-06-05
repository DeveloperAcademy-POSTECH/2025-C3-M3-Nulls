//
//  InitialDataLoader.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import CoreData

class InitialDataLoader {
    let context: NSManagedObjectContext
    let cloudKitManager = CloudKitManager.shared

    var glossaryMap: [String: Glossary] = [:]
    var termMap: [String: Term] = [:]
    var morphemeMap: [String: Morpheme] = [:]

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func loadInitialData() async throws {
        try loadGlossaries()
        try await loadTerms()
        try await loadMorphemes()
        try linkGlossaryToTerm()
        try await linkTermToMorpheme()

        makeTermLearningStatus()
    }

    private func loadGlossaries() throws {
        let glossaries: [GlossaryDto] = try loadJsonData("glossaries.json")
        for g in glossaries {
            let glossary = Glossary(context: context)
            glossary.id = UUID()
            glossary.glossaryKey = g.glossaryKey
            glossary.title = g.title
            glossaryMap[g.glossaryKey] = glossary
        }
    }

    private func loadTerms() async throws {
        var terms: [TermDto] = []

        let result = await cloudKitManager.fetchAllTerms()
        switch result {
        case let .success(loadedTerms):
            print("✏️ Number of terms fetched: \(loadedTerms.count)")
            terms = loadedTerms

        case let .failure(error):
            print("Error fetching terms: \(error)")
        }

        for t in terms {
            let term = Term(context: context)
            term.id = UUID()
            term.termKey = t.termKey
            term.spelling = t.spelling
            term.abbreviation = t.abbreviation
            term.meaning = t.meaning
            term.explanation = t.explanation
            termMap[t.termKey] = term
        }

        let fetchRequest = Term.fetchRequest()
        let count = try context.count(for: fetchRequest)
        print("✅ Core Data 내 Term 개수: \(count)")
    }

    private func loadMorphemes() async throws {
        var morphemes: [MorphemeDto] = []

        let result = await cloudKitManager.fetchAllMorphemes()
        switch result {
        case let .success(loadedMorphemes):
            print("✏️ Number of morphemes fetched: \(loadedMorphemes.count)")
            morphemes = loadedMorphemes

        case let .failure(error):
            print("Error fetching: \(error)")
        }

        for m in morphemes {
            let morpheme = Morpheme(context: context)
            morpheme.id = UUID()
            morpheme.morphemeKey = m.morphemeKey
            morpheme.spelling = m.spelling
            morpheme.meaning = m.meaning
            morphemeMap[m.morphemeKey] = morpheme
        }
    }

    private func linkGlossaryToTerm() throws {
        let links: [GlossaryTermLinkDto] = try loadJsonData("glossary_term_links.json")
        for link in links {
            guard let glossary = glossaryMap[link.glossaryKey],
                  let term = termMap[link.termKey] else { continue }

            glossary.addToTerms(term)
            term.addToGlossarys(glossary)
        }
    }

    private func linkTermToMorpheme() async throws {
        var links: [TermMorphemeLinkDto] = []

        let result = await cloudKitManager.fetchAllTermMorphemeLinks()
        switch result {
        case let .success(loadedLinks):
            print("✏️ Number of links fetched: \(loadedLinks.count)")
            links = loadedLinks

        case let .failure(error):
            print("Error fetching: \(error)")
        }

        for link in links {
            guard let term = termMap[link.termKey],
                  let morpheme = morphemeMap[link.morphemeKey] else { continue }
            term.addToMorphemes(morpheme)
        }
    }

    private func makeTermLearningStatus() {
        for glossary in glossaryMap.values {
            for term in glossary.termsArray {
                let termLearningStatus = TermLearningStatus(context: context)
                termLearningStatus.id = UUID()
                termLearningStatus.glossaryId = glossary.id
                termLearningStatus.termId = term.id
                termLearningStatus.status = LearningStatus.notStarted.rawValue
            }
        }
    }

    private func loadJsonData<T: Decodable>(_ filename: String) throws -> [T] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
            throw NSError(domain: "File not found: \(filename)", code: 404)
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode([T].self, from: data)
    }
}
