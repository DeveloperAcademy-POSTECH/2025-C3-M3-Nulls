//
//  FlashCard.swift
//  Projects
//
//  Created by 이서현 on 6/1/25


import SwiftUI

struct TermCardView: View {
    @ObservedObject var term: Term
    
    @State private var isPlaying = false
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
                        
                        // TODO: 1초가 아니라 사운드 재생 시간만큼 재생 이미지 띄우기
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isPlaying = false
                        }
                    }) {
                        Image(systemName: isPlaying ? "speaker.wave.2.fill" : "speaker.fill")
                            .imageScale(.large)
                            .font(.system(size: 24))
                            .foregroundColor(Color("MM_Navy"))
                    }
                    .onTapGesture {
                        isPlaying.toggle()
                    }

                    Spacer()
                    
                    Button(action: {
                        term.isBookmarked.toggle()
                    }) {
                        Image(systemName: term.isBookmarked ? "bookmark.fill" :"bookmark")
                            .imageScale(.large)
                            .font(.system(size: 20))
                            .foregroundColor(Color("MM_Navy"))
                    }
                }
                .padding(20)

                VStack(alignment: .leading) {
                    Text((isFlipped ? term.meaning : term.spelling) ?? "")
                        .font(isFlipped ? .MM_H2 : .MM_EH2)
                    
                    if !isFlipped, term.abbreviation != nil {
                        Text("[\(String(term.abbreviation!))]")
                            .font(.MM_EH3)
                            .padding(.vertical)
                    }
                }
                .foregroundColor(Color("MM_Text"))
                .padding(20)
                .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()
                
                VStack(alignment: .leading) {
                    if isFlipped {
                        Text(term.explanation ?? "")
                    } else {
                        if let morphemes = term.morphemes as? Set<Morpheme> {
                            let morphemeArray = morphemes.sorted { ($0.spelling ?? "") < ($1.spelling ?? "") }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                ForEach(morphemeArray, id: \.self) { morpheme in
                                    Text("\(morpheme.spelling ?? "") \(morpheme.meaning ?? "")")
                                }
                            }
                        }
                    }
                }
                .font(.MM_AT)
                .foregroundColor(Color("MM_Grey4"))
                .padding(.horizontal, 20)
                .padding(.vertical, 40)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(28)
        }
        .frame(height: 480)
        .onTapGesture {
            isFlipped.toggle()
        }
    }
}

#Preview {
    var context = PersistenceController.preview.container.viewContext
    var term = Term(context: context)
    
    let morpheme1 = Morpheme(context: context)
    morpheme1.spelling = "neur"
    morpheme1.meaning = "신경"
    
    let morpheme2 = Morpheme(context: context)
    morpheme2.spelling = "itis"
    morpheme2.meaning = "~의 염증"
    
    term = Term(context: context)
    term.spelling = "Neuritis"
    term.abbreviation = "NT"
    term.meaning = "신경의 염증"
    term.morphemes = NSSet(array: [morpheme1, morpheme2])
    term.explanation = """
    Neuritis는 신경에 염증이 생긴 상태를 의미합니다.
    이로 인해 통증, 감각 저하, 근육 약화 등의 증상이 나타날 수 있습니다.
    주로 감염, 외상 또는 자가면역 반응으로 인해 발생합니다.
    """
    
    return TermCardView(term: term)
        .environment(\.managedObjectContext, context)
}
