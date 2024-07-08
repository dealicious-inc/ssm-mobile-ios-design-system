//
//  ButtonViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 2023/09/13.
//

import UIKit
import DealiDesignKit
import SnapKit

class ButtonViewController: UIViewController {
    
    private let stackView = UIStackView()
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = .systemGray2
        
        let switchView = UISwitch()
        let switchItem = UIBarButtonItem(customView: switchView)
        self.navigationItem.rightBarButtonItem = switchItem
        switchView.do {
            $0.onTintColor = DealiColor.primary01
            $0.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
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
        
        scrollView.addSubview(self.stackView)
        self.stackView.then {
            $0.axis = .vertical
            $0.spacing = 20.0
            $0.alignment = .center
        }.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20.0)
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
        
        let smallButtonArray: [UIView] = [DealiControl.btnFilledSmall01(),
                                          DealiControl.btnFilledSmall02(),
                                          DealiControl.btnFilledSmall03(),
                                          DealiControl.btnFilledTonalSmall01(),
                                          DealiControl.btnFilledTonalSmall02(),
                                          DealiControl.btnFilledTonalSmall03(),
                                          DealiControl.btnFilledTonalSmall04(),
                                          DealiControl.btnFilledTonalSmall05(),
                                          DealiControl.btnFilledTonalSmall06(),
                                          DealiControl.btnRoundFilledTonalSmall01(),
                                          DealiControl.btnRoundFilledTonalSmall02(),
                                          DealiControl.btnRoundFilledTonalSmall03(),
                                          DealiControl.btnRoundFilledTonalSmall04(),
                                          DealiControl.btnRoundFilledTonalSmall05(),
                                          DealiControl.btnRoundFilledTonalSmall06(),
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

extension UIImage {
    public func resize(_ size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
