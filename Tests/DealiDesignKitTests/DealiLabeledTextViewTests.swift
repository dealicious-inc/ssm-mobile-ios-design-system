//
//  DealiLabeledTextViewTests.swift
//  DealiDesignKit
//
//  Created by 이창호 on 9/15/26.
//

import XCTest
@testable import DealiDesignKit

/**
 설명: DealiLabeledTextView의 textLinkHandler 탭 제스처 연결 동작 검증
 */
final class DealiLabeledTextViewTests: XCTestCase {

    private let messageText = "배송완료되었으나 상품 또는 구성품을 수령하지 못한 경우 고객센터로 문의해 주세요."
    private let linkText = "고객센터"

    private func makeAttributedMessage() -> NSMutableAttributedString {
        return NSMutableAttributedString(string: self.messageText)
            .font(.b3r13)
            .color(.g80)
            .alignment(.left)
            .applyLinkStyle(for: TextStyleAttributes(text: self.linkText, color: .linkAndInfo, underline: true))
            .setLineHeight()
    }

    private func makeLabeledTextView(preset: DealiLabeledTextPreset, textLinkHandler: ((String) -> Void)?) -> DealiLabeledTextView {
        let model = DealiLabeledTextModel(attributedMessage: self.makeAttributedMessage(),
                                          iconName: "ic_info",
                                          textLinkHandler: textLinkHandler)
        let labeledTextView = DealiLabeledTextView(preset: preset, model: model)
        labeledTextView.frame = CGRect(x: 0.0, y: 0.0, width: 320.0, height: 60.0)
        labeledTextView.layoutIfNeeded()

        return labeledTextView
    }

    /// DealiLabeledTextView의 직속 subview중 messageLabel만 UILabel이다
    private func messageLabel(in labeledTextView: DealiLabeledTextView) -> UILabel? {
        return labeledTextView.subviews.compactMap { $0 as? UILabel }.first
    }

    /// messageLabel에서 링크 텍스트가 그려진 지점을 찾는다
    private func linkPoint(in messageLabel: UILabel) -> CGPoint? {
        for x in stride(from: CGFloat(1.0), to: messageLabel.bounds.width, by: 2.0) {
            for y in stride(from: CGFloat(1.0), to: messageLabel.bounds.height, by: 2.0) {
                let point = CGPoint(x: x, y: y)
                if messageLabel.tappedLinkText(at: point) == self.linkText {
                    return point
                }
            }
        }

        return nil
    }

    func testTextLinkHandlerAttachesTapGesture() throws {
        let labeledTextView = self.makeLabeledTextView(preset: .labeledTextIcon01, textLinkHandler: { _ in })

        let messageLabel = try XCTUnwrap(self.messageLabel(in: labeledTextView))
        XCTAssertEqual(messageLabel.isUserInteractionEnabled, true)
        XCTAssertEqual(messageLabel.gestureRecognizers?.count, 1)
    }

    func testNoTextLinkHandlerKeepsPreviousBehavior() throws {
        let labeledTextView = self.makeLabeledTextView(preset: .labeledTextIcon01, textLinkHandler: nil)

        let messageLabel = try XCTUnwrap(self.messageLabel(in: labeledTextView))
        XCTAssertEqual(messageLabel.isUserInteractionEnabled, false)
        XCTAssertNil(messageLabel.gestureRecognizers)
    }

    func testReconfigureDoesNotDuplicateTapGesture() throws {
        let labeledTextView = self.makeLabeledTextView(preset: .labeledTextIcon01, textLinkHandler: { _ in })

        for _ in 0..<3 {
            labeledTextView.configure(model: DealiLabeledTextModel(attributedMessage: self.makeAttributedMessage(),
                                                                  iconName: "ic_info",
                                                                  textLinkHandler: { _ in }))
        }

        let messageLabel = try XCTUnwrap(self.messageLabel(in: labeledTextView))
        XCTAssertEqual(messageLabel.gestureRecognizers?.count, 1)
    }

    func testReconfigureWithoutHandlerRemovesTapGesture() throws {
        let labeledTextView = self.makeLabeledTextView(preset: .labeledTextIcon01, textLinkHandler: { _ in })
        labeledTextView.configure(model: DealiLabeledTextModel(attributedMessage: self.makeAttributedMessage(), iconName: "ic_info"))

        let messageLabel = try XCTUnwrap(self.messageLabel(in: labeledTextView))
        XCTAssertEqual(messageLabel.isUserInteractionEnabled, false)
        XCTAssertEqual(messageLabel.gestureRecognizers?.count ?? 0, 0)
    }

