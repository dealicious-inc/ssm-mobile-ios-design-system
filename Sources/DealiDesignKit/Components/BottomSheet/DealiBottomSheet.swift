//
//  DealiBottomSheet.swift
//
//
//  Created by hoji on 2024/03/04.
//

import UIKit
import RxSwift

enum EBottomSheetOptionType: Equatable {
    case singleSelect
    case multiSelect
    case iconWithText
    case slotWithText(size: ESlotSize)
    case textOnly
}

public enum ESlotSize {
    /// 24*24
    case small
    /// 32*32
    case medium
    /// 40*40
    case large
    
    public var cgSize: CGSize {
        switch self {
        case .small:
            return CGSize(width: 24.0, height: 24.0)
        case .medium:
            return CGSize(width: 32.0, height: 32.0)
        case .large:
            return CGSize(width: 40.0, height: 40.0)
        }
    }
}

public enum EBottomSheetTitleType: Equatable {
    case hidden
    case title(title: String?)
    case closeButton
    case titleCloseButton(title: String?)
}

public enum EBottomSheetButtonType: Equatable {
    case hidden
    case oneButton(buttonTitle: String?)
    case twoButton(confirmTitle: String?, cancelTitle: String?, cancelButtonType: EBottomSheetCancelButtonType? = .btnOutlineLarge01)
}

public enum EBottomSheetCancelButtonType {
    case btnOutlineLarge01
    case btnOutlineLarge06
}

public class DealiBottomSheet: NSObject {
    
    public class func showSingleSelectionType(
        titleType: EBottomSheetTitleType = .hidden,
        buttonType: EBottomSheetButtonType = .hidden,
        option: [DealiBottomSheetOptionData],
        closeBottomSheetOnOutsideTouch: Bool = true,
        cancelActionOnOutsideTouch: Bool = false,
        cancelActionOnCloseButton: Bool = false,
        shouldDismissWhenSelect: Bool = false,
        popupPresentingViewController: UIViewController,
        selectAction: (([Int]) -> Void)?,
        cancelAction: (() -> Void)?,
        confirmAction: (() -> Void)?) {

            let viewController = DealiBottomSheetSystemViewController().then {
                $0.contentContainerView = UIView()
                $0.optionType = .singleSelect
                $0.optionData = option
                $0.titleType = titleType
                $0.buttonType = buttonType
                $0.closeBottomSheetOnOutsideTouch = closeBottomSheetOnOutsideTouch
                $0.cancelActionOnOutsideTouch = cancelActionOnOutsideTouch
                $0.cancelActionOnCloseButton = cancelActionOnCloseButton
                $0.shouldDismissWhenSelect = shouldDismissWhenSelect
                $0.selectAction = selectAction
                $0.cancelAction = cancelAction
                $0.confirmAction = confirmAction
            }

            popupPresentingViewController.present(viewController, animated: false)
        }
    
    public class func showMultiSelectionType(
        titleType: EBottomSheetTitleType = .hidden,
        buttonType: EBottomSheetButtonType = .hidden,
        option: [DealiBottomSheetOptionData],
        closeBottomSheetOnOutsideTouch: Bool = true,
        cancelActionOnOutsideTouch: Bool = false,
        cancelActionOnCloseButton: Bool = false,
        shouldDismissWhenSelect: Bool = false,
        popupPresentingViewController: UIViewController,
        selectAction: (([Int]) -> Void)?,
        cancelAction: (() -> Void)?,
        confirmAction: (() -> Void)?) {

            let viewController = DealiBottomSheetSystemViewController().then {
                $0.contentContainerView = UIView()
                $0.optionType = .multiSelect
                $0.optionData = option
                $0.titleType = titleType
                $0.buttonType = buttonType
                $0.closeBottomSheetOnOutsideTouch = closeBottomSheetOnOutsideTouch
                $0.cancelActionOnOutsideTouch = cancelActionOnOutsideTouch
                $0.cancelActionOnCloseButton = cancelActionOnCloseButton
                $0.shouldDismissWhenSelect = shouldDismissWhenSelect
                $0.selectAction = selectAction
                $0.cancelAction = cancelAction
                $0.confirmAction = confirmAction
            }

            popupPresentingViewController.present(viewController, animated: false)
        }
    
