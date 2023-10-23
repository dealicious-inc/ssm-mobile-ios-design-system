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
        }.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20.0)
        }
        
        let bb = DealiControl.chipsOutlineLargePrimary01().then {
            $0.title = "테스트22!!"
            $0.leftImage = UIImage(named: "ic_arrow_right")
            $0.rightImage = UIImage(named: "ic_arrow_right")
            $0.addTarget(self, action: #selector(btnFilledLargePrimary01Pressed), for: .touchUpInside)
        }
        self.stackView.addArrangedSubview(bb)
        
        let button =  TestButton(color: FilledTonalColor.primary01, size: FilledSize.large).then {
            $0.title = "disabled"
            $0.isEnabled = false
            $0.leftIconImage = UIImage(named: "ic_arrow_right")
            $0.rightIconImage = UIImage(named: "ic_arrow_right")
        }
        
        self.stackView.addArrangedSubview(button)
        
        let button2 =  TestButton(color: FilledTonalColor.primary01, size: FilledSize.large).then {
            $0.title = "disabled22"
            $0.isEnabled = false
//            $0.leftIconImage = UIImage(named: "ic_arrow_right")
            $0.rightIconImage = UIImage(named: "ic_arrow_right")
        }
        
        self.stackView.addArrangedSubview(button2)
        
        
        var buttonArray: [UIButton] = []
    
        
        let largeButtonArray: [UIButton] = [btnFilledLargePrimary01(), btnFilledLargePrimary02(),
            btnFilledTonalLargePrimary01(), btnFilledTonalLargePrimary02(),
            btnFilledTonalLargeSecondary01(), btnFilledTonalLargeSecondary02(), btnFilledTonalLargeSecondary03(),
            btnOutlineLargePrimary01(), btnOutlineLargePrimary02(),
            btnOutlineLargeSecondary01(), btnOutlineLargeSecondary02(), btnOutlineLargeSecondary03(), btnOutlineLargeSecondary04(),
            btnTextLargePrimary01(), btnTextLargePrimary02(),
            btnTextLargeSecondary01(), btnTextLargeSecondary02(), btnTextLargeSecondary03(), btnTextLargeSecondary04(), btnTextLargeSecondary05()
        ]
        
        let mediumButtonArray: [UIButton] = [btnFilledMediumPrimary01(), btnFilledMediumPrimary02(),
                                             btnFilledTonalMediumPrimary01(), btnFilledTonalMediumPrimary02(),
                                             btnFilledTonalMediumSecondary01(), btnFilledTonalMediumSecondary02(), btnFilledTonalMediumSecondary03(),
                                             btnOutlineMediumPrimary01(), btnOutlineMediumPrimary02(),
                                             btnOutlineMediumSecondary01(), btnOutlineMediumSecondary02(), btnOutlineMediumSecondary03(), btnOutlineMediumSecondary04(),
                                             btnTextMediumPrimary01(),   btnTextMediumPrimary02().then {
            
            let image =  UIImage(named: "ic_arrow_right")
            $0.rightIconImage = image
        },
                                             btnTextMediumSecondary01(), btnTextMediumSecondary02(), btnTextMediumSecondary03(), btnTextMediumSecondary04(), btnTextMediumSecondary05()
                                             ]
        
        let smallButtonArray: [UIButton] = [btnFilledSmallPrimary01(), btnFilledSmallPrimary02(),
                                            btnFilledTonalSmallPrimary01(), btnFilledTonalSmallPrimary02(),
                                            btnFilledTonalSmallSecondary01(), btnFilledTonalSmallSecondary02(), btnFilledTonalSmallSecondary03(),
                                            btnOutlineSmallPrimary01(), btnOutlineSmallPrimary02(),
                                            btnOutlineSmallSecondary01(), btnOutlineSmallSecondary02(), btnOutlineSmallSecondary03(), btnOutlineSmallSecondary04(),
                                            btnTextSmallPrimary01(), btnTextSmallPrimary02(),
                                            btnTextSmallSecondary01(), btnTextSmallSecondary02(), btnTextSmallSecondary03(), btnTextSmallSecondary04(), btnTextSmallSecondary05()
                                        ]
        
        
        buttonArray += largeButtonArray
        buttonArray += mediumButtonArray
        buttonArray += smallButtonArray
        
        
        buttonArray.forEach { button in
            button.setTitle(String(describing: type(of: button)), for: .normal)
            self.stackView.addArrangedSubview(button)
        }

    }
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func btnFilledLargePrimary01Pressed() {
        print("테스트~~~~~~~~")
    }
    
}
