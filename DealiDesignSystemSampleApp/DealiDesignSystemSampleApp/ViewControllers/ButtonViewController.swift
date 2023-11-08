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
        
//        UISwitch* switchView = [[UISwitch alloc] init];
//        UIBarButtonItem* switchItem = [[UIBarButtonItem alloc] initWithCustomView:switchView];
//        self.navigationItem.rightBarButtonItem = switchItem;
        
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
        
        var buttonArray: [UIView] = []

        let largeButtonArray: [UIView] = [DealiControl.btnFilledLargePrimary01(), DealiControl.btnFilledLargePrimary02(), DealiControl.btnFilledLargeGradient(),
                                          DealiControl.btnFilledTonalLargePrimary01(), DealiControl.btnFilledTonalLargePrimary02(),
                                          DealiControl.btnFilledTonalLargeSecondary01(), DealiControl.btnFilledTonalLargeSecondary02(), DealiControl.btnFilledTonalLargeSecondary03(),
                                          DealiControl.btnOutlineLargePrimary01(), DealiControl.btnOutlineLargePrimary02(),
                                          DealiControl.btnOutlineLargeSecondary01(), DealiControl.btnOutlineLargeSecondary02(), DealiControl.btnOutlineLargeSecondary03(), DealiControl.btnOutlineLargeSecondary04(),
                                          DealiControl.btnTextLargePrimary01(), DealiControl.btnTextLargePrimary02(),
                                          DealiControl.btnTextLargeSecondary01(), DealiControl.btnTextLargeSecondary02(), DealiControl.btnTextLargeSecondary03(), DealiControl.btnTextLargeSecondary04(), DealiControl.btnTextLargeSecondary05()
        ]

        let mediumButtonArray: [UIView] = [DealiControl.btnFilledMediumPrimary01(), DealiControl.btnFilledMediumPrimary02(),
                                           DealiControl.btnFilledTonalMediumPrimary01(), DealiControl.btnFilledTonalMediumPrimary02(),
                                           DealiControl.btnFilledTonalMediumSecondary01(), DealiControl.btnFilledTonalMediumSecondary02(), DealiControl.btnFilledTonalMediumSecondary03(),
                                           DealiControl.btnOutlineMediumPrimary01(), DealiControl.btnOutlineMediumPrimary02(),
                                           DealiControl.btnOutlineMediumSecondary01(), DealiControl.btnOutlineMediumSecondary02(), DealiControl.btnOutlineMediumSecondary03(), DealiControl.btnOutlineMediumSecondary04(),
                                           DealiControl.btnTextMediumPrimary01(),   DealiControl.btnTextMediumPrimary02(),
                                           DealiControl.btnTextMediumSecondary01(), DealiControl.btnTextMediumSecondary02(), DealiControl.btnTextMediumSecondary03(), DealiControl.btnTextMediumSecondary04(), DealiControl.btnTextMediumSecondary05()
                                             ]
        
        let smallButtonArray: [UIView] = [DealiControl.btnFilledSmallPrimary01(), DealiControl.btnFilledSmallPrimary02(),
                                          DealiControl.btnFilledTonalSmallPrimary01(), DealiControl.btnFilledTonalSmallPrimary02(),
                                          DealiControl.btnFilledTonalSmallSecondary01(), DealiControl.btnFilledTonalSmallSecondary02(), DealiControl.btnFilledTonalSmallSecondary03(),
                                          DealiControl.btnRoundFilledTonalSmallPrimary01(), DealiControl.btnRoundFilledTonalSmallPrimary02(), DealiControl.btnRoundFilledTonalSmallSecondary01(), DealiControl.btnRoundFilledTonalSmallSecondary02(), DealiControl.btnRoundFilledTonalSmallSecondary03(),
                                          DealiControl.btnOutlineSmallPrimary01(), DealiControl.btnOutlineSmallPrimary02(),
                                          DealiControl.btnOutlineSmallSecondary01(), DealiControl.btnOutlineSmallSecondary02(), DealiControl.btnOutlineSmallSecondary03(), DealiControl.btnOutlineSmallSecondary04(),
                                          DealiControl.btnTextSmallPrimary01(), DealiControl.btnTextSmallPrimary02(),
                                          DealiControl.btnTextSmallSecondary01(), DealiControl.btnTextSmallSecondary02(), DealiControl.btnTextSmallSecondary03(), DealiControl.btnTextSmallSecondary04(), DealiControl.btnTextSmallSecondary05()
                                        ]
        
        
        buttonArray += largeButtonArray
        buttonArray += mediumButtonArray
        buttonArray += smallButtonArray
        
        
        buttonArray.forEach { button in
            if let old = button as? SystemButton {
                old.setTitle(String(describing: type(of: button)), for: .normal)

            } else if let new = button as? ClickableComponent {
                switch Int.random(in: 0...2) {
                case 0:
                    new.leftImage = ClickableImage(named: "img_mbs_filled_16_ver01", needOriginColor: true)
                case 1:
                    new.rightImage = ClickableImage(named: "ic_arrow_right")
                default:
                    new.leftImage = ClickableImage(named: "img_mbs_filled_16_ver01", needOriginColor: true)
                    new.rightImage = ClickableImage(named: "ic_arrow_right")
                }
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
                b.isEnabled = !swc.isOn
            }
        }
        
    }
    
}
