//
//  ButtonViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 2023/09/13.
//

import UIKit
import DealiDesignKit
import SnapKit
import SwiftUI

class ButtonViewController: UIViewController {
    
    private let stackView = UIStackView()
    
    private var isSwiftUI: Bool
    
    init(isSwiftUI: Bool = false) {
        self.isSwiftUI = isSwiftUI
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .systemGray2
        
        if !isSwiftUI {
            let switchView = UISwitch()
            let switchItem = UIBarButtonItem(customView: switchView)
            self.navigationItem.rightBarButtonItem = switchItem
            switchView.do {
                $0.onTintColor = .primary01
                $0.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
            }
        }
        
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
        
        contentView.addSubview(self.stackView)
        self.stackView.then {
            $0.axis = .vertical
            $0.spacing = 20.0
            $0.alignment = .center
        }.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20.0)
        }
        
        if isSwiftUI {
            self.addSwiftUIButtons()
            return
        }
        
        let testStackView = UIStackView()
        self.stackView.addArrangedSubview(testStackView)
        testStackView.do {
            $0.axis = .horizontal
            $0.spacing = 20.0
            $0.alignment = .fill
        }
        
        for i in 0..<2 {
            let label = UILabel()
            testStackView.addArrangedSubview(label)
            label.do {
                $0.text = "test_\(i)"
            }
        }
        
        let testButton = DealiControl.btnFilledLarge03()
        testStackView.addArrangedSubview(testButton)
        testButton.do {
            $0.isFixedSize = true
            $0.title = "PDF 다운로드"
            $0.leftImage = ClickableImage(UIImage.dealiIcon(named: "ic_download_2")?.resize(CGSize(width: 16.0, height: 16.0)))
        }
        
        var buttonArray: [UIView] = []

        let largeButtonArray: [UIView] = [DealiControl.btnFilledLarge01(),
                                          DealiControl.btnFilledLarge02(),
                                          DealiControl.btnFilledLarge03(),
                                          DealiControl.btnFilledLarge04(),
                                          DealiControl.btnFilledLarge05(),
                                          DealiControl.btnFilledLarge06(),
                                          DealiControl.btnFilledRoundLarge01(),
                                          DealiControl.btnFilledRoundLarge02(),
                                          DealiControl.btnFilledRoundLarge03(),
                                          DealiControl.btnFilledTonalLarge01(),
                                          DealiControl.btnFilledTonalLarge02(),
                                          DealiControl.btnFilledTonalLarge03(),
                                          DealiControl.btnFilledTonalLarge04(),
                                          DealiControl.btnFilledTonalLarge05(),
                                          DealiControl.btnFilledTonalLarge06(),
                                          DealiControl.btnOutlineLarge01(),
                                          DealiControl.btnOutlineLarge02(),
                                          DealiControl.btnOutlineLarge03(),
                                          DealiControl.btnOutlineLarge04(),
                                          DealiControl.btnOutlineLarge05(),
                                          DealiControl.btnOutlineLarge06(),
                                          DealiControl.btnOutlineBgLarge01(),
                                          DealiControl.btnOutlineBgLarge03(),
                                          DealiControl.btnOutlineBgLarge04(),
                                          DealiControl.btnOutlineBgLarge05(),
                                          DealiControl.btnOutlineBgLarge06(),
                                          DealiControl.btnTextLarge01(),
                                          DealiControl.btnTextLarge02(),
                                          DealiControl.btnTextLarge03(),
                                          DealiControl.btnTextLarge04(),
                                          DealiControl.btnTextLarge05(),
                                          DealiControl.btnTextLarge06(),
                                          DealiControl.btnTextLarge07()
        ]

        let mediumButtonArray: [UIView] = [DealiControl.btnFilledMedium01(),
                                           DealiControl.btnFilledMedium02(),
                                           DealiControl.btnFilledMedium03(),
                                           DealiControl.btnFilledMedium04(),
                                           DealiControl.btnFilledMedium05(),
                                           DealiControl.btnFilledMedium06(),
                                           DealiControl.btnFilledRoundMedium01(),
                                           DealiControl.btnFilledRoundMedium02(),
                                           DealiControl.btnFilledRoundMedium03(),
                                           DealiControl.btnFilledTonalMedium01(),
                                           DealiControl.btnFilledTonalMedium02(),
                                           DealiControl.btnFilledTonalMedium03(),
                                           DealiControl.btnFilledTonalMedium04(),
                                           DealiControl.btnFilledTonalMedium05(),
                                           DealiControl.btnFilledTonalMedium06(),
                                           DealiControl.btnOutlineMedium01(),
                                           DealiControl.btnOutlineMedium02(),
                                           DealiControl.btnOutlineMedium03(),
                                           DealiControl.btnOutlineMedium04(),
                                           DealiControl.btnOutlineMedium05(),
                                           DealiControl.btnOutlineMedium06(),
                                           DealiControl.btnOutlineBgMedium01(),
                                           DealiControl.btnOutlineBgMedium03(),
                                           DealiControl.btnOutlineBgMedium04(),
                                           DealiControl.btnOutlineBgMedium05(),
                                           DealiControl.btnOutlineBgMedium06(),
                                           DealiControl.btnTextMedium01(),
                                           DealiControl.btnTextMedium02(),
                                           DealiControl.btnTextMedium03(), 
                                           DealiControl.btnTextMedium04(),
                                           DealiControl.btnTextMedium05(),
                                           DealiControl.btnTextMedium06(),
                                           DealiControl.btnTextMedium07()
                                             ]
        
        let semiMediumButtonArray: [UIView] = [DealiControl.btnFilledSemiMedium01(),
                                               DealiControl.btnFilledSemiMedium02(),
                                               DealiControl.btnFilledSemiMedium03(),
                                               DealiControl.btnFilledSemiMedium04(),
                                               DealiControl.btnFilledSemiMedium05(),
                                               DealiControl.btnFilledSemiMedium06(),
                                               DealiControl.btnFilledRoundSemiMedium01(),
                                               DealiControl.btnFilledRoundSemiMedium02(),
                                               DealiControl.btnFilledRoundSemiMedium03(),
                                               DealiControl.btnFilledTonalSemiMedium01(),
                                               DealiControl.btnFilledTonalSemiMedium02(),
                                               DealiControl.btnFilledTonalSemiMedium03(),
                                               DealiControl.btnFilledTonalSemiMedium04(),
                                               DealiControl.btnFilledTonalSemiMedium05(),
                                               DealiControl.btnOutlineSemiMedium01(),
                                               DealiControl.btnOutlineSemiMedium02(),
                                               DealiControl.btnOutlineSemiMedium03(),
                                               DealiControl.btnOutlineSemiMedium04(),
                                               DealiControl.btnOutlineSemiMedium05(),
                                               DealiControl.btnOutlineSemiMedium06(),
                                               DealiControl.btnOutlineBgSemiMedium01(),
                                               DealiControl.btnOutlineBgSemiMedium03(),
                                               DealiControl.btnOutlineBgSemiMedium04(),
                                               DealiControl.btnOutlineBgSemiMedium05(),
                                               DealiControl.btnTextSemiMedium01(),
                                               DealiControl.btnTextSemiMedium02(),
                                               DealiControl.btnTextSemiMedium03(),
                                               DealiControl.btnTextSemiMedium04(),
                                               DealiControl.btnTextSemiMedium05(),
                                               DealiControl.btnTextSemiMedium06(),
                                               DealiControl.btnTextSemiMedium07()
                                           ]
        
        let smallButtonArray: [UIView] = [DealiControl.btnFilledSmall01(),
                                          DealiControl.btnFilledSmall02(),
                                          DealiControl.btnFilledSmall03(),
                                          DealiControl.btnFilledSmall04(),
                                          DealiControl.btnFilledSmall05(),
                                          DealiControl.btnFilledSmall06(),
                                          DealiControl.btnFilledRoundSmall01(),
                                          DealiControl.btnFilledRoundSmall02(),
                                          DealiControl.btnFilledRoundSmall03(),
                                          DealiControl.btnFilledTonalSmall01(),
                                          DealiControl.btnFilledTonalSmall02(),
                                          DealiControl.btnFilledTonalSmall03(),
                                          DealiControl.btnFilledTonalSmall04(),
                                          DealiControl.btnFilledTonalSmall05(),
                                          DealiControl.btnFilledTonalSmall06(),
                                          DealiControl.btnFilledTonalRoundSmall01(),
                                          DealiControl.btnFilledTonalRoundSmall02(),
                                          DealiControl.btnFilledTonalRoundSmall03(),
                                          DealiControl.btnFilledTonalRoundSmall04(),
                                          DealiControl.btnFilledTonalRoundSmall05(),
                                          DealiControl.btnFilledTonalRoundSmall06(),
                                          DealiControl.btnOutlineSmall01(),
                                          DealiControl.btnOutlineSmall02(),
                                          DealiControl.btnOutlineSmall03(),
                                          DealiControl.btnOutlineSmall04(),
                                          DealiControl.btnOutlineSmall05(),
                                          DealiControl.btnOutlineSmall06(),
                                          DealiControl.btnOutlineBgSmall01(),
                                          DealiControl.btnOutlineBgSmall03(),
                                          DealiControl.btnOutlineBgSmall04(),
                                          DealiControl.btnOutlineBgSmall05(),
                                          DealiControl.btnOutlineBgSmall06(),
                                          DealiControl.btnOutlineRoundBgSmall01(),
                                          DealiControl.btnOutlineRoundBgSmall03(),
                                          DealiControl.btnOutlineRoundBgSmall04(),
                                          DealiControl.btnOutlineRoundBgSmall05(),
                                          DealiControl.btnOutlineRoundBgSmall06(),
                                          DealiControl.btnTextSmall01(),
                                          DealiControl.btnTextSmall02(),
                                          DealiControl.btnTextSmall03(),
                                          DealiControl.btnTextSmall04(),
                                          DealiControl.btnTextSmall05(),
                                          DealiControl.btnTextSmall06(),
                                          DealiControl.btnTextSmall07()
                                        ]
        
        
        buttonArray += largeButtonArray
        buttonArray += mediumButtonArray
        buttonArray += semiMediumButtonArray
        buttonArray += smallButtonArray
        
        
        buttonArray.forEach { button in
           if let new = button as? ClickableComponent {
//               new.rightImage = ClickableImage(named: "ic_arrow_right")
//               new.leftImage = ClickableImage(named: "img_mbs_filled_16_ver01")
               
//                switch Int.random(in: 0...2) {
//                case 0:
//                    new.leftImage = ClickableImage(UIImage(named: "img_mbs_filled_16_ver01"))
//                case 1:
//                    new.rightImage = ClickableImage(named: "ic_arrow_right")
//                default:
//                    new.leftImage = ClickableImage(named: "img_mbs_filled_16_ver01", needOriginColor: true)
//                    new.rightImage = ClickableImage(named: "ic_arrow_right")
//                }
            }
            
            self.stackView.addArrangedSubview(button)
        }

    }
    
    @objc func btnTextMediumPrimary02Pressed(_ sender: ClickableComponentButton) {
     
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func switchValueChanged(_ swc: UISwitch) {
        self.stackView.subviews.forEach { view in
            if let b = view as? ClickableComponentButton {
//                b.isEnabled = !swc.isOn
                if swc.isOn {
                    b.startIndicator()
                } else {
                    b.stopIndicator()
                }
            }
        }
        
    }
    
}

