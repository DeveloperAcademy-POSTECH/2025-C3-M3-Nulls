//
//  InitialDataLoader.swift
//  Projects
//
//  Created by 양시준 on 6/1/25.
//

import CoreData

class InitialDataLoader {
    let context: NSManagedObjectContext
    
    var glossaryMap: [String:Glossary] = [:]
    var termMap: [String:Term] = [:]
    var morphemeMap: [String:Morpheme] = [:]
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func loadInitialData() throws {
        try loadGlossaries()
        try loadTerms()
        try loadMorphemes()
        try linkGlossaryToTerm()
        try linkTermToMorpheme()
        
        makeTermLearningMetadata()
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
    
    private func loadTerms() throws {
        let terms: [TermDto] = try loadJsonData("terms.json")
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
    }
    
    private func loadMorphemes() throws {
        let morphemes: [MorphemeDto] = try loadJsonData("morphemes.json")
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
    
    private func linkTermToMorpheme() throws {
        let links: [TermMorphemeLinkDto] = try loadJsonData("term_morpheme_links.json")
        for link in links {
            guard let term = termMap[link.termKey],
                  let morpheme = morphemeMap[link.morphemeKey] else { continue }
            term.addToMorphemes(morpheme)
        }
    }
    
    private func makeTermLearningMetadata() {
        for glossary in glossaryMap.values {
            for term in glossary.termsArray {
                let termLearningMetadata = TermLearningMetadata(context: context)
                termLearningMetadata.id = UUID()
                termLearningMetadata.glossaryId = glossary.id
                termLearningMetadata.termId = term.id
                termLearningMetadata.status = LearningStatus.notStarted.rawValue
                termLearningMetadata.easeFactor = 2.5
                termLearningMetadata.repetitions = 0
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
