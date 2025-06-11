//
//  StudyingGloassaryChooseButtonView.swift
//  Projects
//
//  Created by 양시준 on 6/4/25.
//

import CoreData
import SwiftUI

struct StudyingGloassaryChooseButtonView: View {
    @Environment(\.managedObjectContext) var context
    let studyManager = StudyManager.shared
    @State var showPicker = false

    var body: some View {
        Button {
            showPicker.toggle()
        } label: {
            HStack(spacing: 16) {
                Text(studyManager.studyingGlossary?.title ?? "")
                    .font(.title)
                    .foregroundStyle(AppColor.label)
                Image("chevron-down")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
        .sheet(isPresented: $showPicker) {
            StudyGlossarySelectSheetView(context: context, isPresented: $showPicker)
                .presentationDetents([.height(680)])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    let context = CoreDataManager.preview.container.viewContext
    StudyManager.shared.setContext(context, 0)

    return StudyingGloassaryChooseButtonView()
        .environment(\.managedObjectContext, context)
}
