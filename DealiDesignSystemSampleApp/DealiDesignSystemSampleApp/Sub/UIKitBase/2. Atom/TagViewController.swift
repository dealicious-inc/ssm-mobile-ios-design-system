//
//  TagViewController.swift
//  
//
//  Created by 박경우 on 12/7/23.
//

import UIKit
import SwiftUI
import DealiDesignKit

class TagViewController: UIViewController {
    
    private var isSwiftUI: Bool
    
    init(isSwiftUI: Bool = false) {
        self.isSwiftUI = isSwiftUI
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let stackView = UIStackView()
    
    override func loadView() {
        self.view = UIView()
        
        self.view.backgroundColor = .systemBackground
        
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
        
        for size in DealiTag.ESize.allCases {
            for outline in [false, true] {
                for variant in 1...5 {
                    guard let e = DealiTag.EType(size: size, outline: outline, variant: variant) else { continue }
                    let name = e.rawValue
                    if isSwiftUI {
                        let tag = TagView(text: name, type: e)
                        self.stackView.addArrangedSubview(tag.UIKit())
                    } else {
                        let tag = DealiTag()
                        self.stackView.addArrangedSubview(tag)
                        tag.do {
                            $0.type = e
                            $0.text = name
                        }
                    }
                }
            }
            if let textType = DealiTag.EType(size: size, style: .text, variant: 5) {
                let name = textType.rawValue
                if isSwiftUI {
                    let tag = TagView(text: name, type: textType)
                    self.stackView.addArrangedSubview(tag.UIKit())
                } else {
                    let tag = DealiTag()
                    self.stackView.addArrangedSubview(tag)
                    tag.do {
                        $0.type = textType
                        $0.text = name
                    }
                }
            }
        }
        
        let iconTitle = UILabel()
        iconTitle.text = "아이콘 (604:9456)"
        iconTitle.textColor = .white
        iconTitle.font = .b2sb14
        self.stackView.addArrangedSubview(iconTitle)
        
        let iconExampleTypes: [DealiTag.EType] = [
            .tagFilledLarge01,
            .tagFilledMedium01,
            .tagFilledSemiMedium01,
            .tagFilledSmall01
        ]
        
        if isSwiftUI {
            for type in iconExampleTypes {
                let iconTag = TagView(
                    text: "\(type.rawValue) + icon",
                    type: type,
                    leftIcon: Image.dealiIcon(named: "ic_arrow_close_1_filled"),
                    rightIcon: Image.dealiIcon(named: "ic_x_s")
                )
                self.stackView.addArrangedSubview(iconTag.UIKit())
            }
        } else {
            for type in iconExampleTypes {
                let iconTag = DealiTag()
                iconTag.type = type
                iconTag.text = "\(type.rawValue) + icon"
                iconTag.leftIcon = UIImage.dealiIcon(named: "ic_arrow_close_1_filled")
                iconTag.rightIcon = UIImage.dealiIcon(named: "ic_x_s")
                self.stackView.addArrangedSubview(iconTag)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
