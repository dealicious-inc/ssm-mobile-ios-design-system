//
//  ButtonViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 2023/09/13.
//

import UIKit
import DealiDesignKit


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
        
        var buttonArray: [UIButton] = []
        
        let largeButtonArray: [UIButton] = [btnFilledLargePrimary01(), btnFilledLargePrimary02(),
            btnFilledTonalLargePrimary01(), btnFilledTonalLargePrimary02(),
            btnFilledTonalLargeSecondary01(), btnFilledTonalLargeSecondary02(), btnFilledTonalLargeSecondary03(),
            btnOutlineLargePrimary01(), btnOutlineLargePrimary02(),
            btnOutlineLargeSecondary01(), btnOutlineLargeSecondary02(), btnOutlineLargeSecondary03(), btnOutlineLargeSecondary04(),
            btnTextLargePrimary01(), btnTextLargePrimary02(),
            btnTextLargeSecondary01(), btnTextLargeSecondary02(), btnTextLargeSecondary03(), btnTextLargeSecondary04(), btnTextLargeSecondary05()
        ]
        
        let mediumButtonArray: [UIButton] = [btnFilledMediumPrimary01(), btnFilledMediumPrimary02()]
        let smallButtonArray: [UIButton] = [btnFilledSmallPrimary01(), btnFilledSmallPrimary02()]
        
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
    
}
