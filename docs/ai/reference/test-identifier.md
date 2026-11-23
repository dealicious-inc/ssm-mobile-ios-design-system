# Test Identifier

## 목적

이 문서는 `ssm-mobile-ios-design-system` 컴포넌트에 E2E 테스트(Marionette, Appium XCUITest)용 `accessibilityIdentifier`와 상태 trait를 더할 때 따르는 공용 reference다.
이름 규칙의 정본은 앱 레포 `ssm-mobile-ios`의 `docs/ai/reference/ui-test-conventions.md`와 marionette-e2e `docs/identifier-naming.md`다. 이 문서는 DS 안에서 지킬 것만 적는다.

## 원칙

- DS는 식별자 하나를 받아 안쪽 요소까지 붙인다. 화면 이름을 DS 안에 박지 않는다.
- 안쪽 요소 이름은 `<받은 식별자>__<표준 요소 이름>`이다(`__title_text`, `__message_text`, `__action_button`, `__input`, `__clear_button`).
- 수량 스테퍼처럼 요소가 여러 개인 복합 컨트롤은 단계를 늘리지 않고 `_` 하나로 붙인다(`_minus_button`, `_input`, `_plus_button`).
- 받은 식별자가 `nil`이면 안쪽 요소도 `nil`로 되돌린다. 식별자를 넘기지 않은 화면의 접근성 트리는 변경 전과 같아야 한다.
- 식별자를 한 번도 받지 않았으면 DS는 아무것도 하지 않는다. 앱이 안쪽 요소(버튼, `contentView`)에 직접 넣은 값을 지우지 않기 위해서다.
- 선택·체크·비활성 상태는 이름이 아니라 `accessibilityTraits`로 드러낸다(`.selected`, `.notEnabled`). `accessibilityValue`에 넣지 않는다(VoiceOver가 읽는다).
- 상태 trait는 식별자가 붙는 노드(바깥 뷰·셀)에 붙인다. DS 내부 helper `UIView.setAccessibilityTrait(_:isOn:)`(internal, 앱에 노출하지 않음)로 넣고 뺀다. SwiftUI는 `.accessibilityAddTraits(.isSelected)`를 조건부로 붙인다.
- 스위치 켜짐도 `.selected`로 드러낸다. VoiceOver는 "선택됨"으로 읽는다.
- `accessibilityLabel`, `isAccessibilityElement`는 덮어쓰지 않는다.
- `#if DEBUG` 안에 두지 않는다. QA 빌드도 Release 구성이다.
- 식별자 문자열을 검사하거나 assert하지 않는다. 단계 수(최대 4단계)는 넘기는 쪽(앱 PR 리뷰)이 지킨다.
- private 멤버를 열지 않는다. 컨테이너의 `accessibilityIdentifier` didSet, VC의 `testIdentifier` 프로퍼티, 아이템 모델의 `testIdentifier`, SwiftUI 환경값 중 하나로 전달한다.

## 구현 패턴

