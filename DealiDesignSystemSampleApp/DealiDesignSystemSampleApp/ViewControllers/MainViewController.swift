//
//  MainViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이남준 on 2023/05/17.
//

import UIKit
import RxSwift

import DealiDesignKit

final class MainViewController: UIViewController {
    
    private let contentStackView = UIStackView()
    private var componentButtonArray: [ClickableComponentButton] = []
    
    override func loadView() {
        self.view = .init()
        
        self.view.backgroundColor = .primary04
        
        self.navigationItem.backButtonTitle = "Home"
        self.title = "iOS Design System Sample App"
        
        let scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        contentView.addSubview(self.contentStackView)
        self.contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30.0)
            $0.left.right.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview()
        }
        
        let playgroundButton = DealiControl.btnFilledTonalLarge03()
        contentStackView.addArrangedSubview(playgroundButton)
        playgroundButton.do {
            $0.title = "Playground"
            $0.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        }
        
        self.addComponentsButtons()
        self.setComponentBtnsStorerdByTitle()
    }
    
    private func setComponentBtnsStorerdByTitle() {
        let sortedButtons = self.componentButtonArray.sorted { (button1, button2) -> Bool in
            let title1 = button1.title ?? ""
            let title2 = button2.title ?? ""
            return title1 < title2
        }
        
        sortedButtons.forEach { self.contentStackView.addArrangedSubview($0) }
    }
    
    private func addComponents(title: String, actionSelector: Selector) {
        let accordionComponents = DealiControl.btnOutlineLarge03()
        self.componentButtonArray.append(accordionComponents)
        accordionComponents.do {
            $0.title = title
            $0.addTarget(self, action: actionSelector, for: .touchUpInside)
        }
    }
    
    private func addComponentsButtons() {
        self.addComponents(title: "TabBar Controller", actionSelector: #selector(tabBarViewControllerPressed))
        self.addComponents(title: "Typography", actionSelector: #selector(typoButtonPressed))
        self.addComponents(title: "Font", actionSelector: #selector(fontComponentButtonPressed))
        self.addComponents(title: "Color", actionSelector: #selector(colorButtonPressed))
        self.addComponents(title: "BottomSheetPopup", actionSelector: #selector(bottomSheetPopupButtonPressed))
        self.addComponents(title: "Alert", actionSelector: #selector(alertButtonPressed))
        self.addComponents(title: "RadioButton", actionSelector: #selector(radioButtonPressed))
        self.addComponents(title: "Button Components", actionSelector: #selector(buttonComponentButtonPressed))
        self.addComponents(title: "TextLink Components", actionSelector: #selector(textLinkComponentButtonPressed))
        self.addComponents(title: "Chip Components", actionSelector: #selector(chipButtonPressed))
        self.addComponents(title: "Image Chip Components", actionSelector: #selector(imageChipButtonPressed))
        self.addComponents(title: "Toggle/Switch", actionSelector: #selector(toggleButtonPressed))
        self.addComponents(title: "SliderBar", actionSelector: #selector(sliderBarButtonPressed))
        self.addComponents(title: "TextInput Components", actionSelector: #selector(textInputButtonPressed))
        self.addComponents(title: "TextArea Components", actionSelector: #selector(textAreaButtonPressed))
        self.addComponents(title: "SearchInput Components", actionSelector: #selector(searchInputButtonPressed))
        self.addComponents(title: "Tag Components", actionSelector: #selector(tagButtonPressed))
        self.addComponents(title: "Check Components", actionSelector: #selector(checkComponentsPressed))
        self.addComponents(title: "Indicator Components", actionSelector: #selector(indicatorComponentsPressed))
        self.addComponents(title: "Empty Components", actionSelector: #selector(emptyComponentsPressed))
        self.addComponents(title: "Labeled Text Components", actionSelector: #selector(labeledTextComponentsPressed))
        self.addComponents(title: "Accordion Components", actionSelector: #selector(accordionComponentsPressed))
        self.addComponents(title: "PlaceholderImageView Components", actionSelector: #selector(placeholderImageViewComponentsPressed))
        self.addComponents(title: "Notice Components", actionSelector: #selector(noticeComponentsPressed))
    }
}

// MARK: - Button Actions
extension MainViewController {
    
    @objc func tabBarViewControllerPressed() {
        self.pushViewController(TabBarViewController())
    }
    
    @objc func buttonComponentButtonPressed() {
        self.pushViewController(ButtonViewController())
    }
    
    @objc func textLinkComponentButtonPressed() {
        self.pushViewController(TextLinkViewController())
    }
    
    @objc func colorButtonPressed() {
        self.pushViewController(ColorViewController())
    }
    
    @objc func playButtonPressed() {
        self.pushViewController(DealiPlaygroundViewController())
    }
    
    @objc func typoButtonPressed() {
        self.pushViewController(TypographyViewController())
    }
    
    @objc func fontComponentButtonPressed() {
        self.pushViewController(FontComponentViewController())
    }
    
    @objc func bottomSheetPopupButtonPressed() {
        self.pushViewController(BottomSheetPopupTestViewController())
    }
    
    @objc func alertButtonPressed() {
        self.pushViewController(AlertTestViewController())
    }
    
    @objc func radioButtonPressed() {
        self.pushViewController(RadioButtonViewController())
    }
    
    @objc func chipButtonPressed() {
        self.pushViewController(ChipViewController())
    }
    
    @objc func imageChipButtonPressed() {
        self.pushViewController(ImageChipViewController())
    }
    
    @objc func textInputButtonPressed() {
        self.pushViewController(TextInputViewController())
    }
    
    @objc func textAreaButtonPressed() {
        self.pushViewController(TextAreaViewController())
    }
    
    @objc func searchInputButtonPressed() {
        self.pushViewController(SearchInputViewController())
    }
    
    @objc func toggleButtonPressed() {
        self.pushViewController(SwitchViewController())
    }
    
    @objc func sliderBarButtonPressed() {
        self.pushViewController(SliderBarViewController())
    }
    
    @objc func tagButtonPressed() {
        self.pushViewController(TagViewController())
    }
    
    @objc func checkComponentsPressed() {
        self.pushViewController(CheckComponentViewController())
    }
    
    @objc func indicatorComponentsPressed() {
        self.pushViewController(IndicatorViewController())
    }
    
    @objc func emptyComponentsPressed() {
        self.pushViewController(EmptyComponentViewController())
    }
    
    @objc func labeledTextComponentsPressed() {
        self.pushViewController(LabeledTextComponentViewController())
    }
    
    @objc func accordionComponentsPressed() {
        self.pushViewController(AccordionComponentViewController())
    }
  
    @objc func placeholderImageViewComponentsPressed() {
        self.pushViewController(PlaceholderImageViewController())
    }
    
    @objc func noticeComponentsPressed() {
        self.pushViewController(NoticeViewController())
    }
}

//MARK: - UIViewController Extension
extension UIViewController {
    func pushViewController(_ viewController: UIViewController) {
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
