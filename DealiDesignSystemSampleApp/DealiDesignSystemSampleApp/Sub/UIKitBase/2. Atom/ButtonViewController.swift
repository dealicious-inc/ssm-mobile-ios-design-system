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
        
        self.view.backgroundColor = .yellow
        
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
                                          DealiControl.btnOutlineBgRoundSmall01(),
                                          DealiControl.btnOutlineBgRoundSmall03(),
                                          DealiControl.btnOutlineBgRoundSmall04(),
                                          DealiControl.btnOutlineBgRoundSmall05(),
                                          DealiControl.btnOutlineBgRoundSmall06(),
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
           if let new = button as? ClickableUnitButtonComponent {
               
               switch Int.random(in: 0...2) {
               case 0:
                   new.title = "한줄 텍스트 버튼입니다."
               case 1:
                   new.title = "두줄 텍스트 버튼입니다.\n두줄 텍스트 버튼입니다."
               default:
                   new.title = "세줄 텍스트 버튼입니다.\n세줄 텍스트 버튼입니다.\n세줄 텍스트 버튼입니다."
               }
               
               
                switch Int.random(in: 0...3) {
                case 0:
                    new.leftImage = ClickableImage(DealiIcon.ic_info.image)
                case 1:
                    new.rightImage = ClickableImage(DealiIcon.ic_arrow_right.image)
                case 2:
                    new.leftImage = ClickableImage(DealiIcon.ic_info.image, needOriginColor: true)
                    new.rightImage = ClickableImage(DealiIcon.ic_arrow_right.image, needOriginColor: true)
                default:
                    break
                }
            }
            
            self.stackView.addArrangedSubview(button)
        }

    }
    
    @objc func btnTextMediumPrimary02Pressed(_ sender: ClickableUnitButtonComponent) {
     
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func switchValueChanged(_ swc: UISwitch) {
        self.stackView.subviews.forEach { view in
            if let b = view as? ClickableUnitButtonComponent {
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
        
        let loadingViewModel = ButtonViewModel(type: .btnFilledLarge01, title: "setLoading")
        let loadingButton = ButtonView(viewModel: loadingViewModel) {
            loadingViewModel.isLoading.toggle()
        }.UIKit()
        loadingStackview.addArrangedSubview(loadingButton)
        
        let onViewModel = ButtonViewModel(type: .btnOutlineBgLarge01, title: "On")
        let buttonOn = ButtonView(viewModel: onViewModel) {
            loadingViewModel.isLoading = true
        }.UIKit()
        loadingStackview.addArrangedSubview(buttonOn)
        
        let offViewModel = ButtonViewModel(type: .btnOutlineBgLarge01, title: "Off")
        let buttonOff = ButtonView(viewModel: offViewModel) {
            loadingViewModel.isLoading = false
        }.UIKit()
        loadingStackview.addArrangedSubview(buttonOff)
        
        self.stackView.addArrangedSubview(loadingStackview)
        
        
        // Enabled
        let enabledButtonStackview = UIStackView()
        enabledButtonStackview.do {
            $0.spacing = 10
            $0.axis = .horizontal
        }
        
        let enabledViewModel = ButtonViewModel(type: .btnFilledLarge01, title: "isEnabled True")
        let enabledButton = ButtonView(viewModel: enabledViewModel).UIKit()
        enabledButtonStackview.addArrangedSubview(enabledButton)
        
        let enableToggleViewModel = ButtonViewModel(type: .btnOutlineBgLarge01, title: "Enabled")
        let enableToggle = ButtonView(viewModel: enableToggleViewModel) {
            enabledViewModel.isEnabled = true
        }.UIKit()
        enabledButtonStackview.addArrangedSubview(enableToggle)
        
        let disableToggleViewModel = ButtonViewModel(type: .btnOutlineBgLarge01, title: "Disabled")
        let disableToggle = ButtonView(viewModel: disableToggleViewModel) {
            enabledViewModel.isEnabled = false
        }.UIKit()
        enabledButtonStackview.addArrangedSubview(disableToggle)
        
        self.stackView.addArrangedSubview(enabledButtonStackview)
        
        // Image
        let imageButtonStackview = UIStackView()
        imageButtonStackview.do {
            $0.spacing = 10
            $0.axis = .horizontal
        }
        
        let image = UIImage.dealiIcon(named: "ic_download_2")?.resize(CGSize(width: 16.0, height: 16.0))
        
        let leftImageViewModel = ButtonViewModel(
            type: .btnFilledSemiMedium01,
            title: "Left Image",
            leftImage: image
        )
        let leftImageButton = ButtonView(viewModel: leftImageViewModel).UIKit()
        imageButtonStackview.addArrangedSubview(leftImageButton)
        
        let rightImageViewModel = ButtonViewModel(
            type: .btnFilledSemiMedium01,
            title: "Right Image",
            rightImage: image,
            titleAlignment: .trailing
        )
        let rightImageButton = ButtonView(viewModel: rightImageViewModel).UIKit()
        imageButtonStackview.addArrangedSubview(rightImageButton)
        
        let bothImageViewModel = ButtonViewModel(
            type: .btnFilledSemiMedium01,
            title: "Both Image",
            leftImage: image,
            rightImage: image,
            titleAlignment: .center
        )
        let bothImageButton = ButtonView(viewModel: bothImageViewModel).UIKit()
        imageButtonStackview.addArrangedSubview(bothImageButton)
        
        self.stackView.addArrangedSubview(imageButtonStackview)
    }
    
    func addSwiftUIButtons() {
        addSwiftUIStyleButtons()
        
        var buttonArray: [UIView] = []
        
        let largeButtonArray: [UIView] = [
            ButtonView(type: .btnFilledLarge01, title: "btnFilledLarge01").UIKit(),
            ButtonView(type: .btnFilledLarge02, title: "btnFilledLarge02").UIKit(),
            ButtonView(type: .btnFilledLarge03, title: "btnFilledLarge03").UIKit(),
            ButtonView(type: .btnFilledLarge04, title: "btnFilledLarge04").UIKit(),
            ButtonView(type: .btnFilledLarge05, title: "btnFilledLarge05").UIKit(),
            ButtonView(type: .btnFilledLarge06, title: "btnFilledLarge06").UIKit(),
            
            ButtonView(type: .btnFilledRoundLarge01, title: "btnFilledRoundLarge01").UIKit(),
            ButtonView(type: .btnFilledRoundLarge02, title: "btnFilledRoundLarge02").UIKit(),
            ButtonView(type: .btnFilledRoundLarge03, title: "btnFilledRoundLarge03").UIKit(),
            
            ButtonView(type: .btnFilledTonalLarge01, title: "btnFilledTonalLarge01").UIKit(),
            ButtonView(type: .btnFilledTonalLarge02, title: "btnFilledTonalLarge02").UIKit(),
            ButtonView(type: .btnFilledTonalLarge03, title: "btnFilledTonalLarge03").UIKit(),
            ButtonView(type: .btnFilledTonalLarge04, title: "btnFilledTonalLarge04").UIKit(),
            ButtonView(type: .btnFilledTonalLarge05, title: "btnFilledTonalLarge05").UIKit(),
            ButtonView(type: .btnFilledTonalLarge06, title: "btnFilledTonalLarge06").UIKit(),
        
            ButtonView(type: .btnOutlineLarge01, title: "btnOutlineLarge01").UIKit(),
            ButtonView(type: .btnOutlineLarge02, title: "btnOutlineLarge02").UIKit(),
            ButtonView(type: .btnOutlineLarge03, title: "btnOutlineLarge03").UIKit(),
            ButtonView(type: .btnOutlineLarge04, title: "btnOutlineLarge04").UIKit(),
            ButtonView(type: .btnOutlineLarge05, title: "btnOutlineLarge05").UIKit(),
            ButtonView(type: .btnOutlineLarge06, title: "btnOutlineLarge06").UIKit(),
            
            ButtonView(type: .btnOutlineBgLarge01, title: "btnOutlineBgLarge01").UIKit(),
            ButtonView(type: .btnOutlineBgLarge03, title: "btnOutlineBgLarge03").UIKit(),
            ButtonView(type: .btnOutlineBgLarge04, title: "btnOutlineBgLarge04").UIKit(),
            ButtonView(type: .btnOutlineBgLarge05, title: "btnOutlineBgLarge05").UIKit(),
            ButtonView(type: .btnOutlineBgLarge06, title: "btnOutlineBgLarge06").UIKit(),
            
            ButtonView(type: .btnTextLarge01, title: "btnTextLarge01").UIKit(),
            ButtonView(type: .btnTextLarge02, title: "btnTextLarge02").UIKit(),
            ButtonView(type: .btnTextLarge03, title: "btnTextLarge03").UIKit(),
            ButtonView(type: .btnTextLarge04, title: "btnTextLarge04").UIKit(),
            ButtonView(type: .btnTextLarge05, title: "btnTextLarge05").UIKit(),
            ButtonView(type: .btnTextLarge06, title: "btnTextLarge06").UIKit(),
            ButtonView(type: .btnTextLarge07, title: "btnTextLarge07").UIKit()
        ]
        
        let mediumButtonArray: [UIView] = [
            ButtonView(type: .btnFilledMedium01, title: "btnFilledMedium01").UIKit(),
            ButtonView(type: .btnFilledMedium02, title: "btnFilledMedium02").UIKit(),
            ButtonView(type: .btnFilledMedium03, title: "btnFilledMedium03").UIKit(),
            ButtonView(type: .btnFilledMedium04, title: "btnFilledMedium04").UIKit(),
            ButtonView(type: .btnFilledMedium05, title: "btnFilledMedium05").UIKit(),
            ButtonView(type: .btnFilledMedium06, title: "btnFilledMedium06").UIKit(),
            
            ButtonView(type: .btnFilledRoundMedium01, title: "btnFilledRoundMedium01").UIKit(),
            ButtonView(type: .btnFilledRoundMedium02, title: "btnFilledRoundMedium02").UIKit(),
            ButtonView(type: .btnFilledRoundMedium03, title: "btnFilledRoundMedium03").UIKit(),
            
            ButtonView(type: .btnFilledTonalMedium01, title: "btnFilledTonalMedium01").UIKit(),
            ButtonView(type: .btnFilledTonalMedium02, title: "btnFilledTonalMedium02").UIKit(),
            ButtonView(type: .btnFilledTonalMedium03, title: "btnFilledTonalMedium03").UIKit(),
            ButtonView(type: .btnFilledTonalMedium04, title: "btnFilledTonalMedium04").UIKit(),
            ButtonView(type: .btnFilledTonalMedium05, title: "btnFilledTonalMedium05").UIKit(),
            ButtonView(type: .btnFilledTonalMedium06, title: "btnFilledTonalMedium06").UIKit(),
            
            ButtonView(type: .btnOutlineMedium01, title: "btnOutlineMedium01").UIKit(),
            ButtonView(type: .btnOutlineMedium02, title: "btnOutlineMedium02").UIKit(),
            ButtonView(type: .btnOutlineMedium03, title: "btnOutlineMedium03").UIKit(),
            ButtonView(type: .btnOutlineMedium04, title: "btnOutlineMedium04").UIKit(),
            ButtonView(type: .btnOutlineMedium05, title: "btnOutlineMedium05").UIKit(),
            ButtonView(type: .btnOutlineMedium06, title: "btnOutlineMedium06").UIKit(),
            
            ButtonView(type: .btnOutlineBgMedium01, title: "btnOutlineBgMedium01").UIKit(),
            ButtonView(type: .btnOutlineBgMedium03, title: "btnOutlineBgMedium03").UIKit(),
            ButtonView(type: .btnOutlineBgMedium04, title: "btnOutlineBgMedium04").UIKit(),
            ButtonView(type: .btnOutlineBgMedium05, title: "btnOutlineBgMedium05").UIKit(),
            ButtonView(type: .btnOutlineBgMedium06, title: "btnOutlineBgMedium06").UIKit(),
            
            ButtonView(type: .btnTextMedium01, title: "btnTextMedium01").UIKit(),
            ButtonView(type: .btnTextMedium02, title: "btnTextMedium02").UIKit(),
            ButtonView(type: .btnTextMedium03, title: "btnTextMedium03").UIKit(),
            ButtonView(type: .btnTextMedium04, title: "btnTextMedium04").UIKit(),
            ButtonView(type: .btnTextMedium05, title: "btnTextMedium05").UIKit(),
            ButtonView(type: .btnTextMedium06, title: "btnTextMedium06").UIKit(),
            ButtonView(type: .btnTextMedium07, title: "btnTextMedium07").UIKit()
        ]
        
        let semiMediumButtonArray: [UIView] = [
            ButtonView(type: .btnFilledSemiMedium01, title: "btnFilledSemiMedium01").UIKit(),
            ButtonView(type: .btnFilledSemiMedium02, title: "btnFilledSemiMedium02").UIKit(),
            ButtonView(type: .btnFilledSemiMedium03, title: "btnFilledSemiMedium03").UIKit(),
            ButtonView(type: .btnFilledSemiMedium04, title: "btnFilledSemiMedium04").UIKit(),
            ButtonView(type: .btnFilledSemiMedium05, title: "btnFilledSemiMedium05").UIKit(),
            ButtonView(type: .btnFilledSemiMedium06, title: "btnFilledSemiMedium06").UIKit(),
            
            ButtonView(type: .btnFilledRoundSemiMedium01, title: "btnFilledRoundSemiMedium01").UIKit(),
            ButtonView(type: .btnFilledRoundSemiMedium02, title: "btnFilledRoundSemiMedium02").UIKit(),
            ButtonView(type: .btnFilledRoundSemiMedium03, title: "btnFilledRoundSemiMedium03").UIKit(),
            
            ButtonView(type: .btnFilledTonalSemiMedium01, title: "btnFilledTonalSemiMedium01").UIKit(),
            ButtonView(type: .btnFilledTonalSemiMedium02, title: "btnFilledTonalSemiMedium02").UIKit(),
            ButtonView(type: .btnFilledTonalSemiMedium03, title: "btnFilledTonalSemiMedium03").UIKit(),
            ButtonView(type: .btnFilledTonalSemiMedium04, title: "btnFilledTonalSemiMedium04").UIKit(),
            ButtonView(type: .btnFilledTonalSemiMedium05, title: "btnFilledTonalSemiMedium05").UIKit(),
            ButtonView(type: .btnFilledTonalSemiMedium06, title: "btnFilledTonalSemiMedium06").UIKit(),
            
            ButtonView(type: .btnOutlineSemiMedium01, title: "btnOutlineSemiMedium01").UIKit(),
            ButtonView(type: .btnOutlineSemiMedium02, title: "btnOutlineSemiMedium02").UIKit(),
            ButtonView(type: .btnOutlineSemiMedium03, title: "btnOutlineSemiMedium03").UIKit(),
            ButtonView(type: .btnOutlineSemiMedium04, title: "btnOutlineSemiMedium04").UIKit(),
            ButtonView(type: .btnOutlineSemiMedium05, title: "btnOutlineSemiMedium05").UIKit(),
            ButtonView(type: .btnOutlineSemiMedium06, title: "btnOutlineSemiMedium06").UIKit(),
            
            ButtonView(type: .btnOutlineBgSemiMedium01, title: "btnOutlineBgSemiMedium01").UIKit(),
            ButtonView(type: .btnOutlineBgSemiMedium03, title: "btnOutlineBgSemiMedium03").UIKit(),
            ButtonView(type: .btnOutlineBgSemiMedium04, title: "btnOutlineBgSemiMedium04").UIKit(),
            ButtonView(type: .btnOutlineBgSemiMedium05, title: "btnOutlineBgSemiMedium05").UIKit(),
            ButtonView(type: .btnOutlineBgSemiMedium06, title: "btnOutlineBgSemiMedium06").UIKit(),
            
            ButtonView(type: .btnTextSemiMedium01, title: "btnTextSemiMedium01").UIKit(),
            ButtonView(type: .btnTextSemiMedium02, title: "btnTextSemiMedium02").UIKit(),
            ButtonView(type: .btnTextSemiMedium03, title: "btnTextSemiMedium03").UIKit(),
            ButtonView(type: .btnTextSemiMedium04, title: "btnTextSemiMedium04").UIKit(),
            ButtonView(type: .btnTextSemiMedium05, title: "btnTextSemiMedium05").UIKit(),
            ButtonView(type: .btnTextSemiMedium06, title: "btnTextSemiMedium06").UIKit(),
            ButtonView(type: .btnTextSemiMedium07, title: "btnTextSemiMedium07").UIKit()
        ]
        
        let smallButtonArray: [UIView] = [
            ButtonView(type: .btnFilledSmall01, title: "btnFilledSmall01").UIKit(),
            ButtonView(type: .btnFilledSmall02, title: "btnFilledSmall02").UIKit(),
            ButtonView(type: .btnFilledSmall03, title: "btnFilledSmall03").UIKit(),
            ButtonView(type: .btnFilledSmall04, title: "btnFilledSmall04").UIKit(),
            ButtonView(type: .btnFilledSmall05, title: "btnFilledSmall05").UIKit(),
            ButtonView(type: .btnFilledSmall06, title: "btnFilledSmall06").UIKit(),
            
            ButtonView(type: .btnFilledRoundSmall01, title: "btnFilledRoundSmall01").UIKit(),
            ButtonView(type: .btnFilledRoundSmall02, title: "btnFilledRoundSmall02").UIKit(),
            ButtonView(type: .btnFilledRoundSmall03, title: "btnFilledRoundSmall03").UIKit(),
            
            ButtonView(type: .btnFilledTonalSmall01, title: "btnFilledTonalSmall01").UIKit(),
            ButtonView(type: .btnFilledTonalSmall02, title: "btnFilledTonalSmall02").UIKit(),
            ButtonView(type: .btnFilledTonalSmall03, title: "btnFilledTonalSmall03").UIKit(),
            ButtonView(type: .btnFilledTonalSmall04, title: "btnFilledTonalSmall04").UIKit(),
            ButtonView(type: .btnFilledTonalSmall05, title: "btnFilledTonalSmall05").UIKit(),
            ButtonView(type: .btnFilledTonalSmall06, title: "btnFilledTonalSmall06").UIKit(),
            
            ButtonView(type: .btnOutlineSmall01, title: "btnOutlineSmall01").UIKit(),
            ButtonView(type: .btnOutlineSmall02, title: "btnOutlineSmall02").UIKit(),
            ButtonView(type: .btnOutlineSmall03, title: "btnOutlineSmall03").UIKit(),
            ButtonView(type: .btnOutlineSmall04, title: "btnOutlineSmall04").UIKit(),
            ButtonView(type: .btnOutlineSmall05, title: "btnOutlineSmall05").UIKit(),
            ButtonView(type: .btnOutlineSmall06, title: "btnOutlineSmall06").UIKit(),
            
            ButtonView(type: .btnOutlineBgSmall01, title: "btnOutlineBgSmall01").UIKit(),
            ButtonView(type: .btnOutlineBgSmall03, title: "btnOutlineBgSmall03").UIKit(),
            ButtonView(type: .btnOutlineBgSmall04, title: "btnOutlineBgSmall04").UIKit(),
            ButtonView(type: .btnOutlineBgSmall05, title: "btnOutlineBgSmall05").UIKit(),
            ButtonView(type: .btnOutlineBgSmall06, title: "btnOutlineBgSmall06").UIKit(),
            
            ButtonView(type: .btnTextSmall01, title: "btnTextSmall01").UIKit(),
            ButtonView(type: .btnTextSmall02, title: "btnTextSmall02").UIKit(),
            ButtonView(type: .btnTextSmall03, title: "btnTextSmall03").UIKit(),
            ButtonView(type: .btnTextSmall04, title: "btnTextSmall04").UIKit(),
            ButtonView(type: .btnTextSmall05, title: "btnTextSmall05").UIKit(),
            ButtonView(type: .btnTextSmall06, title: "btnTextSmall06").UIKit(),
            ButtonView(type: .btnTextSmall07, title: "btnTextSmall07").UIKit()
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