    /// 모든 preset에서 동일하게 동작해야 한다
    func testTapGestureWorksForEveryPreset() throws {
        let presetArray: [DealiLabeledTextPreset] = [.labeledTextBullet01, .labeledTextBullet02,
                                                     .labeledTextNumber01, .labeledTextNumber02,
                                                     .labeledTextIcon01, .labeledTextIcon02,
                                                     .labeledTextCustom01, .labeledTextCustom02]

        for preset in presetArray {
            let labeledTextView = self.makeLabeledTextView(preset: preset, textLinkHandler: { _ in })
            let messageLabel = try XCTUnwrap(self.messageLabel(in: labeledTextView), "\(preset) messageLabel 없음")

            XCTAssertEqual(messageLabel.isUserInteractionEnabled, true, "\(preset) isUserInteractionEnabled")
            XCTAssertEqual(messageLabel.gestureRecognizers?.count, 1, "\(preset) 제스처 개수")

            let linkPoint = try XCTUnwrap(self.linkPoint(in: messageLabel), "\(preset) 링크 영역을 찾지 못함")
            XCTAssertEqual(labeledTextView.hitTest(messageLabel.convert(linkPoint, to: labeledTextView), with: nil),
                           messageLabel,
                           "\(preset) 링크 지점의 터치 대상이 messageLabel이 아님")
        }
    }

    /// 링크 지점과 링크가 아닌 지점을 구분해야 한다
    func testTappedLinkTextOnlyResolvesInsideLinkRange() throws {
        let labeledTextView = self.makeLabeledTextView(preset: .labeledTextIcon01, textLinkHandler: { _ in })
        let messageLabel = try XCTUnwrap(self.messageLabel(in: labeledTextView))

        let linkPoint = try XCTUnwrap(self.linkPoint(in: messageLabel), "링크 영역을 찾지 못함")
        XCTAssertEqual(messageLabel.tappedLinkText(at: linkPoint), self.linkText)

        XCTAssertNil(messageLabel.tappedLinkText(at: CGPoint(x: 1.0, y: 1.0)), "문구 시작 지점은 링크가 아니어야 한다")
        XCTAssertNil(messageLabel.tappedLinkText(at: CGPoint(x: -10.0, y: -10.0)), "영역 밖은 nil이어야 한다")
    }

    /// 링크가 아닌 지점에서는 제스처를 인식하지 않아야 상위 뷰(셀 선택 등)가 터치를 받을 수 있다
    func testTapGestureRecognizesOnlyOnLinkPoint() throws {
        let labeledTextView = self.makeLabeledTextView(preset: .labeledTextIcon01, textLinkHandler: { _ in })
        let messageLabel = try XCTUnwrap(self.messageLabel(in: labeledTextView))

        let linkPoint = try XCTUnwrap(self.linkPoint(in: messageLabel), "링크 영역을 찾지 못함")
        XCTAssertTrue(labeledTextView.shouldRecognizeMessageLinkTap(at: linkPoint), "링크 지점은 인식해야 한다")

        XCTAssertFalse(labeledTextView.shouldRecognizeMessageLinkTap(at: CGPoint(x: 1.0, y: 1.0)),
                       "링크가 아닌 글자 지점은 인식하지 않아야 한다")
        XCTAssertFalse(labeledTextView.shouldRecognizeMessageLinkTap(at: CGPoint(x: messageLabel.bounds.width - 1.0, y: messageLabel.bounds.height - 1.0)),
                       "문구 끝 지점은 인식하지 않아야 한다")
    }

    /// 링크를 여러개 걸었을때 탭한 링크가 구분되어야 한다
    func testMultipleLinksResolveIndependently() throws {
        let multiLinkMessage = "문의는 고객센터 또는 신상톡으로 연락해 주세요."
        let attributedMessage = NSMutableAttributedString(string: multiLinkMessage)
            .font(.b3r13)
            .color(.g80)
            .alignment(.left)
            .applyMultipleLinkStyle(for: [TextStyleAttributes(text: "고객센터", color: .linkAndInfo, underline: true),
                                          TextStyleAttributes(text: "신상톡", color: .linkAndInfo, underline: true)])
            .setLineHeight()

        let labeledTextView = DealiLabeledTextView(preset: .labeledTextIcon01,
                                                   model: DealiLabeledTextModel(attributedMessage: attributedMessage,
                                                                                iconName: "ic_info",
                                                                                textLinkHandler: { _ in }))
        labeledTextView.frame = CGRect(x: 0.0, y: 0.0, width: 320.0, height: 60.0)
        labeledTextView.layoutIfNeeded()

        let messageLabel = try XCTUnwrap(self.messageLabel(in: labeledTextView))

        var resolvedLinkTextSet = Set<String>()
        for x in stride(from: CGFloat(1.0), to: messageLabel.bounds.width, by: 2.0) {
            for y in stride(from: CGFloat(1.0), to: messageLabel.bounds.height, by: 2.0) {
                if let linkText = messageLabel.tappedLinkText(at: CGPoint(x: x, y: y)) {
                    resolvedLinkTextSet.insert(linkText)
                }
            }
        }

        XCTAssertEqual(resolvedLinkTextSet, ["고객센터", "신상톡"])
    }
}
