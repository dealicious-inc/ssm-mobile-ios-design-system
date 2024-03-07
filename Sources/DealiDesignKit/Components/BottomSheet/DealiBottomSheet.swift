//
//  DealiBottomSheet.swift
//
//
//  Created by hoji on 2024/03/04.
//

import UIKit

enum EBottomSheetOptionType: Equatable {
    case singleSelect
    case multiSelect
    case iconWithText
    case slotWithText(size: CGSize)
    case textOnly
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
    case twoButton(confirmTitle: String?, cancelTitle: String?)
}

public class DealiBottomSheet: NSObject {
    
    public class func showSingleSelectionType(
        titleType: EBottomSheetTitleType = .hidden,
        buttonType: EBottomSheetButtonType = .hidden,
        option: [DealiBottomSheetOptionData],
        closePopupOnOutsideTouch: Bool = true,
        cancelActionOnOutsideTouch: Bool = false,
        popupPresentingViewController: UIViewController,
        selectAction: (([Int]) -> Void)?,
        cancelAction: (() -> Void)?,
        confirmAction: (() -> Void)?) {
            
            let viewController = DealiBottomSheetBaseViewController().then {
                $0.optionContentView = UIView()
                $0.optionType = .singleSelect
                $0.optionData = option
                $0.titleType = titleType
                $0.buttonType = buttonType
                $0.closePopupOnOutsideTouch = closePopupOnOutsideTouch
                $0.cancelActionOnOutsideTouch = cancelActionOnOutsideTouch
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
        closePopupOnOutsideTouch: Bool = true,
        cancelActionOnOutsideTouch: Bool = false,
        popupPresentingViewController: UIViewController,
        selectAction: (([Int]) -> Void)?,
        cancelAction: (() -> Void)?,
        confirmAction: (() -> Void)?) {
            
            let viewController = DealiBottomSheetBaseViewController().then {
                $0.optionContentView = UIView()
                $0.optionType = .multiSelect
                $0.optionData = option
                $0.titleType = titleType
                $0.buttonType = buttonType
                $0.closePopupOnOutsideTouch = closePopupOnOutsideTouch
                $0.cancelActionOnOutsideTouch = cancelActionOnOutsideTouch
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
        closePopupOnOutsideTouch: Bool = true,
        cancelActionOnOutsideTouch: Bool = false,
        popupPresentingViewController: UIViewController,
        selectAction: (([Int]) -> Void)?,
        cancelAction: (() -> Void)?,
        confirmAction: (() -> Void)?) {
            
            let viewController = DealiBottomSheetBaseViewController().then {
                $0.optionContentView = UIView()
                $0.optionType = .iconWithText
                $0.optionData = option
                $0.titleType = titleType
                $0.buttonType = buttonType
                $0.closePopupOnOutsideTouch = closePopupOnOutsideTouch
                $0.cancelActionOnOutsideTouch = cancelActionOnOutsideTouch
                $0.selectAction = selectAction
                $0.cancelAction = cancelAction
                $0.confirmAction = confirmAction
            }
            
            popupPresentingViewController.present(viewController, animated: false)
        }
    
    public class func showTextOnly(titleType: EBottomSheetTitleType = .hidden,
                                      message: String,
                                      buttonType: EBottomSheetButtonType = .hidden,
                                      closePopupOnOutsideTouch: Bool = true,
                                      cancelActionOnOutsideTouch: Bool = false,
                                      popupPresentingViewController: UIViewController,
                                      cancelAction: (() -> Void)?, 
                                      confirmAction: (() -> Void)?) {
        
        let messageStyle = NSMutableParagraphStyle().then {
            $0.alignment = .left
            $0.lineHeightMultiple = 1.16
        }
        
        let messageLabel = UILabel().then {
            $0.numberOfLines = 0
            $0.attributedText = NSMutableAttributedString(string: message, attributes: [.font: UIFont.b2r14, .foregroundColor: DealiColor.g80, .paragraphStyle: messageStyle])
        }
        
        self.showBottomSheet(titleType: titleType,
                             optionContentView: messageLabel,
                             buttonType: buttonType,
                             closePopupOnOutsideTouch: closePopupOnOutsideTouch,
                             cancelActionOnOutsideTouch: cancelActionOnOutsideTouch,
                             popupPresentingViewController: popupPresentingViewController,
                             cancelAction: cancelAction,
                             confirmAction: confirmAction)
    }
    
    public class func showBottomSheet(titleType: EBottomSheetTitleType = .hidden,
                                      optionContentView: UIView,
                                      buttonType: EBottomSheetButtonType = .hidden,
                                      closePopupOnOutsideTouch: Bool = true,
                                      cancelActionOnOutsideTouch: Bool = false,
                                      popupPresentingViewController: UIViewController,
                                      cancelAction: (() -> Void)?,
                                      confirmAction: (() -> Void)?) {
        
        let viewController = DealiBottomSheetBaseViewController().then {
            $0.optionContentView = optionContentView
            $0.titleType = titleType
            $0.buttonType = buttonType
            $0.closePopupOnOutsideTouch = closePopupOnOutsideTouch
            $0.cancelActionOnOutsideTouch = cancelActionOnOutsideTouch
            $0.cancelAction = cancelAction
            $0.confirmAction = confirmAction
        }
        
        popupPresentingViewController.present(viewController, animated: false)
    }
    
}

class DealiBottomSheetBaseViewController: UIViewController {
    private let contentView = UIView()
    private var cornerLayer: CAShapeLayer?
    private let contentStackView = UIStackView()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    var optionType: EBottomSheetOptionType? = nil
    var optionData: [DealiBottomSheetOptionData] = []
    
    var cancelAction: (() -> Swift.Void)?
    var confirmAction: (() -> Swift.Void)?
    var selectAction: (([Int]) -> Void)?
    
    /// option Content 노출 영역
    var optionContentView: UIView?
    /// 타이들 영역 노출 타입
    var titleType: EBottomSheetTitleType = .hidden
    /// 버튼 영역 노출 타입
    var buttonType: EBottomSheetButtonType = .hidden
    
    /// content영역 이외의 영역 터치시 팝업을 닫을지 유무
    var closePopupOnOutsideTouch: Bool = false
    /// content영역 이외의 영역 터치로 popup을 닫을때 cancel Action 호출 유무
    var cancelActionOnOutsideTouch: Bool = false
    
    private lazy var titleLabel: UILabel = {
        return UILabel().then {
            $0.numberOfLines = 0
            $0.font = .sh2sb18
            $0.textColor = DealiColor.g100
        }
    }()
    
    private lazy var closeButton: UIButton = {
        return UIButton().then {
            $0.setImage(UIImage(named: "ic_x", in: Bundle.module, compatibleWith: nil), for: .normal)
            $0.addTarget(self, action: #selector(closeButtonButtonAction), for: .touchUpInside)
        }
    }()
    
    private lazy var cancelButton: ClickableComponentButton = {
        return DealiControl.btnOutlineLarge01().then {
            $0.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        }
    }()
    
    private lazy var confirmButton: ClickableComponentButton = {
        return DealiControl.btnFilledLarge01().then {
            $0.addTarget(self, action: #selector(confirmButtonAction), for: .touchUpInside)
        }
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showPopup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let cornerLayer = self.cornerLayer {
            cornerLayer.removeFromSuperlayer()
        }
        
        self.cornerLayer = CAShapeLayer().then {
            $0.path = UIBezierPath(roundedRect: contentView.bounds,
                                   byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight],
                                   cornerRadii: CGSize(width: 20.0, height: 20.0)).cgPath
        }
        
        self.contentView.layer.mask = self.cornerLayer
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.do {
            $0.backgroundColor = .clear
        }
        
        self.view.addSubview(self.contentView)
        self.contentView.then {
            $0.backgroundColor = DealiColor.primary04
        }.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.bottom)
            $0.left.right.equalToSuperview()
        }
        
        self.contentView.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 4.0
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(self.titleType == .hidden ? 16.0 : 24.0)
            $0.left.right.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().offset(-(12.0 + safeAreaBottomMargin))
        }
        
        self.setUpTitleSectionUI()
        
        if let optionContentView = self.optionContentView {
            self.contentStackView.addArrangedSubview(optionContentView)
            optionContentView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
            
            if self.optionType != nil {
                optionContentView.addSubview(self.collectionView)
                self.collectionView.then {
                    $0.register(DealiBottomSheetSingleSelectCell.self, forCellWithReuseIdentifier: DealiBottomSheetSingleSelectCell.id)
                    $0.register(DealiBottomSheetMultiSelectCell.self, forCellWithReuseIdentifier: DealiBottomSheetMultiSelectCell.id)
                    $0.register(DealiBottomSheetIconWithTextCell.self, forCellWithReuseIdentifier: DealiBottomSheetIconWithTextCell.id)
                    
                    $0.delegate = self
                    $0.dataSource = self
                }.snp.makeConstraints {
                    $0.edges.equalToSuperview()
                    $0.height.equalTo(200.0)
                }
            }
            
            if self.buttonType != .hidden {
                self.contentStackView.setCustomSpacing(12.0, after: optionContentView)
            }
        }
        
        if self.buttonType != .hidden {
            let buttonContainerView = UIView()
            self.contentStackView.addArrangedSubview(buttonContainerView)
            buttonContainerView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
            
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
            case .twoButton(let confirmTitle, let cancelTitle):
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
        }
        
    }
    