    public class func showIconWithTextType(
        titleType: EBottomSheetTitleType = .hidden,
        buttonType: EBottomSheetButtonType = .hidden,
        option: [DealiBottomSheetOptionData],
        closeBottomSheetOnOutsideTouch: Bool = true,
        cancelActionOnOutsideTouch: Bool = false,
        cancelActionOnCloseButton: Bool = false,
        shouldDismissWhenSelect: Bool = false,
        popupPresentingViewController: UIViewController,
        selectAction: (([Int]) -> Void)?,
        cancelAction: (() -> Void)?,
        confirmAction: (() -> Void)?) {

            let viewController = DealiBottomSheetSystemViewController().then {
                $0.contentContainerView = UIView()
                $0.optionType = .iconWithText
                $0.optionData = option
                $0.titleType = titleType
                $0.buttonType = buttonType
                $0.closeBottomSheetOnOutsideTouch = closeBottomSheetOnOutsideTouch
                $0.cancelActionOnOutsideTouch = cancelActionOnOutsideTouch
                $0.cancelActionOnCloseButton = cancelActionOnCloseButton
                $0.shouldDismissWhenSelect = shouldDismissWhenSelect
                $0.selectAction = selectAction
                $0.cancelAction = cancelAction
                $0.confirmAction = confirmAction
            }

            popupPresentingViewController.present(viewController, animated: false)
        }
    
    public class func showSlotWithTextType(
        titleType: EBottomSheetTitleType = .hidden,
        buttonType: EBottomSheetButtonType = .hidden,
        option: [DealiBottomSheetOptionData],
        slotSize: ESlotSize,
        closeBottomSheetOnOutsideTouch: Bool = true,
        cancelActionOnOutsideTouch: Bool = false,
        cancelActionOnCloseButton: Bool = false,
        shouldDismissWhenSelect: Bool = false,
        popupPresentingViewController: UIViewController,
        selectAction: (([Int]) -> Void)?,
        cancelAction: (() -> Void)?,
        confirmAction: (() -> Void)?) {

            let viewController = DealiBottomSheetSystemViewController().then {
                $0.contentContainerView = UIView()
                $0.optionType = .slotWithText(size: slotSize)
                $0.optionData = option
                $0.titleType = titleType
                $0.buttonType = buttonType
                $0.closeBottomSheetOnOutsideTouch = closeBottomSheetOnOutsideTouch
                $0.cancelActionOnOutsideTouch = cancelActionOnOutsideTouch
                $0.cancelActionOnCloseButton = cancelActionOnCloseButton
                $0.shouldDismissWhenSelect = shouldDismissWhenSelect
                $0.selectAction = selectAction
                $0.cancelAction = cancelAction
                $0.confirmAction = confirmAction
            }

            popupPresentingViewController.present(viewController, animated: false)
        }
    
    public class func showTextOnly(titleType: EBottomSheetTitleType = .hidden,
                                   message: String,
                                   buttonType: EBottomSheetButtonType = .hidden,
                                   closeBottomSheetOnOutsideTouch: Bool = true,
                                   cancelActionOnOutsideTouch: Bool = false,
                                   cancelActionOnCloseButton: Bool = false,
                                   shouldDismissWhenSelect: Bool = false,
                                   popupPresentingViewController: UIViewController,
                                   cancelAction: (() -> Void)?,
                                   confirmAction: (() -> Void)?) {

        let messageStyle = NSMutableParagraphStyle().then {
            $0.alignment = .left
            $0.lineHeightMultiple = 1.16
        }

        let messageLabel = UILabel().then {
            $0.numberOfLines = 0
            $0.attributedText = NSMutableAttributedString(string: message, attributes: [.font: UIFont.b2r14, .foregroundColor: UIColor.g80, .paragraphStyle: messageStyle])
        }

        self.showBottomSheet(titleType: titleType,
                             optionContentView: messageLabel,
                             buttonType: buttonType,
                             closeBottomSheetOnOutsideTouch: closeBottomSheetOnOutsideTouch,
                             cancelActionOnOutsideTouch: cancelActionOnOutsideTouch,
                             cancelActionOnCloseButton: cancelActionOnCloseButton,
                             shouldDismissWhenSelect: shouldDismissWhenSelect,
                             popupPresentingViewController: popupPresentingViewController,
                             cancelAction: cancelAction,
                             confirmAction: confirmAction)
    }
    
