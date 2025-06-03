//
//  StudyTestView.swift
//  Projects
//
//  Created by 이서현 on 6/3/25.
//

import SwiftUI

struct StudyTestView: View {
    var terms: [Term]
    var body: some View {
        List(terms, id: \.self) { term in
            Text(term.spelling ?? "")
        }
    }
}
