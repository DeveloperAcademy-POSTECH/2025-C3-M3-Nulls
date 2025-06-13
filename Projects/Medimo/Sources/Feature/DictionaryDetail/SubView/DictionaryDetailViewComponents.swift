//
//  DictionarySubView.swift
//  Medimo
//
//  Created by bear on 6/5/25.
//

import CoreData
import SwiftUI

struct BookmarkButtonView: View {
    let user: User
    let term: Term

    @State private var isBookmarked: Bool = false

    var body: some View {
        Button(action: {
            isBookmarked.toggle()
            if isBookmarked {
                user.addToBookmarks(term)
            } else {
                user.removeFromBookmarks(term)
            }
            try? CoreDataManager.shared.context.save()
        }) {
            Image(isBookmarked ? "bookmark.fill" : "bookmark")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .foregroundStyle(AppColor.navy)
        }
        .onAppear {
            isBookmarked = user.bookmarks?.contains(term) ?? false
        }
    }
}

enum DictionaryDetailViewComponents {
    static func soundButton(spelling _: String?, speakAction: @escaping () -> Void) -> some View {
        Button(action: {
            speakAction()
        }) {
            Image(systemName: "speaker.wave.2.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 28, height: 28)
                .foregroundStyle(AppColor.navy)
        }
    }

    static func sectionGlossary(_ glossarys: NSSet?) -> some View {
        Text(
            (glossarys as? Set<Glossary>)?
                .compactMap { $0.title.map { "#\($0)" } }
                .joined(separator: ", ") ?? ""
        )
        .font(.caption)
        .foregroundColor(AppColor.secondary)
        .padding(.top, 16)
        .padding(.leading, 8)
    }

    static func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.caption)
            .foregroundColor(AppColor.tertiaryLabel)
            .padding(.leading, 8)
    }

    static func sectionRectangle() -> some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(AppColor.grey3)
    }

    static func sectionDivider() -> some View {
        LinearGradient(
            gradient: Gradient(colors: [AppColor.blue, AppColor.white]),
            startPoint: .leading,
            endPoint: .trailing
        )
        .frame(height: 1)
    }

    static func meaningSection(_ meaning: String?) -> some View {
        VStack(alignment: .leading) {
            sectionTitle("의미")
            sectionDivider()
            Text(meaning ?? "")
                .font(.body)
                .foregroundColor(AppColor.label)
                .padding(.leading, 8)
                .padding(.top, 2)
        }
        .padding(.horizontal, 32)
        .padding(.top, 24)
    }

    static func morphemeSection(_ morphemes: [Morpheme]) -> some View {
        VStack(alignment: .leading) {
            sectionTitle("어원")
            sectionDivider()
            VStack(alignment: .leading) {
                ForEach(Array(morphemes)) { morpheme in
                    HStack {
                        Text(morpheme.spelling ?? "")
                            .font(.caption)
                            .foregroundColor(AppColor.label)
                        Text("-")
                            .font(.caption)
                            .foregroundColor(AppColor.grey4)
                        Text(morpheme.meaning ?? "")
                            .font(.caption)
                            .foregroundColor(AppColor.label)
                    }
                    .padding(.leading, 8)
                }
            }
            .padding(.top, 2)
        }
        .padding(.horizontal, 32)
        .padding(.top, 24)
    }

    static func explanationSection(_ explanation: String?) -> some View {
        VStack(alignment: .leading) {
            sectionTitle("설명")
            sectionDivider()
            Text(explanation ?? "")
                .font(.caption)
                .foregroundColor(AppColor.label)
                .padding(.leading, 8)
                .padding(.top, 2)
        }
        .padding(.horizontal, 32)
        .padding(.top, 24)
    }

    static func characterImage() -> some View {
        Image("character5")
            .resizable()
            .scaledToFit()
            .frame(width: 180, height: 180)
            .padding(.bottom, -25)
            .padding(.trailing, 15)
            .frame(maxWidth: .infinity, alignment: .center)
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    Group {
        DictionaryDetailViewComponents.soundButton(spelling: "example") {
            print("Speaking")
        }

        DictionaryDetailViewComponents.meaningSection("예시 의미입니다.")
        DictionaryDetailViewComponents.explanationSection("설명 텍스트")
        DictionaryDetailViewComponents.sectionRectangle()
    }
}
