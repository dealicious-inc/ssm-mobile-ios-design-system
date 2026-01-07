import SwiftUI

// MARK: - DropdownViewModel
public final class DropdownViewModel: ObservableObject {
    
    // MARK: - Enums

    /// Dropdown 상태
    public enum Status {
        case `default`
        case disabled
    }

    /// 화살표 아이콘 타입
    public enum ArrowType {
        case open
        case right
    }

    /// 크기 타입
    public enum SizeType {
        /* dropdown46
        ┌───────────────────────────────────────────────────┐
        │                     ↑13                           │
        │ ←16→ [아이콘] ←4→ [텍스트] ←16→ [화살표 (size20)] ←12→ │
        │                     ↓13                           │
        └───────────────────────────────────────────────────┘
        */
        case dropdown46  // 일반 (좌16/우12, 아이콘-텍스트 4, 텍스트-화살표 16, 상하 13, 화살표사이즈20)
        
        /* dropdown32
        ┌──────────────────────────────────────────────────┐
        │                     ↑7                           │
        │ ←12→ [아이콘] ←4→ [텍스트] ←12→ [화살표 (size18)] ←8→ │
        │                     ↓7                           │
        └──────────────────────────────────────────────────┘
        */
        case dropdown32   // 숫자 (좌16/우12, 아이콘-텍스트 0, 텍스트-화살표 12, 상하 5, 좌측 아이콘 숨김, 화살표사이즈18)
    }
    
    // MARK: - Published Properties (For View Rendering)

    /// 현재 상태
    @Published public var status: Status

    /// 제목 텍스트
    @Published public var title: String?

    /// 필수 항목 여부 (true일 경우 빨간 점 표시)
    @Published public var isMandatory: Bool

    /// 콘텐츠 텍스트 (nil/empty일 경우 플레이스홀더 스타일)
    @Published public var contentText: String?

    /// contentText lineLimit
    @Published public var contentTextLineLimit: Int?

    /// 도움말 텍스트
    @Published public var helperText: String?

    /// 좌측 아이콘
    @Published public var icon: Image?

    /// 화살표 아이콘 타입
    @Published public var arrowType: ArrowType

    /// 펼쳐진 상태 여부 (.open 타입에서 화살표 회전 애니메이션 사용)
    @Published public var isSelecting: Bool = false

    /// 크기 타입
    public var sizeType: SizeType

    // MARK: - Action

    /// 탭 이벤트 핸들러
    public var onTapped: () -> Void
    
    // MARK: - Initializer
    
    public init(
        status: Status = .default,
        title: String? = nil,
        isMandatory: Bool = false,
        contentText: String? = nil,
        contentTextLineLimit: Int? = nil,
        helperText: String? = nil,
        icon: Image? = nil,
        arrowType: ArrowType = .right,
        sizeType: SizeType = .dropdown46,
        onTapped: @escaping () -> Void = {}
    ) {
        self.status = status
        self.title = title
        self.isMandatory = isMandatory
        self.contentText = contentText
        self.contentTextLineLimit = contentTextLineLimit
        self.helperText = helperText
        self.icon = icon
        self.arrowType = arrowType
        self.sizeType = sizeType
        self.onTapped = onTapped
    }
    
    // MARK: - Internal Methods

    /// 탭 제스처 처리
    func handleTap() {
        guard self.status != .disabled else { return }

        if self.arrowType == .open {
            self.isSelecting.toggle()
        }

        self.onTapped()
    }
}

// MARK: - Style Properties (Computed)
extension DropdownViewModel {

    /// 배경색
    var backgroundColor: Color {
        switch self.status {
        case .default:
            return Color.primary04
        case .disabled:
            return Color.g10
        }
    }

    /// 콘텐츠 텍스트 색상
    var contentTextColor: Color {
        let hasContent = self.contentText != nil && !self.contentText!.isEmpty

        switch self.status {
        case .default:
            return hasContent ? Color.g100 : Color.g50
        case .disabled:
            return Color.g50
        }
    }
    
