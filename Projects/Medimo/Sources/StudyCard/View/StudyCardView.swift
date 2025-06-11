import AVFAudio
import Combine
import CoreData
import SwiftUI

struct StudyCardView: View {
    @AppStorage("selectedGlossaryId") private var selectedGlossaryId: Int = 0

    @Environment(\.managedObjectContext) private var context
    @EnvironmentObject var navigationManager: NavigationManager

    @StateObject private var viewModel = StudyCardViewModel()
    @State private var currentCardIndex: Int? = 0
    @State private var index: Int = 1

    @Binding var isStudyInProgress: Bool

    @State private var showSoundAlert: Bool = false
    @State private var isSoundButtonTapped: Bool = false

    @State private var volumeCancellable: AnyCancellable?

    func colorForPosition(_ position: CardBackgroundModifier.CardPosition) -> Color {
        switch position {
        case .center: return AppColor.white
        case .left: return AppColor.blue
        case .right: return AppColor.skyBlue
        }
    }

    var body: some View {
        ZStack {
            VStack {
                if viewModel.terms.count > 0 {
                    HStack {
                        Capsule()
                            .fill(AppColor.skyBlue)
                            .frame(height: 8)
                            .overlay(
                                GeometryReader { geometry in
                                    Capsule()
                                        .fill(AppColor.blue)
                                        .frame(width: geometry.size.width * CGFloat(index) / CGFloat(viewModel.terms.count), height: 8)
                                }
                                .clipShape(Capsule())
                            )
                            .padding(.trailing, 12)
                        Text("\(String(format: "%02d", index)) / \(viewModel.terms.count)")
                            .font(.caption)
                            .foregroundStyle(AppColor.navy)
                    }
                    .padding(.bottom)
                    .padding(.horizontal, 36)
                    .padding(.top)

                    ScrollView(.horizontal) {
                        LazyHStack(spacing: 10) {
                            ForEach(Array(viewModel.terms.enumerated()), id: \.offset) { idx, term in
                                let position = viewModel.cardPosition(for: idx, currentIndex: currentCardIndex)
                                let color = colorForPosition(position)
                                TermCardView(
                                    term: term,
                                    showSoundAlert: $showSoundAlert,
                                    isSoundButtonTapped: $isSoundButtonTapped,
                                    backgroundColor: color
                                )
                                .modifier(CardBackgroundModifier(position: position))
                                .id(idx)
                                .animation(.easeInOut(duration: 0.15), value: currentCardIndex)
                                .frame(width: UIScreen.main.bounds.width - 64)
                                .scrollTransition { content, phase in
                                    content.scaleEffect(y: phase.isIdentity ? 1 : 0.85)
                                }
                            }
                            Color.clear.frame(width: 30)
                        }
                        .padding(.leading, 35)
                        .scrollTargetLayout()
                    }
                    .scrollTargetBehavior(.viewAligned)
                    .scrollIndicators(.hidden)
                    .scrollPosition(id: $currentCardIndex, anchor: .center)

                    Spacer()

                    Button("용어 테스트 시작") {
                        navigationManager.studyPath.append(.StudyTest(terms: viewModel.terms))
                    }
                    .font(.body)
                    .frame(width: 262, height: 40)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 20)
                    .background(AppColor.primary)
                    .foregroundStyle(AppColor.systemBackground)
                    .cornerRadius(16)
                    .shadow(radius: 3)
                    .opacity(index == viewModel.terms.count ? 1 : 0)
                } else {
                    Text("학습할 용어가 없습니다.")
                        .font(.caption)
                        .foregroundStyle(AppColor.grey1)
                }
                Spacer()
            }

            if showSoundAlert && isSoundButtonTapped {
                VStack {
                    Spacer()
                    SoundAlert()
                        .padding(.bottom, 40)
                        .padding(.horizontal, 35)
                }
            }
        }
        .padding(.bottom, 20)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    isStudyInProgress = false
                    navigationManager.studyPath = []
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(AppColor.blue)
                }
            }
        }
        .onAppear {
            viewModel.loadTerms(with: context, existGlossaryId: selectedGlossaryId)
            index = viewModel.terms.isEmpty ? 0 : 1
            currentCardIndex = 0
            
            let session = AVAudioSession.sharedInstance()
            try? session.setActive(true)

            volumeCancellable = Timer.publish(every: 0.5, on: .main, in: .common)
                .autoconnect()
                .sink { _ in
                    let volume = session.outputVolume
                    if volume >= 0.05 {
                        if showSoundAlert {
                            showSoundAlert = false
                        }
                    }
                }
        }
        .onDisappear {
            volumeCancellable?.cancel()
        }
        .onChange(of: currentCardIndex) { if let newIndex = currentCardIndex { index = newIndex + 1 } }
        .onChange(of: index) {
            if index > viewModel.terms.count { index = viewModel.terms.count }
            else if index < 1 { index = 1 }
        }
    }
}