- 컨테이너 뷰: `accessibilityIdentifier`를 override 해 didSet에서 자식에게 내린다(`DealiEmptyView`, `DealiCountStepper`, `DealiSearchInput`).
- 셀이 컨테이너를 감싸는 경우: 셀 didSet에서 안쪽 뷰의 자식에게만 내리고, 안쪽 뷰 자체에 같은 이름을 다시 붙이지 않는다(`DealiEmptyCollectionViewCell`, `DealiEmptyTableViewCell`).
- 재사용 셀로 그리는 컴포넌트: 아이템 모델이 식별자를 들고(`DealiTabBarItemProtocol.testIdentifier`) `cellForItemAt`에서 셀에 붙인다. `prepareForReuse`에서 식별자와 상태 trait를 초기화한다(`DealiTabBarView`, `DealiTabBarItemBaseCell`).
- 상태만 드러내는 컴포넌트: 외관을 갱신하는 한 곳에서 trait를 같이 갱신한다(`DealiCheckbox.setAppearance(for:)`, `DealiCheckcircle`·`DealiRadioButton`의 `setupView()`).
- 바깥 뷰가 안쪽 컨트롤을 감싸는 `WithText` 컴포넌트: 바깥 뷰의 `isSelected`·`isEnabled` setter와 init 끝에서 바깥 뷰에 trait를 넣는다. 안쪽 컨트롤의 `isAccessibilityElement`는 바꾸지 않는다(`DealiCheckcircleWithText`, `DealiChecklineWithText`).
- VC로 띄우는 컴포넌트: VC에 `public var testIdentifier: String?`를 두고 didSet에서 안쪽에 내린다. 정적 `show` 계열 함수는 같은 이름의 인자(기본값 `nil`)를 받아 VC에 넘긴다. 루트 노드는 앱이 지금 붙이는 노드와 같게 둔다(`DealiAlertViewController`는 `view`, `DealiBottomSheetBaseViewController`는 `contentView`).
  - `loadView`의 지역 변수였던 요소는 private 저장 프로퍼티로 잡는다. `present` 뒤에 넣은 루트도 붙어야 한다.
  - `loadView` 끝에서 한 번 더 내린다. 그 안에서 다시 만드는 요소(시스템 시트 취소 버튼)가 있다.
  - 같은 모듈의 하위 VC는 internal 훅 `applyTestIdentifiers()`를 override 해서 자기 요소를 더한다. 앱 하위 클래스에는 훅을 열지 않는다.
- 데이터 모델로 항목을 그리는 VC: 항목 모델에 `testIdentifier`를 두고, 값이 없으면 `<루트>__item`을 붙인다(`DealiBottomSheetOptionData`). 항목 모델을 다시 만드는 코드는 `testIdentifier`를 옮긴다.
- SwiftUI 컴포넌트: 앱은 `.dealiTestIdentifier(_:)`로 루트를 넘기고, 컴포넌트는 `@Environment(\.dealiTestIdentifier)`로 읽는다. 루트에는 `dealiTestContainer(_:)`, 안쪽 요소에는 `dealiTestIdentifier(_:suffix:)`를 쓴다(둘 다 internal).
  - 루트가 `nil`이면 `.accessibilityElement(children: .contain)`도 붙이지 않는다. 넘기지 않은 화면의 트리가 그대로여야 한다.
  - 앱이 넣는 콘텐츠 자리(`DealiSheetView`의 `content`)에는 `dealiTestIdentifierBoundary()`로 루트를 끊는다. 끊지 않으면 안쪽 DS 컴포넌트가 바깥 루트로 이름을 또 붙인다.
  - SwiftUI `Button` label 안의 요소에는 식별자를 붙이지 않는다. `Button`이 label 자식을 요소 하나로 합쳐 트리에 남지 않는다. `DropdownView`는 `__select_button`만 붙이고, 고른 값은 그 버튼의 label로 읽는다. UIKit `DealiDropdown`의 `__value_text`(`UILabel`)는 그대로다.
  - 탭처럼 항목마다 이름이 다른 경우는 환경값 대신 항목 모델의 `testIdentifier` 전체 문자열을 쓴다(`TabBarItemViewModel`, `DealiImageChipTabBarItem`).

## 붙이기 전에 볼 것

- Appium `~` 셀렉터는 identifier를 먼저 보고 없을 때만 label을 본다. 이미지 이름 label(`~ic search`, `~ic plus`)로 찾던 요소에 식별자를 붙이면 그 셀렉터가 0건이 된다. 새 요소에 붙일 때는 marionette-e2e `test-code/app/pages/*.ios.ts`에서 그 요소를 무엇으로 찾는지 확인하고 PR 본문에 적는다.
- 새 식별자 API를 더하면 샘플앱의 해당 화면에 예시 값을 붙이고, `Tests/DealiDesignKitTests`에 nil/non-nil 양쪽 테스트를 둔다.

## 금지

- 이 문서에 앱 화면 이름이나 식별자 목록을 두지 않는다. 값은 앱 PR과 QA 사이트맵이 가진다.
