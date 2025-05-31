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
    }
    
    private func loadGlossaries() throws {
        let glossaries: [GlossaryDto] = try loadJson("glossaries.json")
        for g in glossaries {
            let glossary = Glossary(context: context)
            glossary.id = UUID()
            glossary.glossaryKey = g.glossaryKey
            glossary.title = g.title
            glossaryMap[g.glossaryKey] = glossary
        }
    }
    
    private func loadTerms() throws {
        let terms: [TermDto] = try loadJson("terms.json")
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
        let morphemes: [MorphemeDto] = try loadJson("morphemes.json")
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
        let links: [GlossaryTermLinkDto] = try loadJson("glossary_term_links.json")
        for link in links {
            guard let glossary = glossaryMap[link.glossaryKey],
                  let term = termMap[link.termKey] else { continue }
            
            glossary.addToTerms(term)
            term.addToGlossaries(glossary)
        }
    }
    
    private func linkTermToMorpheme() throws {
        let links: [TermMorphemeLinkDto] = try loadJson("term_morpheme_links.json")
        for link in links {
            guard let term = termMap[link.termKey],
                  let morpheme = morphemeMap[link.morphemeKey] else { continue }
            term.addToMorphemes(morpheme)
        }
    }
    
    private func loadJson<T: Decodable>(_ filename: String) throws -> [T] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
            throw NSError(domain: "File not found: \(filename)", code: 404)
        }
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode([T].self, from: data)
    }
}
