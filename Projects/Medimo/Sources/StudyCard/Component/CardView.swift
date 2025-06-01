//
//  FlashCard.swift
//  Projects
//
//  Created by 이서현 on 6/1/25


import SwiftUI

struct CardView: View {
    let term: Term
    
    @State private var isPlaying = false
    @State private var isBookmarked = false
    @State private var isFlipped = false


    var body: some View {
        ZStack(alignment: .topTrailing) {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.2), radius: 5)

            VStack(spacing: 8) {
                HStack {
                    Button(action: {
                    isPlaying.toggle()
                    }) {
                        Image(systemName: isPlaying ? "speaker.wave.2.fill" : "speaker.fill")
                            .imageScale(.large)
                            .font(.system(size: 24))
                            .foregroundColor(Color("Navy"))
                    }
                    .onTapGesture {
                        isPlaying.toggle()
                        
                    }

                    Spacer()
                    
                    Button(action: {
                        isBookmarked.toggle()
                    }) {
                        Image(systemName: isBookmarked ? "bookmark.fill" :"bookmark")
                            .imageScale(.large)
                            .font(.system(size: 20))
                            .foregroundColor(Color("Navy"))
                    }
                    .onTapGesture {
                        isBookmarked.toggle()
                    }
                }

                Spacer()

                if isFlipped {
                    Text(term.spelling ?? "")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text(term.abbreviation ?? "")
                        .font(.caption)
                        .fontWeight(.medium)
                } else {
                    Text(term.meaning ?? "")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Navy"))
                }

                Spacer()
            }
            .padding(24)
        }
        .frame(width: 300, height: 180)
        .onTapGesture {
            isFlipped.toggle()
        }
    }
}

#Preview {
    let context = PersistenceController.preview.container.viewContext
    let glossary = try! context.fetch(Glossary.fetchRequest())[0]
    
    let term = (glossary.terms?.allObjects as? [Term])?.first ?? Term()

    CardView(term: term)
}
