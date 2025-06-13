//
//  GlossaryFilterToggle.swift
//  Projects
//
//  Created by Ell Han on 6/5/25.
//


import SwiftUI

struct GlossaryFilterToggle: View {
    @Binding var selectedFilter: TermStudyFilter
    @Namespace private var animation

    var body: some View {
        HStack(spacing: 0) {
            ForEach(TermStudyFilter.allCases, id: \.self) { type in
                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        selectedFilter = type
                    }
                } label: {
                    if selectedFilter == type {
                        Text(type.rawValue)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(AppColor.white)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(AppColor.systemFill)
                                    .matchedGeometryEffect(id: "toggleBackground", in: animation)
                                    .shadow(color: .black.opacity(0.04), radius: 0.5, x: 0, y: 3)
                                    .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 3)
                            )
                    } else {
                        Text(type.rawValue)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(AppColor.label)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(Color.clear)
                            )
                    }
                }
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 9)
                .fill(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(AppColor.systemFill, lineWidth: 1)
                )
        )
      
    }
}

#Preview {
    PreviewWrapperForGlossaryFilterToggle(TermStudyFilter.learned) { binding in
        GlossaryFilterToggle(selectedFilter: binding)
            .padding()
    }
}

struct PreviewWrapperForGlossaryFilterToggle<Value>: View {
    @State private var value: Value
    var content: (Binding<Value>) -> AnyView

    init(_ initialValue: Value, content: @escaping (Binding<Value>) -> some View) {
        _value = State(initialValue: initialValue)
        self.content = { AnyView(content($0)) }
    }

    var body: some View {
        content($value)
    }
}
