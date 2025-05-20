//
//  TagViewController.swift
//  
//
//  Created by 박경우 on 12/7/23.
//

import UIKit
import DealiDesignKit

class TagViewController: UIViewController {

    private let stackView = UIStackView()
    
    override func loadView() {
        self.view = UIView()
        
        self.view.backgroundColor = .black
        
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
            $0.edges.equalToSuperview().inset(0.0)
        }
        
        for size in ["Large", "Medium", "Small"] {
            for style in ["Filled", "Outline"] {
                for number in 1...4 {
                    let name = "tag\(style)\(size)0\(number)"
                    if let e = DealiTag.EType(rawValue: name) {
                        let tag = DealiTag()
                        self.stackView.addArrangedSubview(tag)
                        tag.do {
                            $0.type = e
                            $0.text = name
                        }
                    }
                }
            }
        }
        
        
//        let sizeArray: [DealiTag.ESize] = [.large, .medium, .small]
//        let titleArray = ["주문확인", "대금결제", "신규주문", "대금결제", "포장완료", "대금결제", "거래완료", "미송 사전 입금완료"]
//        let colorArray: [DealiTag.EColor] = [.red, .whiteRed, .blue, .whiteBlue, .orange, .whiteOrange, .gray, .whiteGray]
//        let zip = zip(titleArray, colorArray)
//        
//        for size in sizeArray {
//            for (title, color) in zip {
//                let tag = DealiTag()
//                self.stackView.addArrangedSubview(tag)
//                tag.do {
//                    $0.text = title
////                    $0.size = size
////                    $0.color = color
//                    $0.configure(size: size, color: color)
//                }
//            }
//        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