    func setUpTitleSectionUI() {
        if self.titleType != .hidden {
            let titleContainerView = UIView()
            self.contentStackView.addArrangedSubview(titleContainerView)
            titleContainerView.snp.makeConstraints {
                $0.left.right.equalToSuperview()
            }
            
            let titleContainerStackView = UIStackView()
            titleContainerView.addSubview(titleContainerStackView)
            titleContainerStackView.then {
                $0.axis = .horizontal
                $0.alignment = .center
                $0.distribution = .fill
                $0.spacing = 16.0
            }.snp.makeConstraints {
                $0.left.right.equalToSuperview()
                $0.top.equalToSuperview().offset(3.0)
                $0.bottom.equalToSuperview().offset(-13.0)
            }
            
            switch self.titleType {
            case .title(let title):
                titleContainerStackView.addArrangedSubview(self.titleLabel)
                self.titleLabel.text = title
                self.titleLabel.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview()
                }
            case .closeButton:
                titleContainerStackView.addArrangedSubview(self.closeButton)
                self.closeButton.snp.makeConstraints {
                    $0.centerY.equalToSuperview()
                    $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
                }
            case .titleCloseButton(let title):
                titleContainerStackView.addArrangedSubview(self.titleLabel)
                self.titleLabel.text = title
                self.titleLabel.snp.makeConstraints {
                    $0.top.bottom.equalToSuperview()
                }
                
                titleContainerStackView.addArrangedSubview(self.closeButton)
                self.closeButton.snp.makeConstraints {
                    $0.centerY.equalToSuperview()
                    $0.size.equalTo(CGSize(width: 24.0, height: 24.0))
                }
            default:
                break
            }
        }
    }
    
    func showPopup() {
        self.contentView.layoutIfNeeded()
        var contentHeight = self.contentView.bounds.height
        let bottomSheetMaxHeight = (UIScreen.main.bounds.size.height * 0.9)
        if contentHeight > bottomSheetMaxHeight {
            contentHeight = bottomSheetMaxHeight
        }
        
        self.contentView.snp.remakeConstraints {
            $0.bottom.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.height.equalTo(contentHeight)
        }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }
            self.view.backgroundColor = DealiColor.b50
            self.view.layoutIfNeeded()
        }
    }
    
    private func hidePopup(hideHandler: (() -> Void)? = nil) {
        self.contentView.snp.remakeConstraints {
            $0.top.equalTo(view.snp.bottom)
            $0.left.right.equalToSuperview()
            //            $0.height.equalTo(contentHeight)
        }
        
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self else { return }
            self.view.backgroundColor = .clear
            self.view.layoutIfNeeded()
        } completion: { [weak self] finished in
            guard let self else { return }
            self.dismiss(animated: false) {
                guard let handler = hideHandler else { return }
                handler()
            }
        }
    }
    
    @objc func closeButtonButtonAction() {
        if self.cancelActionOnOutsideTouch == true {
            self.cancelButtonAction()
        } else {
            self.hidePopup()
        }
    }
    
    @objc func cancelButtonAction() {
        self.hidePopup { [weak self] in
            if let self = self, let action = self.cancelAction {
                action()
            }
        }
    }
    
    @objc func confirmButtonAction() {
        self.hidePopup { [weak self] in
            if let self = self, let action = self.confirmAction {
                action()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touch = touches.first, self.contentView.bounds.contains(touch.location(in: self.contentView)) == false, self.closePopupOnOutsideTouch == true else { return }
        
        if self.cancelActionOnOutsideTouch == true {
            self.cancelButtonAction()
        } else {
            self.hidePopup()
        }
    }
}

extension DealiBottomSheetBaseViewController: UICollectionViewDelegate {
    
}

extension DealiBottomSheetBaseViewController: UICollectionViewDataSource {
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
                self.selectAction?([indexPath.item])
                self.optionData = self.optionData.map { DealiBottomSheetOptionData(optionName: $0.optionName) }
                self.optionData[indexPath.item].isSelected = true
                self.collectionView.reloadData()
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
            }
            
            cell.configure(with: uiModel)
            return cell
        case .iconWithText:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DealiBottomSheetIconWithTextCell.id, for: indexPath) as! DealiBottomSheetIconWithTextCell
            var uiModel = DealiBottomSheetIconWithTextCellUIModel.map(optionData: self.optionData[indexPath.item])
            uiModel.selectedActionHandler = { [weak self] in
                guard let self else { return }
                self.selectAction?([indexPath.item])
                self.optionData = self.optionData.map { DealiBottomSheetOptionData(optionName: $0.optionName) }
                self.optionData[indexPath.item].isSelected = true
                self.collectionView.reloadData()
            }
            
            cell.configure(with: uiModel)
            return cell
        default:
            return UICollectionViewCell()
        }
        
    }
}

extension DealiBottomSheetBaseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch self.optionType {
        case .singleSelect:
            return DealiBottomSheetSingleSelectCell.cellSize()
        case .multiSelect:
            return DealiBottomSheetMultiSelectCell.cellSize()
        case .iconWithText:
            return DealiBottomSheetIconWithTextCell.cellSize()
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
