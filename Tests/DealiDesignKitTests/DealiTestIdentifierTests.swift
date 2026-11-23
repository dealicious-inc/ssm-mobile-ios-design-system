//
//  DealiTestIdentifierTests.swift
//  DealiDesignKit
//
//  Created by 이남준 on 10/22/26.
//

import XCTest
@testable import DealiDesignKit

/**
 설명: DS 컴포넌트가 테스트 식별자 하나를 받아 안쪽 요소까지 붙이고, 선택·비활성 상태를 accessibilityTraits로 드러내는지 검증
 */
final class DealiTestIdentifierTests: XCTestCase {

    // MARK: - Helper

    private func allSubviews(of view: UIView) -> [UIView] {
        return view.subviews.flatMap { [$0] + self.allSubviews(of: $0) }
    }

    private func subview(identifier: String, in view: UIView) -> UIView? {
        return self.allSubviews(of: view).first { $0.accessibilityIdentifier == identifier }
    }

    private func identifiers(in view: UIView) -> [String] {
        return self.allSubviews(of: view).compactMap { $0.accessibilityIdentifier }
    }

    // MARK: - TabBar

    /// DealiTabBarView는 init에서 자기 자신에 높이 제약을 걸어 translatesAutoresizingMaskIntoConstraints가 꺼지므로 host view에 넣어 레이아웃한다
    private func makeLaidOutTabBar(_ tabBarView: DealiTabBarView, items: [DealiTabBarItemProtocol], startIndex: Int = 0) -> UICollectionView? {
        tabBarView.setTabBarItems(tabBarItemArray: items, startIndex: startIndex)

        let hostView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 320.0, height: 56.0))
        hostView.addSubview(tabBarView)
        NSLayoutConstraint.activate([
            tabBarView.topAnchor.constraint(equalTo: hostView.topAnchor),
            tabBarView.leftAnchor.constraint(equalTo: hostView.leftAnchor),
            tabBarView.rightAnchor.constraint(equalTo: hostView.rightAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: hostView.bottomAnchor)
        ])
        hostView.layoutIfNeeded()

        return self.allSubviews(of: tabBarView).compactMap { $0 as? UICollectionView }.first
    }

    /// 화면 노출 여부와 무관하게 dequeue → configure → applyAccessibility 경로를 그대로 탄다
    private func cell(in collectionView: UICollectionView, item: Int) throws -> UICollectionViewCell {
        let dataSource = try XCTUnwrap(collectionView.dataSource)
        return dataSource.collectionView(collectionView, cellForItemAt: IndexPath(item: item, section: 0))
    }

    func testTabBarCellCarriesIdentifierAndSelectedTrait() throws {
        let tabBarView = DealiTabBar.tabBarSlider01()
        let items = [DealiTabBarItem.make(title: "매장주문", testIdentifier: "order_list__store_order_tab"),
                     DealiTabBarItem.make(title: "신상배송", testIdentifier: "order_list__sinsang_delivery_tab")]
        let collectionView = try XCTUnwrap(self.makeLaidOutTabBar(tabBarView, items: items))

        let firstCell = try self.cell(in: collectionView, item: 0)
        let secondCell = try self.cell(in: collectionView, item: 1)

        XCTAssertEqual(firstCell.accessibilityIdentifier, "order_list__store_order_tab")
        XCTAssertEqual(secondCell.accessibilityIdentifier, "order_list__sinsang_delivery_tab")
        XCTAssertTrue(firstCell.accessibilityTraits.contains(.selected))
        XCTAssertFalse(secondCell.accessibilityTraits.contains(.selected))
    }

    func testTabBarSelectedTraitFollowsSelectedIndex() throws {
        let tabBarView = DealiTabBar.tabBarSlider01()
        let items = [DealiTabBarItem.make(title: "매장주문", testIdentifier: "order_list__store_order_tab"),
                     DealiTabBarItem.make(title: "신상배송", testIdentifier: "order_list__sinsang_delivery_tab")]
        let collectionView = try XCTUnwrap(self.makeLaidOutTabBar(tabBarView, items: items))

        tabBarView.setSelectedIndex(index: 1, animated: false, withDidSelect: false)

        let firstCell = try self.cell(in: collectionView, item: 0)
        let secondCell = try self.cell(in: collectionView, item: 1)

        XCTAssertFalse(firstCell.accessibilityTraits.contains(.selected))
        XCTAssertTrue(secondCell.accessibilityTraits.contains(.selected))
        XCTAssertEqual(secondCell.accessibilityIdentifier, "order_list__sinsang_delivery_tab")
    }

    func testTabBarCellWithoutIdentifierStaysNil() throws {
        let tabBarView = DealiTabBar.tabBarSegment01()
        let items = [DealiTabBarItem.make(title: "전체"),
                     DealiTabBarItem.make(title: "여성의류")]
        let collectionView = try XCTUnwrap(self.makeLaidOutTabBar(tabBarView, items: items))

        let firstCell = try self.cell(in: collectionView, item: 0)

        XCTAssertNil(firstCell.accessibilityIdentifier)
        XCTAssertTrue(firstCell.accessibilityTraits.contains(.selected))
    }

    func testTabBarIdentifierSurvivesTitleChangeReload() throws {
        let tabBarView = DealiTabBar.tabBarSlider01()
        let items = [DealiTabBarItem.make(title: "매장주문", testIdentifier: "order_list__store_order_tab")]
        let collectionView = try XCTUnwrap(self.makeLaidOutTabBar(tabBarView, items: items))

        tabBarView.changeTabBarButtonTitle(index: 0, title: "매장주문 (3)")

        let firstCell = try self.cell(in: collectionView, item: 0)
        XCTAssertEqual(firstCell.accessibilityIdentifier, "order_list__store_order_tab")
    }

    func testCustomTabBarItemProtocolDefaultsToNilIdentifier() {
        struct LegacyItem: DealiTabBarItemProtocol {
            var viewController: UIViewController?
            var page: Int = 0
            var title: String?
            var isHidden: Bool = false
            var showsBadge: Bool = false
            var icon: DealiTabBarIcon?
            var imageChipSlotView: DealiCustomView?
        }

        XCTAssertNil(LegacyItem().testIdentifier)
    }

    // MARK: - Empty

    func testEmptyViewAppliesChildIdentifiers() {
        let emptyView = DealiEmptyView()
        emptyView.set(title: "제목", message: "메시지", actionButtonTitle: "재시도")

        emptyView.accessibilityIdentifier = "cart__store_order__empty_notice"

        XCTAssertTrue(self.subview(identifier: "cart__store_order__empty_notice__title_text", in: emptyView) is UILabel)
        XCTAssertTrue(self.subview(identifier: "cart__store_order__empty_notice__message_text", in: emptyView) is UILabel)
        XCTAssertTrue(self.subview(identifier: "cart__store_order__empty_notice__action_button", in: emptyView) is UIButton)

        emptyView.accessibilityIdentifier = nil

        XCTAssertTrue(self.identifiers(in: emptyView).isEmpty)
    }

    func testEmptyCollectionViewCellForwardsToChildrenOnly() {
        let cell = DealiEmptyCollectionViewCell(frame: .zero)
        cell.setEmpty(title: "제목", message: "메시지", actionButtonTitle: "재시도")

        cell.accessibilityIdentifier = "order_list__sinsang_delivery__empty_notice"

        XCTAssertNotNil(self.subview(identifier: "order_list__sinsang_delivery__empty_notice__title_text", in: cell))
        XCTAssertNotNil(self.subview(identifier: "order_list__sinsang_delivery__empty_notice__message_text", in: cell))
        XCTAssertNotNil(self.subview(identifier: "order_list__sinsang_delivery__empty_notice__action_button", in: cell))
        XCTAssertNil(self.subview(identifier: "order_list__sinsang_delivery__empty_notice", in: cell), "안쪽 emptyView에는 셀과 같은 이름을 붙이지 않는다")
    }

    func testEmptyTableViewCellForwardsToChildrenOnly() {
        let cell = DealiEmptyTableViewCell(style: .default, reuseIdentifier: nil)
        cell.setEmpty(message: "메시지")

        cell.accessibilityIdentifier = "order_list__store_order__empty_notice"

        XCTAssertNotNil(self.subview(identifier: "order_list__store_order__empty_notice__message_text", in: cell))
        XCTAssertNil(self.subview(identifier: "order_list__store_order__empty_notice", in: cell))
    }

    // MARK: - Checkbox

    func testCheckboxExposesSelectedAndNotEnabledTraits() {
        let checkbox = DealiCheckbox()
        XCTAssertFalse(checkbox.accessibilityTraits.contains(.selected))
        XCTAssertFalse(checkbox.accessibilityTraits.contains(.notEnabled))

        checkbox.isSelected = true
        XCTAssertTrue(checkbox.accessibilityTraits.contains(.selected))

        checkbox.isEnabled = false
        XCTAssertTrue(checkbox.accessibilityTraits.contains(.notEnabled))
        XCTAssertTrue(checkbox.accessibilityTraits.contains(.selected))

        checkbox.isSelected = false
        XCTAssertFalse(checkbox.accessibilityTraits.contains(.selected))

        XCTAssertFalse(checkbox.isAccessibilityElement)
        XCTAssertNil(checkbox.accessibilityLabel)
        XCTAssertNil(checkbox.accessibilityValue)
    }

    func testCheckboxWithTextExposesTraitsOnOuterView() {
        let checkboxWithText = DealiCheckboxWithText(text: "동의", status: .init(isEnable: true, isSelected: false))
        XCTAssertFalse(checkboxWithText.accessibilityTraits.contains(.selected))

        checkboxWithText.isSelected = true
        XCTAssertTrue(checkboxWithText.accessibilityTraits.contains(.selected))

        checkboxWithText.isEnabled = false
        XCTAssertTrue(checkboxWithText.accessibilityTraits.contains(.notEnabled))

        XCTAssertNil(checkboxWithText.accessibilityValue)
    }

    // MARK: - CountStepper

    func testCountStepperAppliesChildIdentifiersWithSingleUnderscore() {
        let stepper = DealiCountStepper()

        stepper.accessibilityIdentifier = "cart__store_order__option__quantity"

        XCTAssertTrue(self.subview(identifier: "cart__store_order__option__quantity_minus_button", in: stepper) is UIButton)
        XCTAssertTrue(self.subview(identifier: "cart__store_order__option__quantity_input", in: stepper) is UITextField)
        XCTAssertTrue(self.subview(identifier: "cart__store_order__option__quantity_plus_button", in: stepper) is UIButton)

        stepper.accessibilityIdentifier = nil

        XCTAssertTrue(self.identifiers(in: stepper).isEmpty)
    }

    // MARK: - SearchInput

    @available(*, deprecated)
    func testSearchInputAppliesInputAndClearIdentifiersOnly() {
        let searchInput = DealiSearchInput(delegate: nil)

        searchInput.accessibilityIdentifier = "store_search__search"

        XCTAssertTrue(self.subview(identifier: "store_search__search__input", in: searchInput) is UITextField)
        XCTAssertTrue(self.subview(identifier: "store_search__search__clear_button", in: searchInput) is UIImageView)
        XCTAssertEqual(self.identifiers(in: searchInput).count, 2, "검색 아이콘에는 식별자를 붙이지 않는다")

        searchInput.accessibilityIdentifier = nil

        XCTAssertTrue(self.identifiers(in: searchInput).isEmpty)
    }

    // MARK: - Alert

    /// present는 window가 없어 일어나지 않지만, 정적 함수가 VC를 만들고 값을 넣는 경로는 그대로 탄다
    private func makeAlert(_ show: (UIViewController) -> DealiAlertViewController) -> DealiAlertViewController {
        let alertViewController = show(UIViewController())
        alertViewController.loadViewIfNeeded()
        return alertViewController
    }

    func testAlertWithoutRootKeepsTreeAndAppButtonIdentifiers() {
        let buttonStyle = DealiAlertButtonStyle(makeConfirmButton: {
            let button = DealiControl.btnFilledMedium01()
            button.accessibilityIdentifier = "app_confirm_button"
            return button
        })
        let alertViewController = self.makeAlert {
            DealiAlert.show(title: "제목", message: "문구", cancelButtonTitle: "취소", confirmButtonTitle: "확인",
                            buttonStyle: buttonStyle, alertPresentingViewController: $0, cancelAction: nil, confirmAction: nil)
        }

        XCTAssertNil(alertViewController.view.accessibilityIdentifier)
        XCTAssertEqual(self.identifiers(in: alertViewController.view), ["app_confirm_button"])
    }

    func testAlertRootSetAfterLoadViewAppliesChildIdentifiers() {
        let alertViewController = self.makeAlert {
            DealiAlert.show(title: "제목", message: "문구", cancelButtonTitle: "취소", confirmButtonTitle: "확인",
                            alertPresentingViewController: $0, cancelAction: nil, confirmAction: nil)
        }

        alertViewController.testIdentifier = "cart_delete_confirm"

        let view = alertViewController.view!
        XCTAssertEqual(view.accessibilityIdentifier, "cart_delete_confirm")
        XCTAssertTrue(self.subview(identifier: "cart_delete_confirm__title_text", in: view) is UILabel)
        XCTAssertTrue(self.subview(identifier: "cart_delete_confirm__message_text", in: view) is UILabel)
        XCTAssertTrue(self.subview(identifier: "cart_delete_confirm__cancel_button", in: view) is ClickableUnitButtonComponent)
        XCTAssertTrue(self.subview(identifier: "cart_delete_confirm__confirm_button", in: view) is ClickableUnitButtonComponent)
    }

    func testAlertSkipsMissingTitleAndCancelButton() {
        let alertViewController = self.makeAlert {
            DealiAlert.showConfirm(message: "문구", confirmButtonTitle: "확인", testIdentifier: "order_done",
                                   alertPresentingViewController: $0, confirmAction: nil)
        }

        let identifiers = self.identifiers(in: alertViewController.view)
        XCTAssertEqual(alertViewController.view.accessibilityIdentifier, "order_done")
        XCTAssertEqual(Set(identifiers), ["order_done__message_text", "order_done__confirm_button"])
    }

    func testAlertCheckBoxAndTextLinkVariantsAndNilReset() {
        let checkAlert = self.makeAlert {
            DealiAlert.showCheckBox(message: "문구", checkButtonTitle: "다시 보지 않기", cancelButtonTitle: "취소", confirmButtonTitle: "확인",
                                    testIdentifier: "cart_reorder", alertPresentingViewController: $0, cancelAction: nil, confirmAction: nil)
        }
        XCTAssertTrue(self.subview(identifier: "cart_reorder__checkbox", in: checkAlert.view) is DealiCheckboxWithText)

        let linkAlert = self.makeAlert {
            DealiAlert.showTextLink(message: "문구", textLinkButtonTitle: "자세히 보기", cancelButtonTitle: "취소", confirmButtonTitle: "확인",
                                    testIdentifier: "chat_send", alertPresentingViewController: $0,
                                    cancelAction: nil, confirmAction: nil, textLinkAction: nil)
        }
        XCTAssertNotNil(self.subview(identifier: "chat_send__link_button", in: linkAlert.view))

        checkAlert.testIdentifier = nil
        linkAlert.testIdentifier = nil

        XCTAssertNil(checkAlert.view.accessibilityIdentifier)
        XCTAssertTrue(self.identifiers(in: checkAlert.view).isEmpty)
        XCTAssertTrue(self.identifiers(in: linkAlert.view).isEmpty)
    }
}