    public typealias HideBottomSheetHandler = (() -> Void)
    
    @discardableResult
    public class func showBottomSheet(titleType: EBottomSheetTitleType = .hidden,
                                      optionContentView: UIView,
                                      buttonType: EBottomSheetButtonType = .hidden,
                                      closeBottomSheetOnOutsideTouch: Bool = true,
                                      cancelActionOnOutsideTouch: Bool = false,
                                      cancelActionOnCloseButton: Bool = false,
                                      shouldDismissWhenSelect: Bool = false,
                                      popupPresentingViewController: UIViewController,
                                      cancelAction: (() -> Void)?,
                                      confirmAction: (() -> Void)?) -> HideBottomSheetHandler {

        let viewController = DealiBottomSheetSystemViewController().then {
            $0.contentContainerView = optionContentView
            $0.titleType = titleType
            $0.buttonType = buttonType
            $0.closeBottomSheetOnOutsideTouch = closeBottomSheetOnOutsideTouch
            $0.cancelActionOnOutsideTouch = cancelActionOnOutsideTouch
            $0.cancelActionOnCloseButton = cancelActionOnCloseButton
            $0.shouldDismissWhenSelect = shouldDismissWhenSelect
            $0.cancelAction = cancelAction
            $0.confirmAction = confirmAction
        }
        
        let handler: HideBottomSheetHandler = {
            viewController.hideBottomSheet(hideHandler: confirmAction)
        }
        
        popupPresentingViewController.present(viewController, animated: false)
        
        return handler
    }
    
}

class DealiBottomSheetSystemViewController: DealiBottomSheetBaseViewController {
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var optionType: EBottomSheetOptionType? = nil
    var optionData: [DealiBottomSheetOptionData] = [] {
        didSet {
            self.collectionView.snp.updateConstraints {
                $0.height.equalTo(self.optionHeight)
            }
        }
    }
    
    var optionHeight: CGFloat {
        let titleHeight = 60.0
        let buttonContentHeight = self.buttonType == .hidden ? 0 : 74.0 + safeAreaBottomMargin
        let maximumContentHeight = UIScreen.main.bounds.size.height * 0.9 - titleHeight - buttonContentHeight
        let contentHeight = CGFloat(self.optionData.count) * 52.0
        return min(maximumContentHeight, contentHeight)
    }
    
    var shouldDismissWhenSelect: Bool = false
    /// title close 버튼 클릭시 cancel Action 호출 유무
    var cancelActionOnCloseButton: Bool = false
    var cancelAction: (() -> Void)? {
        didSet {
            if self.cancelActionOnCloseButton {
                self.closeActionHandler = self.cancelAction
            }
        }
    }
    var confirmAction: (() -> Void)?
    var selectAction: (([Int]) -> Void)?
    
    /// option Content 노출 영역
    var contentContainerView: UIView?
    /// 버튼 영역 노출 타입
    var buttonType: EBottomSheetButtonType = .hidden
    
    /// content영역 이외의 영역 터치로 popup을 닫을때 cancel Action 호출 유무
    var cancelActionOnOutsideTouch: Bool = false
    
    private lazy var titleLabel: UILabel = {
        return UILabel().then {
            $0.numberOfLines = 0
            $0.font = .sh2sb18
            $0.textColor = .g100
        }
    }()
     
    private lazy var cancelButton: ClickableUnitButtonComponent = {
        return DealiControl.btnOutlineLarge01().then {
            $0.numberOfLines = 0
        }
    }()
    
