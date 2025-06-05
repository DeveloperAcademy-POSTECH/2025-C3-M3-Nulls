//
//  CustomTabBar.swift
//  Medimo
//
//  Created by 김현기 on 6/5/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selected: TabType

    var body: some View {
        VStack {
            Spacer()
            HStack(spacing: 0) {
                ForEach(TabType.allCases, id: \.self) { tab in
                    Spacer()
                    TabBarButton(
                        tab: tab,
                        isSelected: selected == tab
                    ) {
                        withAnimation(.smooth()) {
                            selected = tab
                        }
                    }
                    Spacer()
                }
            }
            .frame(height: 70)
            .background(
                TopRoundedRectangle(radius: 20)
                    .fill(Color.white)
                    .frame(height: 70)
            )
        }
    }
}

struct TabBarButton: View {
    let tab: TabType
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            TabBarButtonContent(tab: tab, isSelected: isSelected)
        }
        .frame(width: 70)
    }
}

struct TabBarButtonContent: View {
    let tab: TabType
    let isSelected: Bool

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                if isSelected {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                    Image(tab.selectedIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                }
                if !isSelected {
                    Image(tab.Icon)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 28,
                               height: 28)
                        .foregroundColor(isSelected
                            ? (tab == .study ? AppColor.pink : AppColor.blue)
                            : AppColor.grey3)
                        .padding(.bottom, 8)
                }
            }
            .padding(.top, isSelected ? -12 : 12)

            Text(tab.title)
                .font(.caption)
                .foregroundStyle(AppColor.label)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.top, isSelected ? -24 : 0)
    }
}

#Preview {
    CustomTabBar(selected: .constant(.glossary))
}
