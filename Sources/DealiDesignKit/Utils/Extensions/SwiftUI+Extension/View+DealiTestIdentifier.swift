//
//  View+DealiTestIdentifier.swift
//  DealiDesignKit
//
//  Created by 이남준 on 11/23/26.
//

import SwiftUI

/**
 설명: DS SwiftUI 컴포넌트에 E2E 테스트 루트 식별자를 넘기는 환경값 키
 */
private struct DealiTestIdentifierKey: EnvironmentKey {
    static let defaultValue: String? = nil
}

extension EnvironmentValues {
    /// DS SwiftUI 컴포넌트가 읽는 테스트 루트 식별자. 앱은 `dealiTestIdentifier(_:)`로만 넣는다
    var dealiTestIdentifier: String? {
        get { self[DealiTestIdentifierKey.self] }
        set { self[DealiTestIdentifierKey.self] = newValue }
    }
}

extension View {
    /// DS SwiftUI 컴포넌트에 E2E 테스트 루트 식별자를 넘긴다. 컴포넌트가 루트와 안쪽 요소(`<루트>__title_text` 등)에 붙인다.
    /// 컴포넌트에 바로 붙인다. 화면 전체에 붙이면 안쪽 DS 컴포넌트가 모두 같은 루트를 받는다. nil이면 접근성 트리는 그대로다.
    public func dealiTestIdentifier(_ identifier: String?) -> some View {
        self.environment(\.dealiTestIdentifier, identifier)
    }

    /// 루트가 있을 때만 컨테이너 노드를 만든다. 루트가 없으면 아무것도 바꾸지 않는다
    @ViewBuilder
    func dealiTestContainer(_ root: String?) -> some View {
        if let root {
            self.accessibilityElement(children: .contain)
                .accessibilityIdentifier(root)
        } else {
            self
        }
    }

    /// 안쪽 요소에 `<루트><suffix>`를 붙인다. 루트가 없으면 아무것도 바꾸지 않는다
    @ViewBuilder
    func dealiTestIdentifier(_ root: String?, suffix: String) -> some View {
        if let root {
            self.accessibilityIdentifier("\(root)\(suffix)")
        } else {
            self
        }
    }

    /// 앱이 넣는 콘텐츠 자리에서 루트를 끊는다. 끊지 않으면 안쪽 DS 컴포넌트가 바깥 루트로 이름을 또 붙인다
    func dealiTestIdentifierBoundary() -> some View {
        self.environment(\.dealiTestIdentifier, nil)
    }
}