    private lazy var confirmButton: ClickableUnitButtonComponent = {
        return DealiControl.btnFilledLarge01().then {
            $0.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
            $0.numberOfLines = 0
        }
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShowNotification(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHideNotification(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardShowNotification(_ notification: NSNotification) {

        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardVisibleHeight = keyboardFrame.cgRectValue.height
        
        self.contentView.snp.remakeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(keyboardVisibleHeight - safeAreaBottomMargin)
        }
        self.view.layoutIfNeeded()
    }
    
    @objc func keyboardHideNotification(_ notification: NSNotification) {

        guard let _ = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        
        self.contentView.snp.remakeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(0.0)
        }
        self.view.layoutIfNeeded()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.do {
            $0.backgroundColor = .clear
        }
        
        if let contentContainerView = self.contentContainerView {
            self.contentStackView.addArrangedSubview(contentContainerView)
            contentContainerView.snp.makeConstraints {
                $0.left.right.equalToSuperview().inset(16.0)
            }
            
            if self.optionType != nil {
                contentContainerView.addSubview(self.collectionView)
                let titleHeight = 60.0
                let buttonContentHeight = self.buttonType == .hidden ? 0 : 74.0 + safeAreaBottomMargin
                let maximumContentHeight = UIScreen.main.bounds.size.height * 0.8 - titleHeight - buttonContentHeight
                
                self.collectionView.then {
                    $0.register(DealiBottomSheetSingleSelectCell.self, forCellWithReuseIdentifier: DealiBottomSheetSingleSelectCell.id)
                    $0.register(DealiBottomSheetMultiSelectCell.self, forCellWithReuseIdentifier: DealiBottomSheetMultiSelectCell.id)
                    $0.register(DealiBottomSheetIconWithTextCell.self, forCellWithReuseIdentifier: DealiBottomSheetIconWithTextCell.id)
                    $0.register(DealiBottomSheetSlotWithTextCell.self, forCellWithReuseIdentifier: DealiBottomSheetSlotWithTextCell.id)
                    
                    $0.delegate = self
                    $0.dataSource = self
                    $0.backgroundColor = .primary04
                }.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview()
                    $0.left.right.equalToSuperview().inset(-16.0)
                    $0.height.equalTo(maximumContentHeight)
                }
            }
            
            if self.buttonType != .hidden {
                self.contentStackView.setCustomSpacing(12.0, after: contentContainerView)
            }
        }
        
        if self.buttonType != .hidden {
            let buttonContainerView = self.buttonContainerView()
            self.contentStackView.addArrangedSubview(buttonContainerView)
            buttonContainerView.snp.makeConstraints {
                $0.left.right.equalToSuperview().inset(16.0)
                $0.bottom.equalToSuperview()
            }
        }
    }
    
    private func buttonContainerView() -> UIView {
        let buttonContainerView = UIView()
        
        let buttonStackView = UIStackView()
        buttonContainerView.addSubview(buttonStackView)
        buttonStackView.then {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillEqually
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12.0)
            $0.left.right.equalToSuperview()
        }
        
        switch self.buttonType {
        case .oneButton(let title):
            buttonStackView.addArrangedSubview(self.confirmButton)
            self.confirmButton.title = title
            self.confirmButton.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
        case .twoButton(let confirmTitle, let cancelTitle, let cancelButtonType):
            self.cancelButton = cancelButtonType == .btnOutlineLarge01 ? DealiControl.btnOutlineLarge01() : DealiControl.btnOutlineLarge06()
            self.cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
            buttonStackView.addArrangedSubview(self.cancelButton)
            self.cancelButton.title = cancelTitle
            self.cancelButton.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
            
            buttonStackView.addArrangedSubview(self.confirmButton)
            self.confirmButton.title = confirmTitle
            self.confirmButton.snp.makeConstraints {
                $0.top.bottom.equalToSuperview()
            }
        default:
            break
        }
        
