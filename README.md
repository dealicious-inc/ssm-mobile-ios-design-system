# DealiDesignKit

딜리셔스 디자인시스템을 iOS 프로젝트에 적용하기 위한 SwiftPackage 입니다. 
> [모바일 디자인시스템 가이드](https://www.figma.com/file/5WsL9kg8fteVvSDUw4L1s6/%5B%EC%8B%A0%EC%83%81%EB%A7%88%EC%BC%93%5D-M_Design-system-Guide?type=design&node-id=1%3A5&t=n9argT42uUZTYYhE-1) 

## 브랜치 전략
DealiDesignKit 은 `dev`, `release` 브랜치로 나누어 사용합니다.
- `dev`: 디자인 시스템 작업 시 사용하는 브랜치.
- `release`: 디자인 시스템 작업한 부분의 PR 이 완료된 브랜치.
  
디자인 시스템에 추가 및 수정이 필요한 부분은 `dev` 에서 작업하여 `release` 로 PR 을 올립니다.

## 신상마켓 프로젝트에 사용하는 방법
- 프로젝트 진행 중일 시: Package의 **`dev` 브랜치의 최신 커밋을 바라보도록** Swift Package 를 연동합니다.
- 앱스토어 검수 등록 시: **`release` 브랜치의 최신 커밋을 바라보도록** 합니다.


## 개발에 도움이 되는 팁
SwiftPackage 특성상 변경사항을 확인하기 위해서는 커밋을 하고, SwiftPackage 를 사용하는 쪽에서 package update를 한 후 새로 빌드해서 확인하는 과정을 거쳐야 합니다. 따라서 작은 수정사항을 확인하기 위해서도 지나치게 많은 커밋과 업데이트, 빌드가 필요했습니다. 이를 줄이기 위해 `UIView` 를 SwiftUI의 preview 를 사용해 커밋하기 전에 UI 및 간단한 인터렉션을 확인할 수 있도록 하였습니다. 

### 사용 예시 - `CheckboxWithText` 프리뷰
프리뷰 코드
```swift

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct CheckboxPreview: PreviewProvider {
    static var testString = "김수한무거북이와 두루미"
    static var disableState: CheckboxStatus = .disabled

    static var previews: some View {
        VStack(alignment: .leading) {
            Text("체크박스 + 텍스트")
            UIViewPreview {
                let checkboxWithText = CheckboxWithText(title: testString, status: .normal(isSelected: false))
                return checkboxWithText
            }
            .padding(.bottom, 10.0)
            
            UIViewPreview {
                let checkboxWithText = CheckboxWithText()
                checkboxWithText.title = testString
                return checkboxWithText
            }
            .padding(.bottom, 10.0)

            UIViewPreview {
                let checkboxWithText = CheckboxWithText()
                checkboxWithText.title = testString
                checkboxWithText.status = .disabled
                checkboxWithText.font = DealiFont.b1Bold.systemFont

                return checkboxWithText
            }
        }
        .padding(10.0)
        .previewLayout(.sizeThatFits)
    }
}
#endif

```
프리뷰 내용

![스크린샷 2023-07-19 오후 4 55 56](https://github.com/dealicious-inc/ssm-mobile-ios-design-system/assets/72622744/9bb6d1d1-4194-4228-a0df-848aa83b40f1)