    var contentTextFont: Font {
        switch self.sizeType {
        case .dropdown46:
            return .b2r14
        case .dropdown32:
            return .b3r13
        }
    }

    /// 화살표 색상
    var arrowIconColor: Color {
        switch self.status {
        case .default:
            return Color.g100
        case .disabled:
            return Color.g50
        }
    }

    /// 화살표 아이콘
    var arrowIcon: Image {
        switch self.arrowType {
        case .open:
            return DealiIcon.ic_arrow_open.swiftUIImage
        case .right:
            return DealiIcon.ic_arrow_right.swiftUIImage
        }
    }
    
    var arrowIconSize: CGFloat {
        switch self.sizeType {
        case .dropdown46:
            return 20.0
        case .dropdown32:
            return 18.0
        }
    }

    /// 아이콘-텍스트 간격
    var iconTextSpacing: CGFloat {
        switch self.sizeType {
        case .dropdown46:
            return 4.0
        case .dropdown32:
            return 0.0
        }
    }

    /// 텍스트-화살표 간격
    var textArrowSpacing: CGFloat {
        switch self.sizeType {
        case .dropdown46:
            return 16.0
        case .dropdown32:
            return 12.0
        }
    }
    
    /// 텍스트-화살표 간격
    var leftPadding: CGFloat {
        switch self.sizeType {
        case .dropdown46:
            return 16.0
        case .dropdown32:
            return 12.0
        }
    }
    
    var rightPadding: CGFloat {
        switch self.sizeType {
        case .dropdown46:
            return 12.0
        case .dropdown32:
            return 8.0
        }
    }

    /// 수직 패딩
    var contentVerticalPadding: CGFloat {
        switch self.sizeType {
        case .dropdown46:
            return 13.0
        case .dropdown32:
            return 7.0
        }
    }

    /// 아이콘 표시 여부
    var shouldShowIcon: Bool {
        return self.sizeType == .dropdown46 && self.icon != nil
    }
}


// MARK: - DropdownView
public struct DropdownView: View {
    
    @ObservedObject public var viewModel: DropdownViewModel
    @State private var rotationAngle: Angle = .zero

    public init(viewModel: DropdownViewModel) {
        self.viewModel = viewModel
    }
    
    @ViewBuilder
    private var titleText: some View {
        if let title = viewModel.title, !title.isEmpty {
            let attStr = AttributedString(title)
                .setFont(viewModel.contentTextFont)
                .setColor(.g100)
            
            HStack(spacing: 4.0) {
                Text(attStr)
                    .setLineHeight(attributedString: attStr)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)

                if viewModel.isMandatory {
                    Circle()
                        .fill(Color.primary01)
                        .frame(width: 5.0, height: 5.0)
                        .offset(y: -2.0)
                }
            }
        }
    }
    
    @ViewBuilder
    private var dropdownContainer: some View {
        Button(action: viewModel.handleTap) {
            HStack(alignment: .top, spacing: 0.0) {
                if viewModel.shouldShowIcon, let icon = viewModel.icon {
                    icon
                        .resizable()
                        .frame(width: 16.0, height: 16.0)
                        .padding(.top, 2.0)
                        .padding(.trailing, viewModel.iconTextSpacing)
                }

                let attStr = AttributedString(viewModel.contentText ?? "")
                    .setFont(.b2r14)
                    .setColor(viewModel.contentTextColor)

                Text(attStr)
                    .setLineHeight(attributedString: attStr)
                    .multilineTextAlignment(.leading)
                    .lineLimit(viewModel.contentTextLineLimit ?? 1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.trailing, viewModel.textArrowSpacing)

                viewModel.arrowIcon
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: viewModel.arrowIconSize, height: viewModel.arrowIconSize)
                    .foregroundColor(viewModel.arrowIconColor)
                    .rotationEffect(rotationAngle)
                    .padding(.top, 2.0)
            }
            .padding(.leading, viewModel.leftPadding)
            .padding(.trailing, viewModel.rightPadding)
            .padding(.vertical, viewModel.contentVerticalPadding)
            .background(viewModel.backgroundColor)
            .cornerRadius(6.0)
            .overlay(
                RoundedRectangle(cornerRadius: 6.0)
                    .stroke(Color.g20, lineWidth: 1.0)
            )
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(viewModel.status == .disabled)
    }
    
    @ViewBuilder
    private var helperText: some View {
        if let helperText = viewModel.helperText, !helperText.isEmpty {
            let attStr = AttributedString(helperText)
                .setFont(.b4r12)
                .setColor(.g70)

            Text(attStr)
                .setLineHeight(attributedString: attStr)
                .multilineTextAlignment(.leading)
        }
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 4.0) {
            self.titleText
            self.dropdownContainer
            self.helperText
        }
        .frame(maxWidth: .infinity)
        .onChange(of: viewModel.isSelecting) { _ in
            guard viewModel.arrowType == .open else { return }
            withAnimation(.easeInOut(duration: 0.3)) {
                rotationAngle = Angle(degrees: rotationAngle.degrees + 180.0)
            }
        }
    }
}

