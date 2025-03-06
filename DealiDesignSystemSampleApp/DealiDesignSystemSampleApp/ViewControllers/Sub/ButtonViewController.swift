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
        self.title = "Button"
        
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
        // Loading
        let loadingStackview = UIStackView()
        loadingStackview.do {
            $0.spacing = 10
            $0.axis = .horizontal
        }
        
        let loadingButton = ButtonView()
        loadingButton
            .setStyle(.btnFilledLarge01)
            .setTitle("setLoading")
            .setLoading(false)
            .addAction {
                loadingButton.toggleLoading()
            }
        loadingStackview.addArrangedSubview(
            loadingButton.UIKit()
        )
        
        let buttonOn = ButtonView()
            .setStyle(.btnOutlineBgLarge01)
            .setTitle("On")
            .addAction {
                loadingButton.setLoading(true)
            }
            .UIKit()
        loadingStackview.addArrangedSubview(buttonOn)
        
        let buttonOff = ButtonView()
            .setStyle(.btnOutlineBgLarge01)
            .setTitle("Off")
            .addAction {
                loadingButton.setLoading(false)
            }
            .UIKit()
        loadingStackview.addArrangedSubview(buttonOff)
        
        self.stackView.addArrangedSubview(loadingStackview)
        
        // Enabled
        let enabledButtonStackview = UIStackView()
        enabledButtonStackview.do {
            $0.spacing = 10
            $0.axis = .horizontal
        }
        
        let enabledButton = ButtonView()
            .setStyle(.btnFilledLarge01)
            .setTitle("isEnabled True")
        
        enabledButtonStackview.addArrangedSubview(
            enabledButton.UIKit()
        )
        
        enabledButtonStackview.addArrangedSubview(
            ButtonView()
                .setStyle(.btnOutlineBgLarge01)
                .setTitle("Enabled")
                .addAction {
                    enabledButton.setEnabled(true)
                    enabledButton.setTitle("isEnabled True")
                }
                .UIKit()
        )
        
        enabledButtonStackview.addArrangedSubview(
            ButtonView()
                .setStyle(.btnOutlineBgLarge01)
                .setTitle("Disabled")
                .addAction {
                    enabledButton.setEnabled(false)
                    enabledButton.setTitle("isEnabled False")
                }
                .UIKit()
        )
        
        self.stackView.addArrangedSubview(enabledButtonStackview)
        
        // Image
        let imageButtonStackview = UIStackView()
        imageButtonStackview.do {
            $0.spacing = 10
            $0.axis = .horizontal
        }
        let image = UIImage.dealiIcon(named: "ic_download_2")?.resize(CGSize(width: 16.0, height: 16.0))
        
        imageButtonStackview.addArrangedSubview(
            ButtonView()
                .setStyle(.btnFilledSemiMedium01)
                .setTitle("Left Image")
                .setTitleAlignment(.leading)
                .setLeftImage(image)
                .UIKit()
        )
        
        imageButtonStackview.addArrangedSubview(
            ButtonView()
                .setStyle(.btnFilledSemiMedium01)
                .setTitle("Right Image")
                .setTitleAlignment(.trailing)
                .setRightImage(image)
                .UIKit()
        )
        
        imageButtonStackview.addArrangedSubview(
            ButtonView()
                .setStyle(.btnFilledSemiMedium01)
                .setTitle("Both Image")
                .setTitleAlignment(.center)
                .setLeftImage(image)
                .setRightImage(image)
                .UIKit()
        )
        
        self.stackView.addArrangedSubview(imageButtonStackview)
    }
    
    func addSwiftUIButtons() {
        addSwiftUIStyleButtons()
        
        var buttonArray: [UIView] = []
        
        let largeButtonArray: [UIView] = [
            ButtonView().setStyle(.btnFilledLarge01).setTitle("btnFilledLarge01").UIKit(),
            ButtonView().setStyle(.btnFilledLarge02).setTitle("btnFilledLarge02").UIKit(),
            ButtonView().setStyle(.btnFilledLarge03).setTitle("btnFilledLarge03").UIKit(),
            ButtonView().setStyle(.btnFilledLarge04).setTitle("btnFilledLarge04").UIKit(),
            ButtonView().setStyle(.btnFilledLarge05).setTitle("btnFilledLarge05").UIKit(),
            ButtonView().setStyle(.btnFilledLarge06).setTitle("btnFilledLarge06").UIKit(),
            
            ButtonView().setStyle(.btnFilledRoundLarge01).setTitle("btnFilledRoundLarge01").UIKit(),
            ButtonView().setStyle(.btnFilledRoundLarge02).setTitle("btnFilledRoundLarge02").UIKit(),
            ButtonView().setStyle(.btnFilledRoundLarge03).setTitle("btnFilledRoundLarge03").UIKit(),
            ButtonView().setStyle(.btnFilledRoundLarge01).setTitle("btnFilledRoundLarge01").UIKit(),
            
            ButtonView().setStyle(.btnFilledTonalLarge01).setTitle("btnFilledTonalLarge01").UIKit(),
            ButtonView().setStyle(.btnFilledTonalLarge02).setTitle("btnFilledTonalLarge02").UIKit(),
            ButtonView().setStyle(.btnFilledTonalLarge03).setTitle("btnFilledTonalLarge03").UIKit(),
            ButtonView().setStyle(.btnFilledTonalLarge04).setTitle("btnFilledTonalLarge04").UIKit(),
            ButtonView().setStyle(.btnFilledTonalLarge05).setTitle("btnFilledTonalLarge05").UIKit(),
            ButtonView().setStyle(.btnFilledTonalLarge06).setTitle("btnFilledTonalLarge06").UIKit(),
            
            ButtonView().setStyle(.btnOutlineLarge01).setTitle("btnOutlineLarge01").UIKit(),
            ButtonView().setStyle(.btnOutlineLarge02).setTitle("btnOutlineLarge02").UIKit(),
            ButtonView().setStyle(.btnOutlineLarge03).setTitle("btnOutlineLarge03").UIKit(),
            ButtonView().setStyle(.btnOutlineLarge04).setTitle("btnOutlineLarge04").UIKit(),
            ButtonView().setStyle(.btnOutlineLarge05).setTitle("btnOutlineLarge05").UIKit(),
            ButtonView().setStyle(.btnOutlineLarge06).setTitle("btnOutlineLarge06").UIKit(),
            
            ButtonView().setStyle(.btnOutlineBgLarge01).setTitle("btnOutlineBgLarge01").UIKit(),
            ButtonView().setStyle(.btnOutlineBgLarge03).setTitle("btnOutlineBgLarge03").UIKit(),
            ButtonView().setStyle(.btnOutlineBgLarge04).setTitle("btnOutlineBgLarge04").UIKit(),
            ButtonView().setStyle(.btnOutlineBgLarge05).setTitle("btnOutlineBgLarge05").UIKit(),
            ButtonView().setStyle(.btnOutlineBgLarge06).setTitle("btnOutlineBgLarge06").UIKit(),
            
            ButtonView().setStyle(.btnTextLarge01).setTitle("btnTextLarge01").UIKit(),
            ButtonView().setStyle(.btnTextLarge02).setTitle("btnTextLarge02").UIKit(),
            ButtonView().setStyle(.btnTextLarge03).setTitle("btnTextLarge03").UIKit(),
            ButtonView().setStyle(.btnTextLarge04).setTitle("btnTextLarge04").UIKit(),
            ButtonView().setStyle(.btnTextLarge05).setTitle("btnTextLarge05").UIKit(),
            ButtonView().setStyle(.btnTextLarge06).setTitle("btnTextLarge06").UIKit(),
            ButtonView().setStyle(.btnTextLarge07).setTitle("btnTextLarge07").UIKit()
        ]
        
        let mediumButtonArray: [UIView] = [
            ButtonView().setStyle(.btnFilledMedium01).setTitle("btnFilledMedium01").UIKit(),
            ButtonView().setStyle(.btnFilledMedium02).setTitle("btnFilledMedium02").UIKit(),
            ButtonView().setStyle(.btnFilledMedium03).setTitle("btnFilledMedium03").UIKit(),
            ButtonView().setStyle(.btnFilledMedium04).setTitle("btnFilledMedium04").UIKit(),
            ButtonView().setStyle(.btnFilledMedium05).setTitle("btnFilledMedium05").UIKit(),
            ButtonView().setStyle(.btnFilledMedium06).setTitle("btnFilledMedium06").UIKit(),
            
            ButtonView().setStyle(.btnFilledRoundMedium01).setTitle("btnFilledRoundMedium01").UIKit(),
            ButtonView().setStyle(.btnFilledRoundMedium02).setTitle("btnFilledRoundMedium02").UIKit(),
            ButtonView().setStyle(.btnFilledRoundMedium03).setTitle("btnFilledRoundMedium03").UIKit(),
            
            ButtonView().setStyle(.btnFilledTonalMedium01).setTitle("btnFilledTonalMedium01").UIKit(),
            ButtonView().setStyle(.btnFilledTonalMedium02).setTitle("btnFilledTonalMedium02").UIKit(),
            ButtonView().setStyle(.btnFilledTonalMedium03).setTitle("btnFilledTonalMedium03").UIKit(),
            ButtonView().setStyle(.btnFilledTonalMedium04).setTitle("btnFilledTonalMedium04").UIKit(),
            ButtonView().setStyle(.btnFilledTonalMedium05).setTitle("btnFilledTonalMedium05").UIKit(),
            ButtonView().setStyle(.btnFilledTonalMedium06).setTitle("btnFilledTonalMedium06").UIKit(),
            
            ButtonView().setStyle(.btnOutlineMedium01).setTitle("btnOutlineMedium01").UIKit(),
            ButtonView().setStyle(.btnOutlineMedium02).setTitle("btnOutlineMedium02").UIKit(),
            ButtonView().setStyle(.btnOutlineMedium03).setTitle("btnOutlineMedium03").UIKit(),
            ButtonView().setStyle(.btnOutlineMedium04).setTitle("btnOutlineMedium04").UIKit(),
            ButtonView().setStyle(.btnOutlineMedium05).setTitle("btnOutlineMedium05").UIKit(),
            ButtonView().setStyle(.btnOutlineMedium06).setTitle("btnOutlineMedium06").UIKit(),
            
            ButtonView().setStyle(.btnOutlineBgMedium01).setTitle("btnOutlineBgMedium01").UIKit(),
            ButtonView().setStyle(.btnOutlineBgMedium03).setTitle("btnOutlineBgMedium03").UIKit(),
            ButtonView().setStyle(.btnOutlineBgMedium04).setTitle("btnOutlineBgMedium04").UIKit(),
            ButtonView().setStyle(.btnOutlineBgMedium05).setTitle("btnOutlineBgMedium05").UIKit(),
            ButtonView().setStyle(.btnOutlineBgMedium06).setTitle("btnOutlineBgMedium06").UIKit(),
            
            ButtonView().setStyle(.btnTextMedium01).setTitle("btnTextMedium01").UIKit(),
            ButtonView().setStyle(.btnTextMedium02).setTitle("btnTextMedium02").UIKit(),
            ButtonView().setStyle(.btnTextMedium03).setTitle("btnTextMedium03").UIKit(),
            ButtonView().setStyle(.btnTextMedium04).setTitle("btnTextMedium04").UIKit(),
            ButtonView().setStyle(.btnTextMedium05).setTitle("btnTextMedium05").UIKit(),
            ButtonView().setStyle(.btnTextMedium06).setTitle("btnTextMedium06").UIKit(),
            ButtonView().setStyle(.btnTextMedium07).setTitle("btnTextMedium07").UIKit()
        ]
        
        let semiMediumButtonArray: [UIView] = [
            ButtonView().setStyle(.btnFilledSemiMedium01).setTitle("btnFilledSemiMedium01").UIKit(),
            ButtonView().setStyle(.btnFilledSemiMedium02).setTitle("btnFilledSemiMedium02").UIKit(),
            ButtonView().setStyle(.btnFilledSemiMedium03).setTitle("btnFilledSemiMedium03").UIKit(),
            ButtonView().setStyle(.btnFilledSemiMedium04).setTitle("btnFilledSemiMedium04").UIKit(),
            ButtonView().setStyle(.btnFilledSemiMedium05).setTitle("btnFilledSemiMedium05").UIKit(),
            ButtonView().setStyle(.btnFilledSemiMedium06).setTitle("btnFilledSemiMedium06").UIKit(),
            
            ButtonView().setStyle(.btnFilledRoundSemiMedium01).setTitle("btnFilledRoundSemiMedium01").UIKit(),
            ButtonView().setStyle(.btnFilledRoundSemiMedium02).setTitle("btnFilledRoundSemiMedium02").UIKit(),
            ButtonView().setStyle(.btnFilledRoundSemiMedium03).setTitle("btnFilledRoundSemiMedium03").UIKit(),
            
            ButtonView().setStyle(.btnFilledTonalSemiMedium01).setTitle("btnFilledTonalSemiMedium01").UIKit(),
            ButtonView().setStyle(.btnFilledTonalSemiMedium02).setTitle("btnFilledTonalSemiMedium02").UIKit(),
            ButtonView().setStyle(.btnFilledTonalSemiMedium03).setTitle("btnFilledTonalSemiMedium03").UIKit(),
            ButtonView().setStyle(.btnFilledTonalSemiMedium04).setTitle("btnFilledTonalSemiMedium04").UIKit(),
            ButtonView().setStyle(.btnFilledTonalSemiMedium05).setTitle("btnFilledTonalSemiMedium05").UIKit(),
            ButtonView().setStyle(.btnFilledTonalSemiMedium06).setTitle("btnFilledTonalSemiMedium06").UIKit(),
            
            ButtonView().setStyle(.btnOutlineSemiMedium01).setTitle("btnOutlineSemiMedium01").UIKit(),
            ButtonView().setStyle(.btnOutlineSemiMedium02).setTitle("btnOutlineSemiMedium02").UIKit(),
            ButtonView().setStyle(.btnOutlineSemiMedium03).setTitle("btnOutlineSemiMedium03").UIKit(),
            ButtonView().setStyle(.btnOutlineSemiMedium04).setTitle("btnOutlineSemiMedium04").UIKit(),
            ButtonView().setStyle(.btnOutlineSemiMedium05).setTitle("btnOutlineSemiMedium05").UIKit(),
            ButtonView().setStyle(.btnOutlineSemiMedium06).setTitle("btnOutlineSemiMedium06").UIKit(),
            
            ButtonView().setStyle(.btnOutlineBgSemiMedium01).setTitle("btnOutlineBgSemiMedium01").UIKit(),
            ButtonView().setStyle(.btnOutlineBgSemiMedium03).setTitle("btnOutlineBgSemiMedium03").UIKit(),
            ButtonView().setStyle(.btnOutlineBgSemiMedium04).setTitle("btnOutlineBgSemiMedium04").UIKit(),
            ButtonView().setStyle(.btnOutlineBgSemiMedium05).setTitle("btnOutlineBgSemiMedium05").UIKit(),
            ButtonView().setStyle(.btnOutlineBgSemiMedium06).setTitle("btnOutlineBgSemiMedium06").UIKit(),
            
            ButtonView().setStyle(.btnTextSemiMedium01).setTitle("btnTextSemiMedium01").UIKit(),
            ButtonView().setStyle(.btnTextSemiMedium02).setTitle("btnTextSemiMedium02").UIKit(),
            ButtonView().setStyle(.btnTextSemiMedium03).setTitle("btnTextSemiMedium03").UIKit(),
            ButtonView().setStyle(.btnTextSemiMedium04).setTitle("btnTextSemiMedium04").UIKit(),
            ButtonView().setStyle(.btnTextSemiMedium05).setTitle("btnTextSemiMedium05").UIKit(),
            ButtonView().setStyle(.btnTextSemiMedium06).setTitle("btnTextSemiMedium06").UIKit(),
            ButtonView().setStyle(.btnTextSemiMedium07).setTitle("btnTextSemiMedium07").UIKit()
        ]
        
        let smallButtonArray: [UIView] = [
            ButtonView().setStyle(.btnFilledSmall01).setTitle("btnFilledSmall01").UIKit(),
            ButtonView().setStyle(.btnFilledSmall02).setTitle("btnFilledSmall02").UIKit(),
            ButtonView().setStyle(.btnFilledSmall03).setTitle("btnFilledSmall03").UIKit(),
            ButtonView().setStyle(.btnFilledSmall04).setTitle("btnFilledSmall04").UIKit(),
            ButtonView().setStyle(.btnFilledSmall05).setTitle("btnFilledSmall05").UIKit(),
            ButtonView().setStyle(.btnFilledSmall06).setTitle("btnFilledSmall06").UIKit(),
            
            ButtonView().setStyle(.btnFilledRoundSmall01).setTitle("btnFilledRoundSmall01").UIKit(),
            ButtonView().setStyle(.btnFilledRoundSmall02).setTitle("btnFilledRoundSmall02").UIKit(),
            ButtonView().setStyle(.btnFilledRoundSmall03).setTitle("btnFilledRoundSmall03").UIKit(),
            
            ButtonView().setStyle(.btnFilledTonalSmall01).setTitle("btnFilledTonalSmall01").UIKit(),
            ButtonView().setStyle(.btnFilledTonalSmall02).setTitle("btnFilledTonalSmall02").UIKit(),
            ButtonView().setStyle(.btnFilledTonalSmall03).setTitle("btnFilledTonalSmall03").UIKit(),
            ButtonView().setStyle(.btnFilledTonalSmall04).setTitle("btnFilledTonalSmall04").UIKit(),
            ButtonView().setStyle(.btnFilledTonalSmall05).setTitle("btnFilledTonalSmall05").UIKit(),
            ButtonView().setStyle(.btnFilledTonalSmall06).setTitle("btnFilledTonalSmall06").UIKit(),
            
            ButtonView().setStyle(.btnOutlineSmall01).setTitle("btnOutlineSmall01").UIKit(),
            ButtonView().setStyle(.btnOutlineSmall02).setTitle("btnOutlineSmall02").UIKit(),
            ButtonView().setStyle(.btnOutlineSmall03).setTitle("btnOutlineSmall03").UIKit(),
            ButtonView().setStyle(.btnOutlineSmall04).setTitle("btnOutlineSmall04").UIKit(),
            ButtonView().setStyle(.btnOutlineSmall05).setTitle("btnOutlineSmall05").UIKit(),
            ButtonView().setStyle(.btnOutlineSmall06).setTitle("btnOutlineSmall06").UIKit(),
            
            ButtonView().setStyle(.btnOutlineBgSmall01).setTitle("btnOutlineBgSmall01").UIKit(),
            ButtonView().setStyle(.btnOutlineBgSmall03).setTitle("btnOutlineBgSmall03").UIKit(),
            ButtonView().setStyle(.btnOutlineBgSmall04).setTitle("btnOutlineBgSmall04").UIKit(),
            ButtonView().setStyle(.btnOutlineBgSmall05).setTitle("btnOutlineBgSmall05").UIKit(),
            ButtonView().setStyle(.btnOutlineBgSmall06).setTitle("btnOutlineBgSmall06").UIKit(),
            
            ButtonView().setStyle(.btnTextSmall01).setTitle("btnTextSmall01").UIKit(),
            ButtonView().setStyle(.btnTextSmall02).setTitle("btnTextSmall02").UIKit(),
            ButtonView().setStyle(.btnTextSmall03).setTitle("btnTextSmall03").UIKit(),
            ButtonView().setStyle(.btnTextSmall04).setTitle("btnTextSmall04").UIKit(),
            ButtonView().setStyle(.btnTextSmall05).setTitle("btnTextSmall05").UIKit(),
            ButtonView().setStyle(.btnTextSmall06).setTitle("btnTextSmall06").UIKit(),
            ButtonView().setStyle(.btnTextSmall07).setTitle("btnTextSmall07").UIKit()
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
