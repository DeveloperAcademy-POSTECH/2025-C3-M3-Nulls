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
            HStack(spacing: 0) {
                ForEach(TabType.allCases, id: \.self) { tab in
                    Spacer()
                    TabBarButton(
                        tab: tab,
                        isSelected: selected == tab
                    ) {
                        selected = tab
                    }
                    Spacer()
                }
            }
            .padding(.bottom, 16)
            .background(
                TopRoundedRectangle(radius: 20)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: -12)
            )
            Spacer()
        }
        .animation(.default, value: selected)
        .frame(height: 0)
        .padding(.bottom, 24)
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
                        .frame(width: 28, height: 28)
                        .foregroundColor(isSelected
                            ? (tab == .study ? AppColor.pink : AppColor.blue)
                            : AppColor.grey3)
                        .padding(.bottom, 8)
                }
            }
            .padding(.top, isSelected ? -12 : 0)

            Text(tab.title)
                .font(.caption2)
                .foregroundStyle(AppColor.label)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(.top, isSelected ? -24 : 0)
    }
}

#Preview {
    @Previewable @State var selectedTab: TabType = .study

    ZStack {
        DictionaryView()
            .environmentObject(NavigationManager())

        VStack {
            Spacer()
            CustomTabBar(selected: $selectedTab)
                .padding(.bottom, 16)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}
