//
//  FlashCard.swift
//  Projects
//
//  Created by 이서현 on 6/1/25


import SwiftUI

struct CardView: View {
    let term: Term

    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.2), radius: 5)

            VStack(spacing: 8) {
                HStack {
                    Image(systemName: "speaker.fill")
                        .resizable()
                        .frame(width: 18, height: 28)
                        .foregroundColor(.indigo)

                    Spacer()

                    Image(systemName: "bookmark")
                        .resizable()
                        .frame(width: 18, height: 28)
                        .foregroundColor(.indigo)
                }

                Spacer()

                Text(term.spelling ?? "")
                    .font(.title3)
                    .fontWeight(.bold)

                Text(term.abbreviation ?? "")
                    .font(.caption)
                    .fontWeight(.medium)

                Spacer()
            }
            .padding(24)
        }
        .frame(width: 300, height: 180)
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let glossary = try! context.fetch(Glossary.fetchRequest())[0]
    
    let term = (glossary.terms?.allObjects as? [Term])?.first ?? Term()

    CardView(term: term)
}
