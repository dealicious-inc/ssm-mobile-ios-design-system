# Test Identifier

## 목적

이 문서는 `ssm-mobile-ios-design-system` 컴포넌트에 E2E 테스트(Marionette, Appium XCUITest)용 `accessibilityIdentifier`와 상태 trait를 더할 때 따르는 공용 reference다.
이름 규칙의 정본은 앱 레포 `ssm-mobile-ios`의 `docs/ai/reference/ui-test-conventions.md`와 marionette-e2e `docs/identifier-naming.md`다. 이 문서는 DS 안에서 지킬 것만 적는다.

## 원칙

- DS는 식별자 하나를 받아 안쪽 요소까지 붙인다. 화면 이름을 DS 안에 박지 않는다.
- 안쪽 요소 이름은 `<받은 식별자>__<표준 요소 이름>`이다(`__title_text`, `__message_text`, `__action_button`, `__input`, `__clear_button`).
- 수량 스테퍼처럼 요소가 여러 개인 복합 컨트롤은 단계를 늘리지 않고 `_` 하나로 붙인다(`_minus_button`, `_input`, `_plus_button`).
- 받은 식별자가 `nil`이면 안쪽 요소도 `nil`로 되돌린다. 식별자를 넘기지 않은 화면의 접근성 트리는 변경 전과 같아야 한다.
- 선택·체크·비활성 상태는 이름이 아니라 `accessibilityTraits`로 드러낸다(`.selected`, `.notEnabled`). `accessibilityValue`에 넣지 않는다(VoiceOver가 읽는다).
- 상태 trait는 식별자가 붙는 노드(바깥 뷰·셀)에 붙인다. DS 내부 helper `UIView.setAccessibilityTrait(_:isOn:)`(internal, 앱에 노출하지 않음)로 넣고 뺀다.
- `accessibilityLabel`, `isAccessibilityElement`는 덮어쓰지 않는다.
- `#if DEBUG` 안에 두지 않는다. QA 빌드도 Release 구성이다.
- 식별자 문자열을 검사하거나 assert하지 않는다. 단계 수(최대 4단계)는 넘기는 쪽(앱 PR 리뷰)이 지킨다.
- private 멤버를 열지 않는다. 컨테이너의 `accessibilityIdentifier` didSet 또는 아이템 모델의 `testIdentifier`로 전달한다.

## 구현 패턴

- 컨테이너 뷰: `accessibilityIdentifier`를 override 해 didSet에서 자식에게 내린다(`DealiEmptyView`, `DealiCountStepper`, `DealiSearchInput`).
- 셀이 컨테이너를 감싸는 경우: 셀 didSet에서 안쪽 뷰의 자식에게만 내리고, 안쪽 뷰 자체에 같은 이름을 다시 붙이지 않는다(`DealiEmptyCollectionViewCell`, `DealiEmptyTableViewCell`).
- 재사용 셀로 그리는 컴포넌트: 아이템 모델이 식별자를 들고(`DealiTabBarItemProtocol.testIdentifier`) `cellForItemAt`에서 셀에 붙인다. `prepareForReuse`에서 식별자와 상태 trait를 초기화한다(`DealiTabBarView`, `DealiTabBarItemBaseCell`).
- 상태만 드러내는 컴포넌트: 외관을 갱신하는 한 곳에서 trait를 같이 갱신한다(`DealiCheckbox.setAppearance(for:)`).

## 붙이기 전에 볼 것

- Appium `~` 셀렉터는 identifier를 먼저 보고 없을 때만 label을 본다. 이미지 이름 label(`~ic search`, `~ic plus`)로 찾던 요소에 식별자를 붙이면 그 셀렉터가 0건이 된다. 새 요소에 붙일 때는 marionette-e2e `test-code/app/pages/*.ios.ts`에서 그 요소를 무엇으로 찾는지 확인하고 PR 본문에 적는다.
- 새 식별자 API를 더하면 샘플앱의 해당 화면에 예시 값을 붙이고, `Tests/DealiDesignKitTests`에 nil/non-nil 양쪽 테스트를 둔다.

## 금지

- 이 문서에 앱 화면 이름이나 식별자 목록을 두지 않는다. 값은 앱 PR과 QA 사이트맵이 가진다.
