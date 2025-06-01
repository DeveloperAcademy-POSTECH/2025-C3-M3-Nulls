import SwiftUI

// ContentView.swift
struct ContentView: View {
    @Environment(\.managedObjectContext) var context

    var body: some View {
        let request = Glossary.fetchRequest()
        let glossary = (try? context.fetch(request).first) ?? Glossary(context: context)

        StudyCardView(glossary: glossary)
    }
}