#if DEBUG
struct DropdownView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20.0) {
            // Default 상태
            DropdownView(viewModel: DropdownViewModel(
                title: "기본 드롭다운",
                isMandatory: true,
                contentText: "옵션 선택",
                helperText: "도움말 텍스트입니다.",
                icon: DealiIcon.ic_check.swiftUIImage,
                arrowType: .right,
                onTapped: { print("기본 드롭다운 탭됨") }
            ))
            .frame(maxWidth: .infinity)
            
            // ContentText가 있는 Default 상태
            DropdownView(viewModel: DropdownViewModel(
                title: "선택된 값",
                contentText: "선택된 옵션입니다.",
                icon: Image(systemName: "heart.fill"),
                arrowType: .open,
                onTapped: { print("선택된 값 드롭다운 탭됨") }
            ))
            .frame(maxWidth: .infinity)

            // Disabled 상태
            DropdownView(viewModel: DropdownViewModel(
                status: .disabled,
                title: "비활성화 드롭다운",
                contentText: "비활성화됨",
                helperText: "비활성화된 상태입니다.",
                onTapped: { print("비활성화 드롭다운 탭됨 (실행 안됨)") }
            ))
            .frame(maxWidth: .infinity)

            // 아이콘 없는 상태
            DropdownView(viewModel: DropdownViewModel(
                title: "아이콘 없음",
                contentText: "아이콘이 없습니다.",
                onTapped: { print("아이콘 없는 드롭다운 탭됨") }
            ))
            .frame(maxWidth: .infinity)

            // 제목 없는 상태
            DropdownView(viewModel: DropdownViewModel(
                contentText: "제목이 없습니다.",
                onTapped: { print("제목 없는 드롭다운 탭됨") }
            ))
            .frame(maxWidth: .infinity)

            // 긴 텍스트와 lineLimit 테스트
            DropdownView(viewModel: DropdownViewModel(
                title: "긴 텍스트",
                contentText: "이것은 매우 긴 텍스트입니다. 여러 줄에 걸쳐 표시되어야 하며, lineLimit에 의해 잘려야 합니다. 이것은 매우 긴 텍스트입니다. 여러 줄에 걸쳐 표시되어야 하며, lineLimit에 의해 잘려야 합니다.".byCharWrapping,
                contentTextLineLimit: 2,
                icon: DealiIcon.ic_check.swiftUIImage,
                onTapped: { print("긴 텍스트 드롭다운 탭됨") }
            ))
            .frame(maxWidth: .infinity)

            // Numeric 타입 (숫자 드롭다운)
            DropdownView(viewModel: DropdownViewModel(
                contentText: "33",
                sizeType: .dropdown32,
                onTapped: { print("숫자 드롭다운 탭됨") }
            ))
            .frame(width: 82.0)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
