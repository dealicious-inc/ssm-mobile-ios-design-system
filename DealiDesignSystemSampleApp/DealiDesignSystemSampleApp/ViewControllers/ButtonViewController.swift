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
        
        self.view.backgroundColor = .lightGray
        
        self.view.addSubview(self.stackView)
        self.stackView.then {
            $0.axis = .vertical
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(20.0)
        }
        
        
        let buttonArray = [btnFilledLargePrimary01(), btnFilledLargePrimary02(), btnFilledTonalLargePrimary01(), btnOutlineLargePrimary01(), btnTextLargePrimary01()]
        
        buttonArray.forEach { button in
            button.title = String(describing: type(of: button))
            self.stackView.addArrangedSubview(button)
        }

    }
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}