extension ButtonViewController {
    func addSwiftUIStyleButtons() {
        let loadingStackview = UIStackView()
        loadingStackview.do {
            $0.spacing = 10
            $0.axis = .horizontal
        }
        
        #warning("좋은 호스팅 업데이트방법이 없을까...")
        let button = ButtonView()
        let buttonHosting = button.hosting()
        button
            .btnFilledLarge01()
            .setTitle("ButtonLoadingTest")
            .setLoading(false)
            .addAction {
                buttonHosting.updateView(button.setLoading(true))
            }
        loadingStackview.addArrangedSubview(
            button.UIKit()
        )
        
        let buttonOn = ButtonView().btnOutlineBgLarge01().setTitle("On")
            .addAction {
                buttonHosting.updateView(button.setLoading(true))
            }
            .UIKit()
        loadingStackview.addArrangedSubview(buttonOn)
        
        let buttonOff = ButtonView().btnOutlineBgLarge01().setTitle("Off")
            .addAction {
                buttonHosting.updateView(button.setLoading(false))
            }
            .UIKit()
        loadingStackview.addArrangedSubview(buttonOff)
        
        self.stackView.addArrangedSubview(loadingStackview)
        
        self.stackView.addArrangedSubview(
            ButtonView()
                .btnFilledLarge01()
                .setTitle("Button Disabled")
                .setEnabled(false)
                .UIKit()
        )
    }
    
