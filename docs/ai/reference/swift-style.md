# Swift Style

## 목적

이 문서는 `ssm-mobile-ios-design-system`에서 AI가 Swift 코드를 작성하거나 수정할 때 따르는 공용 스타일 정본이다.

## 파일 헤더 규칙

신규 Swift 파일은 기존 프로젝트 파일 헤더 형식을 따른다.
`Created by` 이름의 기준은 `git config user.name`이다.

기본 형태:

```swift
//
//  FileName.swift
//
//
//  Created by <git config user.name> on <date>.
//
```

규칙:

- `Created by`에는 AI 이름을 넣지 않는다.
- `Created by`에는 `Claude`, `Claude Code`, `Codex`, `Cursor`, `ChatGPT`, `OpenAI`, `AI` 같은 도구/모델 이름을 넣지 않는다.
- `Created by`에는 `git config user.name` 값을 넣는다.
- `git config user.name`을 확인할 수 없으면 Swift 파일 생성 전에 사용자에게 확인한다.
- 기존 파일을 수정할 때는 기존 파일 헤더를 임의로 바꾸지 않는다.

## 설명 주석 규칙

신규 Swift 파일에는 설명 주석이 반드시 있어야 한다.

```swift
/**
 설명: 역할이나 목적을 한 줄로 설명
 */
final class SomeView: UIView { }
```

규칙:

- 블록 주석 `/** ... */`을 사용한다.
- 첫 줄은 `설명: `으로 시작한다.
- 설명은 한글 한 줄을 기본으로 한다.
- 신규 Swift 파일의 primary type에는 반드시 설명 주석을 붙인다.
- private helper, 단순 computed property, 명확한 override에는 기계적으로 주석을 늘리지 않는다.

## 네이밍 기본 규칙

- 타입명은 역할 suffix를 명확히 둔다.
- Bool은 가능하면 `is`, `has`, `can`, `should`로 시작한다.
- 동작 메서드는 동사로 시작한다.
- 축약어는 프로젝트에서 널리 쓰는 경우에만 사용한다.
- 디자인 시스템 컴포넌트는 `Deali` prefix를 사용한다.

## UIKit view 구성 규칙

UIKit 화면/뷰 코드는 주변 파일의 구성 패턴을 우선 따른다.

규칙:

- 상속이 필요 없는 신규 class는 기본적으로 `final class`를 사용한다.
- UIKit view/cell 초기 설정에서 동일 객체에 여러 속성을 설정하고 바로 constraint를 연결할 때는 `view.then { ... }.snp.makeConstraints { ... }` 패턴을 우선 사용한다.
- 동일 객체에 여러 속성을 설정하지만 constraint를 바로 연결하지 않는 경우에는 `view.do { ... }`를 사용한다.
- 단일 속성만 설정하는 경우에는 `then`/`do`로 감싸지 않고 직접 대입한다.
- `.do { ... }.snp.makeConstraints { ... }` 형태로 이어 붙이지 않는다. constraint를 바로 연결하면 `then`을 사용한다.
- `addSubview` 또는 `addArrangedSubview`는 해당 view의 `then`/`do`/첫 constraint 호출보다 먼저 둔다.
- CGFloat, spacing, constraint literal은 주변 코드처럼 `10.0` 형태의 decimal literal을 사용한다.

## SwiftUI 컴포넌트 규칙

SwiftUI 컴포넌트를 추가할 때는 기존 SwiftUI 컴포넌트 패턴을 따른다.

규칙:

- UIKit 컴포넌트의 SwiftUI wrapper를 만들 때는 기존 SwiftUI wrapper 패턴을 확인한다.
- 같은 `DealiTag.EType` 등 공유 타입을 UIKit/SwiftUI 양쪽에서 사용한다.
- SwiftUI Preview를 제공한다.

## Rx / Closure Memory 규칙

- Rx 바인딩에서 owner가 필요하면 `[weak self]`를 사용한다.
- Rx 구독은 `disposed(by:)`를 반드시 연결한다.
- `delegate` 프로퍼티는 순환 참조 가능성이 있으면 `weak`으로 둔다.

## Resource 접근 규칙

- 색상은 `UIColor.primary05`, `UIColor.g100`처럼 프로젝트에서 정의된 token을 사용한다.
- 폰트는 `.b2sb14`, `.c1sb10`처럼 프로젝트에서 정의된 extension을 사용한다.
- 아이콘은 `UIImage.dealiIcon(named:)`, `Image.dealiIcon(named:)`을 사용한다.
- generated Swift 파일은 확인만 하고 직접 수정하지 않는다.

## 금지 패턴

- 신규 Swift 파일에 설명 주석 없이 primary type만 두는 것
- `Created by`에 AI 도구/모델 이름을 넣는 것
- 상속이 필요 없는 신규 class를 이유 없이 non-final로 두는 것
- `.do { ... }.snp.makeConstraints { ... }` 형태로 constraint를 바로 연결하는 것
- Rx/closure에서 `self`를 강하게 캡처하거나 `disposed(by:)` 없이 구독을 남기는 것
