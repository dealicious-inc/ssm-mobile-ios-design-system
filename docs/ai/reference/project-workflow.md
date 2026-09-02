# Project Workflow

## 목적

이 문서는 `ssm-mobile-ios-design-system`의 브랜치, PR, 빌드, 의존성 관리 판단을 위한 공용 reference다.

## 프로젝트 구조

- SPM(Swift Package Manager) 기반 라이브러리 프로젝트다.
- 패키지명: `DealiDesignKit`
- 최소 지원: iOS 16
- `Sources/DealiDesignKit/` 하위에 라이브러리 소스가 있다.
- `DealiDesignSystemSampleApp/`에 샘플 앱이 있다.
- `Tests/DealiDesignKitTests/`에 테스트가 있다.

## 의존성

- SnapKit, Then, RxSwift, RxCocoa, RxGesture, Kingfisher
- 정확한 버전은 `Package.swift`와 `Package.resolved`를 확인한다.
- 새 의존성 추가 시 `Package.swift`에 반영하고 resolve 결과를 확인한다.

## Branch

- 브랜치명은 작업 성격에 맞춰 `feature/`, `enhancement/`, `fix/`, `hotfix/`를 사용한다.
- 기본 브랜치는 `main`이다.

## PR

- PR 비교 기준은 기본적으로 `origin/main`이다.
- 리뷰 기준은 `docs/ai/playbooks/code-review-playbook.md`를 따른다.

## SampleApp

- 새 컴포넌트나 타입 변경 시 SampleApp의 해당 ViewController에도 반영한다.
- SampleApp은 `DealiDesignSystemSampleApp/` 하위에 있다.

## 금지

- 이 문서에 Swift 코드 스타일을 중복 정의하지 않는다.
- 라이브러리 버전을 정본처럼 고정하지 않는다.