    func addSwiftUIButtons() {
        addSwiftUIStyleButtons()
        
        var buttonArray: [UIView] = []
        
        let largeButtonArray: [UIView] = [
            ButtonView().btnFilledLarge01().setTitle("btnFilledLarge01").UIKit(),
            ButtonView().btnFilledLarge02().setTitle("btnFilledLarge02").UIKit(),
            ButtonView().btnFilledLarge03().setTitle("btnFilledLarge03").UIKit(),
            ButtonView().btnFilledLarge04().setTitle("btnFilledLarge04").UIKit(),
            ButtonView().btnFilledLarge05().setTitle("btnFilledLarge05").UIKit(),
            ButtonView().btnFilledLarge06().setTitle("btnFilledLarge06").UIKit(),
            
            ButtonView().btnFilledRoundLarge01().setTitle("btnFilledRoundLarge01").UIKit(),
            ButtonView().btnFilledRoundLarge02().setTitle("btnFilledRoundLarge02").UIKit(),
            ButtonView().btnFilledRoundLarge03().setTitle("btnFilledRoundLarge03").UIKit(),
            ButtonView().btnFilledRoundLarge01().setTitle("btnFilledRoundLarge01").UIKit(),
            
            ButtonView().btnFilledTonalLarge01().setTitle("btnFilledTonalLarge01").UIKit(),
            ButtonView().btnFilledTonalLarge02().setTitle("btnFilledTonalLarge02").UIKit(),
            ButtonView().btnFilledTonalLarge03().setTitle("btnFilledTonalLarge03").UIKit(),
            ButtonView().btnFilledTonalLarge04().setTitle("btnFilledTonalLarge04").UIKit(),
            ButtonView().btnFilledTonalLarge05().setTitle("btnFilledTonalLarge05").UIKit(),
            ButtonView().btnFilledTonalLarge06().setTitle("btnFilledTonalLarge06").UIKit(),
            
            ButtonView().btnOutlineLarge01().setTitle("btnOutlineLarge01").UIKit(),
            ButtonView().btnOutlineLarge02().setTitle("btnOutlineLarge02").UIKit(),
            ButtonView().btnOutlineLarge03().setTitle("btnOutlineLarge03").UIKit(),
            ButtonView().btnOutlineLarge04().setTitle("btnOutlineLarge04").UIKit(),
            ButtonView().btnOutlineLarge05().setTitle("btnOutlineLarge05").UIKit(),
            ButtonView().btnOutlineLarge06().setTitle("btnOutlineLarge06").UIKit(),
            
            ButtonView().btnOutlineBgLarge01().setTitle("btnOutlineBgLarge01").UIKit(),
            ButtonView().btnOutlineBgLarge03().setTitle("btnOutlineBgLarge03").UIKit(),
            ButtonView().btnOutlineBgLarge04().setTitle("btnOutlineBgLarge04").UIKit(),
            ButtonView().btnOutlineBgLarge05().setTitle("btnOutlineBgLarge05").UIKit(),
            ButtonView().btnOutlineBgLarge06().setTitle("btnOutlineBgLarge06").UIKit(),
            
            ButtonView().btnTextLarge01().setTitle("btnTextLarge01").UIKit(),
            ButtonView().btnTextLarge02().setTitle("btnTextLarge02").UIKit(),
            ButtonView().btnTextLarge03().setTitle("btnTextLarge03").UIKit(),
            ButtonView().btnTextLarge04().setTitle("btnTextLarge04").UIKit(),
            ButtonView().btnTextLarge05().setTitle("btnTextLarge05").UIKit(),
            ButtonView().btnTextLarge06().setTitle("btnTextLarge06").UIKit(),
            ButtonView().btnTextLarge07().setTitle("btnTextLarge07").UIKit()
        ]
        
        let mediumButtonArray: [UIView] = [
            ButtonView().btnFilledMedium01().setTitle("btnFilledMedium01").UIKit(),
            ButtonView().btnFilledMedium02().setTitle("btnFilledMedium02").UIKit(),
            ButtonView().btnFilledMedium03().setTitle("btnFilledMedium03").UIKit(),
            ButtonView().btnFilledMedium04().setTitle("btnFilledMedium04").UIKit(),
            ButtonView().btnFilledMedium05().setTitle("btnFilledMedium05").UIKit(),
            ButtonView().btnFilledMedium06().setTitle("btnFilledMedium06").UIKit(),
            
            ButtonView().btnFilledRoundMedium01().setTitle("btnFilledRoundMedium01").UIKit(),
            ButtonView().btnFilledRoundMedium02().setTitle("btnFilledRoundMedium02").UIKit(),
            ButtonView().btnFilledRoundMedium03().setTitle("btnFilledRoundMedium03").UIKit(),
            
            ButtonView().btnFilledTonalMedium01().setTitle("btnFilledTonalMedium01").UIKit(),
            ButtonView().btnFilledTonalMedium02().setTitle("btnFilledTonalMedium02").UIKit(),
            ButtonView().btnFilledTonalMedium03().setTitle("btnFilledTonalMedium03").UIKit(),
            ButtonView().btnFilledTonalMedium04().setTitle("btnFilledTonalMedium04").UIKit(),
            ButtonView().btnFilledTonalMedium05().setTitle("btnFilledTonalMedium05").UIKit(),
            ButtonView().btnFilledTonalMedium06().setTitle("btnFilledTonalMedium06").UIKit(),
            
            ButtonView().btnOutlineMedium01().setTitle("btnOutlineMedium01").UIKit(),
            ButtonView().btnOutlineMedium02().setTitle("btnOutlineMedium02").UIKit(),
            ButtonView().btnOutlineMedium03().setTitle("btnOutlineMedium03").UIKit(),
            ButtonView().btnOutlineMedium04().setTitle("btnOutlineMedium04").UIKit(),
            ButtonView().btnOutlineMedium05().setTitle("btnOutlineMedium05").UIKit(),
            ButtonView().btnOutlineMedium06().setTitle("btnOutlineMedium06").UIKit(),
            
            ButtonView().btnOutlineBgMedium01().setTitle("btnOutlineBgMedium01").UIKit(),
            ButtonView().btnOutlineBgMedium03().setTitle("btnOutlineBgMedium03").UIKit(),
            ButtonView().btnOutlineBgMedium04().setTitle("btnOutlineBgMedium04").UIKit(),
            ButtonView().btnOutlineBgMedium05().setTitle("btnOutlineBgMedium05").UIKit(),
            ButtonView().btnOutlineBgMedium06().setTitle("btnOutlineBgMedium06").UIKit(),
            
            ButtonView().btnTextMedium01().setTitle("btnTextMedium01").UIKit(),
            ButtonView().btnTextMedium02().setTitle("btnTextMedium02").UIKit(),
            ButtonView().btnTextMedium03().setTitle("btnTextMedium03").UIKit(),
            ButtonView().btnTextMedium04().setTitle("btnTextMedium04").UIKit(),
            ButtonView().btnTextMedium05().setTitle("btnTextMedium05").UIKit(),
            ButtonView().btnTextMedium06().setTitle("btnTextMedium06").UIKit(),
            ButtonView().btnTextMedium07().setTitle("btnTextMedium07").UIKit()
        ]
        let semiMediumButtonArray: [UIView] = [
            ButtonView().btnFilledSemiMedium01().setTitle("btnFilledSemiMedium01").UIKit(),
            ButtonView().btnFilledSemiMedium02().setTitle("btnFilledSemiMedium02").UIKit(),
            ButtonView().btnFilledSemiMedium03().setTitle("btnFilledSemiMedium03").UIKit(),
            ButtonView().btnFilledSemiMedium04().setTitle("btnFilledSemiMedium04").UIKit(),
            ButtonView().btnFilledSemiMedium05().setTitle("btnFilledSemiMedium05").UIKit(),
            ButtonView().btnFilledSemiMedium06().setTitle("btnFilledSemiMedium06").UIKit(),
            
            ButtonView().btnFilledRoundSemiMedium01().setTitle("btnFilledRoundSemiMedium01").UIKit(),
            ButtonView().btnFilledRoundSemiMedium02().setTitle("btnFilledRoundSemiMedium02").UIKit(),
            ButtonView().btnFilledRoundSemiMedium03().setTitle("btnFilledRoundSemiMedium03").UIKit(),
            
            ButtonView().btnFilledTonalSemiMedium01().setTitle("btnFilledTonalSemiMedium01").UIKit(),
            ButtonView().btnFilledTonalSemiMedium02().setTitle("btnFilledTonalSemiMedium02").UIKit(),
            ButtonView().btnFilledTonalSemiMedium03().setTitle("btnFilledTonalSemiMedium03").UIKit(),
            ButtonView().btnFilledTonalSemiMedium04().setTitle("btnFilledTonalSemiMedium04").UIKit(),
            ButtonView().btnFilledTonalSemiMedium05().setTitle("btnFilledTonalSemiMedium05").UIKit(),
            ButtonView().btnFilledTonalSemiMedium06().setTitle("btnFilledTonalSemiMedium06").UIKit(),
            
            ButtonView().btnOutlineSemiMedium01().setTitle("btnOutlineSemiMedium01").UIKit(),
            ButtonView().btnOutlineSemiMedium02().setTitle("btnOutlineSemiMedium02").UIKit(),
            ButtonView().btnOutlineSemiMedium03().setTitle("btnOutlineSemiMedium03").UIKit(),
            ButtonView().btnOutlineSemiMedium04().setTitle("btnOutlineSemiMedium04").UIKit(),
            ButtonView().btnOutlineSemiMedium05().setTitle("btnOutlineSemiMedium05").UIKit(),
            ButtonView().btnOutlineSemiMedium06().setTitle("btnOutlineSemiMedium06").UIKit(),
            
            ButtonView().btnOutlineBgSemiMedium01().setTitle("btnOutlineBgSemiMedium01").UIKit(),
            ButtonView().btnOutlineBgSemiMedium03().setTitle("btnOutlineBgSemiMedium03").UIKit(),
            ButtonView().btnOutlineBgSemiMedium04().setTitle("btnOutlineBgSemiMedium04").UIKit(),
            ButtonView().btnOutlineBgSemiMedium05().setTitle("btnOutlineBgSemiMedium05").UIKit(),
            ButtonView().btnOutlineBgSemiMedium06().setTitle("btnOutlineBgSemiMedium06").UIKit(),
            
            ButtonView().btnTextSemiMedium01().setTitle("btnTextSemiMedium01").UIKit(),
            ButtonView().btnTextSemiMedium02().setTitle("btnTextSemiMedium02").UIKit(),
            ButtonView().btnTextSemiMedium03().setTitle("btnTextSemiMedium03").UIKit(),
            ButtonView().btnTextSemiMedium04().setTitle("btnTextSemiMedium04").UIKit(),
            ButtonView().btnTextSemiMedium05().setTitle("btnTextSemiMedium05").UIKit(),
            ButtonView().btnTextSemiMedium06().setTitle("btnTextSemiMedium06").UIKit(),
            ButtonView().btnTextSemiMedium07().setTitle("btnTextSemiMedium07").UIKit()
        ]
        let smallButtonArray: [UIView] = [
            ButtonView().btnFilledSmall01().setTitle("btnFilledSmall01").UIKit(),
            ButtonView().btnFilledSmall02().setTitle("btnFilledSmall02").UIKit(),
            ButtonView().btnFilledSmall03().setTitle("btnFilledSmall03").UIKit(),
            ButtonView().btnFilledSmall04().setTitle("btnFilledSmall04").UIKit(),
            ButtonView().btnFilledSmall05().setTitle("btnFilledSmall05").UIKit(),
            ButtonView().btnFilledSmall06().setTitle("btnFilledSmall06").UIKit(),
            
            ButtonView().btnFilledRoundSmall01().setTitle("btnFilledRoundSmall01").UIKit(),
            ButtonView().btnFilledRoundSmall02().setTitle("btnFilledRoundSmall02").UIKit(),
            ButtonView().btnFilledRoundSmall03().setTitle("btnFilledRoundSmall03").UIKit(),
            
            ButtonView().btnFilledTonalSmall01().setTitle("btnFilledTonalSmall01").UIKit(),
            ButtonView().btnFilledTonalSmall02().setTitle("btnFilledTonalSmall02").UIKit(),
            ButtonView().btnFilledTonalSmall03().setTitle("btnFilledTonalSmall03").UIKit(),
            ButtonView().btnFilledTonalSmall04().setTitle("btnFilledTonalSmall04").UIKit(),
            ButtonView().btnFilledTonalSmall05().setTitle("btnFilledTonalSmall05").UIKit(),
            ButtonView().btnFilledTonalSmall06().setTitle("btnFilledTonalSmall06").UIKit(),
            
            ButtonView().btnOutlineSmall01().setTitle("btnOutlineSmall01").UIKit(),
            ButtonView().btnOutlineSmall02().setTitle("btnOutlineSmall02").UIKit(),
            ButtonView().btnOutlineSmall03().setTitle("btnOutlineSmall03").UIKit(),
            ButtonView().btnOutlineSmall04().setTitle("btnOutlineSmall04").UIKit(),
            ButtonView().btnOutlineSmall05().setTitle("btnOutlineSmall05").UIKit(),
            ButtonView().btnOutlineSmall06().setTitle("btnOutlineSmall06").UIKit(),
            
            ButtonView().btnOutlineBgSmall01().setTitle("btnOutlineBgSmall01").UIKit(),
            ButtonView().btnOutlineBgSmall03().setTitle("btnOutlineBgSmall03").UIKit(),
            ButtonView().btnOutlineBgSmall04().setTitle("btnOutlineBgSmall04").UIKit(),
            ButtonView().btnOutlineBgSmall05().setTitle("btnOutlineBgSmall05").UIKit(),
            ButtonView().btnOutlineBgSmall06().setTitle("btnOutlineBgSmall06").UIKit(),
            
            ButtonView().btnTextSmall01().setTitle("btnTextSmall01").UIKit(),
            ButtonView().btnTextSmall02().setTitle("btnTextSmall02").UIKit(),
            ButtonView().btnTextSmall03().setTitle("btnTextSmall03").UIKit(),
            ButtonView().btnTextSmall04().setTitle("btnTextSmall04").UIKit(),
            ButtonView().btnTextSmall05().setTitle("btnTextSmall05").UIKit(),
            ButtonView().btnTextSmall06().setTitle("btnTextSmall06").UIKit(),
            ButtonView().btnTextSmall07().setTitle("btnTextSmall07").UIKit()
        ]
        
        buttonArray += largeButtonArray
        buttonArray += mediumButtonArray
        buttonArray += semiMediumButtonArray
        buttonArray += smallButtonArray
        
        buttonArray.forEach { button in
            self.stackView.addArrangedSubview(button)
        }
    }
}

extension UIImage {
    public func resize(_ size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
