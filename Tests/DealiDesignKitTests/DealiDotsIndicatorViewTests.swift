//
//  DealiDotsIndicatorViewTests.swift
//  DealiDesignKit
//
//  Created by 이창호 on 10/30/26.
//

import XCTest
@testable import DealiDesignKit

/**
 설명: 점 페이지 인디케이터의 선택 페이지 범위 보정과 선택 점 위치 유지를 검증한다
 */
final class DealiDotsIndicatorViewTests: XCTestCase {

    private func makeIndicator(numberOfPages: Int) -> DealiIndicatorView {
        let indicator = DealiIndicator.dots()
        indicator.numberOfPages = numberOfPages
        return indicator
    }

    /// 점은 stack view 안에 있고 선택 점은 stack view 밖의 유일한 subview다
    private func dotViews(of indicator: UIView) -> (dots: [UIView], selected: UIView)? {
        guard let stackView = indicator.subviews.compactMap({ $0 as? UIStackView }).first,
              let selected = indicator.subviews.first(where: { ($0 is UIStackView) == false }) else { return nil }
        return (stackView.arrangedSubviews, selected)
    }

    private func layout(_ indicator: UIView) {
        indicator.frame = CGRect(x: 0.0, y: 0.0, width: 200.0, height: 20.0)
        indicator.setNeedsLayout()
        indicator.layoutIfNeeded()
    }

    func testCurrentPageIsClampedToPageRange() {
        let indicator = self.makeIndicator(numberOfPages: 5)

        indicator.currentPage = 7
        XCTAssertEqual(indicator.currentPage, 4)

        indicator.currentPage = -1
        XCTAssertEqual(indicator.currentPage, 0)
    }

    func testReducingPagesMovesCurrentPageToLastPage() {
        let indicator = self.makeIndicator(numberOfPages: 5)
        indicator.currentPage = 4

        indicator.numberOfPages = 3
        XCTAssertEqual(indicator.currentPage, 2)

        // 점이 없어져도 페이지는 남겨 두고, 점이 다시 생기면 그 페이지를 선택한다
        indicator.numberOfPages = 0
        XCTAssertEqual(indicator.currentPage, 2)

        indicator.numberOfPages = 5
        XCTAssertEqual(indicator.currentPage, 2)
    }

    func testCurrentPageSetBeforePagesIsKept() {
        let indicator = DealiIndicator.dots()
        indicator.currentPage = 2
        indicator.numberOfPages = 5

        XCTAssertEqual(indicator.currentPage, 2)
    }

    func testSelectedDotStaysOnCurrentPageAfterRelayout() throws {
        let indicator = self.makeIndicator(numberOfPages: 5)
        indicator.currentPage = 3
        self.layout(indicator)

        let views = try XCTUnwrap(self.dotViews(of: indicator))
        XCTAssertFalse(views.selected.isHidden)
        XCTAssertEqual(views.selected.center, views.dots[3].center)

        // 다시 배치돼도 선택 점은 같은 점 위에 있다
        self.layout(indicator)
        XCTAssertEqual(views.selected.center, views.dots[3].center)
    }

    func testSelectedDotFollowsRebuiltDotsWhenPagesChange() throws {
        let indicator = self.makeIndicator(numberOfPages: 5)
        indicator.currentPage = 2
        self.layout(indicator)

        indicator.numberOfPages = 3
        self.layout(indicator)

        let views = try XCTUnwrap(self.dotViews(of: indicator))
        XCTAssertEqual(views.dots.count, 3)
        XCTAssertEqual(views.selected.center, views.dots[2].center)
    }

    func testSelectedDotIsHiddenWithoutPages() throws {
        let indicator = self.makeIndicator(numberOfPages: 0)
        self.layout(indicator)

        let views = try XCTUnwrap(self.dotViews(of: indicator))
        XCTAssertTrue(views.dots.isEmpty)
        XCTAssertTrue(views.selected.isHidden)
    }
}
