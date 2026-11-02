//
//  DealiDotsIndicatorViewTests.swift
//  DealiDesignKit
//
//  Created by 이창호 on 10/30/26.
//

import XCTest
@testable import DealiDesignKit

/**
 설명: 점 페이지 인디케이터의 선택 페이지 범위 보정, 선택 점 위치 유지, 최대 노출 점 수 창을 검증한다
 */
final class DealiDotsIndicatorViewTests: XCTestCase {

    private func makeIndicator(numberOfPages: Int, maxVisibleDots: Int? = nil) -> DealiIndicatorView {
        let indicator = DealiIndicator.dots(maxVisibleDots: maxVisibleDots)
        indicator.numberOfPages = numberOfPages
        return indicator
    }

    private let dotSize = DealiIndicatorPreset.dots.dotsSize
    private let compactDotSize = DealiIndicatorPreset.dots.compactDotsSize

    /// 점은 stack view 안에 있고 선택 점은 stack view 밖의 유일한 subview다
    private func dotViews(of indicator: UIView) -> (dots: [UIView], selected: UIView)? {
        guard let stackView = indicator.subviews.compactMap({ $0 as? UIStackView }).first,
              let selected = indicator.subviews.first(where: { ($0 is UIStackView) == false }) else { return nil }
        return (stackView.arrangedSubviews, selected)
    }

    private func layout(_ indicator: UIView, width: CGFloat = 200.0) {
        indicator.frame = CGRect(x: 0.0, y: 0.0, width: width, height: 20.0)
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

    // MARK: - 최대 노출 점 수

    func testWithoutMaxVisibleDotsAllDotsAreDrawn() throws {
        let indicator = self.makeIndicator(numberOfPages: 33)
        // 점 33개(390pt)가 눌리지 않게 넓게 배치한다
        self.layout(indicator, width: 400.0)

        let views = try XCTUnwrap(self.dotViews(of: indicator))
        XCTAssertEqual(views.dots.count, 33)
        XCTAssertTrue(views.dots.allSatisfy { $0.bounds.size == self.dotSize })
    }

    func testMaxVisibleDotsLimitsDrawnDots() throws {
        let indicator = self.makeIndicator(numberOfPages: 33, maxVisibleDots: 5)
        self.layout(indicator)

        var views = try XCTUnwrap(self.dotViews(of: indicator))
        XCTAssertEqual(views.dots.count, 5)

        // 페이지가 최대 점 수 이하면 창 없이 모두 기본 크기다
        indicator.numberOfPages = 5
        self.layout(indicator)
        views = try XCTUnwrap(self.dotViews(of: indicator))
        XCTAssertEqual(views.dots.count, 5)
        XCTAssertTrue(views.dots.allSatisfy { $0.bounds.size == self.dotSize })
    }

    func testWindowShrinksEdgeDotsOnlyWhereMorePagesExist() throws {
        let indicator = self.makeIndicator(numberOfPages: 33, maxVisibleDots: 5)
        self.layout(indicator)

        // 첫 구간: 오른쪽 끝만 작다
        var views = try XCTUnwrap(self.dotViews(of: indicator))
        XCTAssertEqual(views.dots.map(\.bounds.size), [self.dotSize, self.dotSize, self.dotSize, self.dotSize, self.compactDotSize])
        XCTAssertEqual(views.selected.center, views.dots[0].center)

        // 마지막 구간: 왼쪽 끝만 작다
        indicator.currentPage = 32
        self.layout(indicator)
        views = try XCTUnwrap(self.dotViews(of: indicator))
        XCTAssertEqual(views.dots.map(\.bounds.size), [self.compactDotSize, self.dotSize, self.dotSize, self.dotSize, self.dotSize])
        XCTAssertEqual(views.selected.center, views.dots[4].center)
    }

    func testWindowMovesSoSelectedDotNeverSitsOnCompactEdge() throws {
        let indicator = try XCTUnwrap(self.makeIndicator(numberOfPages: 33, maxVisibleDots: 5) as? DealiDotsIndicatorView)

        // 창 안의 큰 점 자리(0~3)까지는 창이 그대로다
        indicator.currentPage = 3
        XCTAssertEqual(indicator.windowStart, 0)

        // 작은 끝 점 자리에 오면 창을 밀어 선택 점이 끝에서 두 번째 큰 점에 선다
        indicator.currentPage = 4
        XCTAssertEqual(indicator.windowStart, 1)
        self.layout(indicator)
        var views = try XCTUnwrap(self.dotViews(of: indicator))
        XCTAssertEqual(views.dots.map(\.bounds.size), [self.compactDotSize, self.dotSize, self.dotSize, self.dotSize, self.compactDotSize])
        XCTAssertEqual(views.selected.center, views.dots[3].center)

        // 뒤로 갈 때도 같다. 마지막 구간(28~32)에서 28은 작은 점 자리라 창을 한 칸 당긴다
        indicator.currentPage = 32
        XCTAssertEqual(indicator.windowStart, 28)
        indicator.currentPage = 29
        XCTAssertEqual(indicator.windowStart, 28)
        indicator.currentPage = 28
        XCTAssertEqual(indicator.windowStart, 27)
        self.layout(indicator)
        views = try XCTUnwrap(self.dotViews(of: indicator))
        XCTAssertEqual(views.selected.center, views.dots[1].center)
    }

    func testReducingPagesClampsWindow() throws {
        let indicator = try XCTUnwrap(self.makeIndicator(numberOfPages: 33, maxVisibleDots: 5) as? DealiDotsIndicatorView)
        indicator.currentPage = 32

        indicator.numberOfPages = 6
        self.layout(indicator)

        XCTAssertEqual(indicator.currentPage, 5)
        XCTAssertEqual(indicator.windowStart, 1)
        let views = try XCTUnwrap(self.dotViews(of: indicator))
        XCTAssertEqual(views.dots.count, 5)
        XCTAssertEqual(views.dots.map(\.bounds.size), [self.compactDotSize, self.dotSize, self.dotSize, self.dotSize, self.dotSize])
        XCTAssertEqual(views.selected.center, views.dots[4].center)
    }
}
