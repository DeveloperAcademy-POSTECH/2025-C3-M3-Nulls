//
//  GlossaryFilterToggle.swift
//  Projects
//
//  Created by Ell Han on 6/5/25.
//


import SwiftUI

struct GlossaryFilterToggle: View {
    enum FilterType: String, CaseIterable {
        case learned = "학습 완료 단어"
        case notLearned = "학습 미완료 단어"
    }

    @Binding var selectedFilter: FilterType
    @Namespace private var animation

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 9)
                .fill(Color.white)
                .frame(width: 361, height: 40)
                .overlay(
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(AppColor.systemFill, lineWidth: 1)
                )

            HStack(spacing: 0) {
                ForEach(FilterType.allCases, id: \.self) { type in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            selectedFilter = type
                        }
                    }) {
                        ZStack {
                            if selectedFilter == type {
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(AppColor.secondarySystemFill)
                                    .frame(width: 179, height: 40)
                                    .matchedGeometryEffect(id: "toggleBackground", in: animation)
                                    .shadow(color: .black.opacity(0.04), radius: 0.5, x: 0, y: 3)
                                    .shadow(color: .black.opacity(0.12), radius: 4, x: 0, y: 3)
                            }

                            Text(type.rawValue)
                                .font(.caption)
                                .multilineTextAlignment(.center)
                                .foregroundStyle(selectedFilter == type ? .white : Color(AppColor.label))
                                .frame(width: 179, height: 40)
                        }
                    }
                }
            }
        }
      
    }
}

#Preview {
    PreviewWrapperForGlossaryFilterToggle(GlossaryFilterToggle.FilterType.learned) { binding in
        GlossaryFilterToggle(selectedFilter: binding)
            .padding()
            .previewLayout(.sizeThatFits)
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