        return buttonContainerView
    }
    
    @objc func cancelButtonAction() {
        self.hideBottomSheet { [weak self] in
            if let self = self, let action = self.cancelAction {
                action()
            }
        }
    }
    
    @objc func confirmButtonAction() {
        self.hideBottomSheet { [weak self] in
            if let self = self, let action = self.confirmAction {
                action()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, self.contentView.bounds.contains(touch.location(in: self.contentView)) == false, self.closeBottomSheetOnOutsideTouch == true else { return }
        
        if self.cancelActionOnOutsideTouch == true {
            self.cancelButtonAction()
        } else {
            self.hideBottomSheet()
        }
    }
}

extension DealiBottomSheetSystemViewController: UICollectionViewDelegate {
    
}

extension DealiBottomSheetSystemViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.optionData.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch self.optionType {
        case .singleSelect:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DealiBottomSheetSingleSelectCell.id, for: indexPath) as! DealiBottomSheetSingleSelectCell
            var uiModel = DealiBottomSheetSingleSelectCellUIModel.map(optionData: self.optionData[indexPath.item])
            uiModel.selectedActionHandler = { [weak self] in
                guard let self else { return }
                
                if self.shouldDismissWhenSelect {
                    self.hideBottomSheet {
                        self.selectAction?([indexPath.item])
                    }
                } else {
                    self.selectAction?([indexPath.item])
                    self.optionData = self.optionData.map { DealiBottomSheetOptionData(optionName: $0.optionName) }
                    self.optionData[indexPath.item].isSelected = true
                    self.collectionView.reloadData()
                }
            }
            
            cell.configure(with: uiModel)
            return cell
        case .multiSelect:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DealiBottomSheetMultiSelectCell.id, for: indexPath) as! DealiBottomSheetMultiSelectCell
            
            var uiModel = DealiBottomSheetMultiSelectCellUIModel.map(optionData: self.optionData[indexPath.item])
            uiModel.selectedActionHandler = { [weak self] in
                guard let self else { return }
                
                self.optionData[indexPath.item].isSelected.toggle()
                if self.optionData[indexPath.item].isSelected {
                    self.selectAction?([indexPath.item])
                }
                self.collectionView.reloadData()
                
                if self.shouldDismissWhenSelect {
                    self.hideBottomSheet()
                }
            }
            
            cell.configure(with: uiModel)
            return cell
        case .iconWithText:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DealiBottomSheetIconWithTextCell.id, for: indexPath) as! DealiBottomSheetIconWithTextCell
            var uiModel = DealiBottomSheetIconWithTextCellUIModel.map(optionData: self.optionData[indexPath.item])
            uiModel.selectedActionHandler = { [weak self] in
                guard let self else { return }
                
                if self.shouldDismissWhenSelect {
                    self.hideBottomSheet {
                        self.selectAction?([indexPath.item])
                    }
                } else {
                    self.selectAction?([indexPath.item])
                    self.optionData = self.optionData.map { DealiBottomSheetOptionData(optionName: $0.optionName) }
                    self.optionData[indexPath.item].isSelected = true
                    self.collectionView.reloadData()
                }
            }
            
            cell.configure(with: uiModel)
            return cell
        case .slotWithText(let size):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DealiBottomSheetSlotWithTextCell.id, for: indexPath) as! DealiBottomSheetSlotWithTextCell
            var uiModel = DealiBottomSheetSlotWithTextCellUIModel.map(optionData: self.optionData[indexPath.item], slotSize: size.cgSize)
            
            uiModel.selectedActionHandler = { [weak self] in
                guard let self else { return }
                
                if self.shouldDismissWhenSelect {
                    self.hideBottomSheet {
                        self.selectAction?([indexPath.item])
                    }
                } else {
                    self.selectAction?([indexPath.item])
                    self.optionData = self.optionData.map { DealiBottomSheetOptionData(optionName: $0.optionName) }
                    self.optionData[indexPath.item].isSelected = true
                    self.collectionView.reloadData()
                }
            }
            cell.configure(with: uiModel)
            return cell
            
        default:
            return UICollectionViewCell()
        }
        
    }
}

extension DealiBottomSheetSystemViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch self.optionType {
        case .singleSelect:
            return DealiBottomSheetSingleSelectCell.cellSize()
        case .multiSelect:
            return DealiBottomSheetMultiSelectCell.cellSize()
        case .iconWithText:
            return DealiBottomSheetIconWithTextCell.cellSize()
        case .slotWithText(_):
            return DealiBottomSheetSlotWithTextCell.cellSize()
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
