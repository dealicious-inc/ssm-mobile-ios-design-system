//
//  ChipViewController.swift
//  
//
//  Created by 박경우 on 2023/10/23.
//

import UIKit
import DealiDesignKit

class ChipViewController: UIViewController {

    private let stackView = UIStackView()
    
    override func loadView() {
        super.loadView()
        
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
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(0.0)
        }

        let chipsOutlineLargePrimary01 = ChipContentView(name: "chipsOutlineLarge01", chipArray: (0..<4).map { _ in
            DealiControl.chipsOutlineLarge01()
        })
        self.stackView.addArrangedSubview(chipsOutlineLargePrimary01)
        
        let chipsOutlineMediumPrimary01 = ChipContentView(name: "chipsOutlineMedium01", chipArray: (0..<4).map { _ in
            DealiControl.chipsOutlineMedium01()
        })
        self.stackView.addArrangedSubview(chipsOutlineMediumPrimary01)
        
        let chipsOutlineMedium02 = ChipContentView(name: "chipsOutlineMedium02", chipArray: (0..<4).map { _ in
            DealiControl.chipsOutlineMedium02()
        })
        self.stackView.addArrangedSubview(chipsOutlineMedium02)
        
        
        let chipsOutlineSmallPrimary01 = ChipContentView(name: "chipsOutlineSmall01", chipArray: (0..<4).map { _ in
            DealiControl.chipsOutlineSmall01()
        })
        self.stackView.addArrangedSubview(chipsOutlineSmallPrimary01)
        
        
        
        let chipsFilledLargePrimary01 = ChipContentView(name: "chipsFilledLarge01", chipArray: (0..<4).map { _ in
            DealiControl.chipsFilledLarge01()
        })
        self.stackView.addArrangedSubview(chipsFilledLargePrimary01)
        
        let chipsFilledMediumPrimary01 = ChipContentView(name: "chipsFilledMedium01", chipArray: (0..<4).map { _ in
            DealiControl.chipsFilledMedium01()
        })
        self.stackView.addArrangedSubview(chipsFilledMediumPrimary01)
        
        let chipsFilledSmallPrimary01 = ChipContentView(name: "chipsFilledSmall01", chipArray: (0..<4).map { _ in
            DealiControl.chipsFilledSmall01()
        })
        self.stackView.addArrangedSubview(chipsFilledSmallPrimary01)
        
        
        
        let chipsSquareLargePrimary01 = ChipContentView(name: "chipsSquareLarge01", chipArray: (0..<4).map { _ in
            DealiControl.chipsSquareLarge01()
        })
        self.stackView.addArrangedSubview(chipsSquareLargePrimary01)
        
        let chipsSquareMediumPrimary01 = ChipContentView(name: "chipsSquareBoldMedium01", chipArray: (0..<4).map { _ in
            DealiControl.chipsSquareBoldMedium01()
        })
        self.stackView.addArrangedSubview(chipsSquareMediumPrimary01)
        
        let chipsSquareSmallPrimary01 = ChipContentView(name: "chipsSquareSmall01", chipArray: (0..<4).map { _ in
            DealiControl.chipsSquareSmall01()
        })
        self.stackView.addArrangedSubview(chipsSquareSmallPrimary01)
        
        
        
        let chipsFilledSquareLargePrimary01 = ChipContentView(name: "chipsFilledSquareLarge01", chipArray: (0..<4).map { _ in
            DealiControl.chipsFilledSquareLarge01()
        })
        self.stackView.addArrangedSubview(chipsFilledSquareLargePrimary01)
        
        let chipsFilledSquareLargePrimary02 = ChipContentView(name: "chipsFilledSquareLarge02", chipArray: (0..<4).map { _ in
            DealiControl.chipsFilledSquareLarge02()
        })
        self.stackView.addArrangedSubview(chipsFilledSquareLargePrimary02)
        
        let chipsFilledSquareLargeScondary01 = ChipContentView(name: "chipsFilledSquareLarge03", chipArray: (0..<4).map { _ in
            DealiControl.chipsFilledSquareLarge03()
        })
        self.stackView.addArrangedSubview(chipsFilledSquareLargeScondary01)
        
        let chipsFilledSquareMediumPrimary01 = ChipContentView(name: "chipsFilledSquareMedium01", chipArray: (0..<4).map { _ in
            DealiControl.chipsFilledSquareMedium01()
        })
        self.stackView.addArrangedSubview(chipsFilledSquareMediumPrimary01)
        
        let chipsFilledSquareMediumScondary01 = ChipContentView(name: "chipsFilledSquareMedium02", chipArray: (0..<4).map { _ in
            DealiControl.chipsFilledSquareMedium02()
        })
        self.stackView.addArrangedSubview(chipsFilledSquareMediumScondary01)
        
        let chipsFilledSquareSmallPrimary01 = ChipContentView(name: "chipsFilledSquareSmall01", chipArray: (0..<4).map { _ in
            DealiControl.chipsFilledSquareSmall01()
        })
        self.stackView.addArrangedSubview(chipsFilledSquareSmallPrimary01)
        
        let chipsFilledSquareSmallScondary01 = ChipContentView(name: "chipsFilledSquareSmall02", chipArray: (0..<4).map { _ in
            DealiControl.chipsFilledSquareSmall02()
        })
        self.stackView.addArrangedSubview(chipsFilledSquareSmallScondary01)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}


final class ChipContentView: UIView {
    
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    
    init(name: String, chipArray: [ClickableComponentChip]) {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.text = name
            $0.font = .b1sb15
            $0.textColor = DealiColor.g100
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
            $0.top.equalToSuperview()
            $0.height.equalTo(60.0)
        }
        
        self.addSubview(self.stackView)
        self.stackView.then {
            $0.axis = .horizontal
            $0.spacing = 20.0
        }.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.left.equalTo(titleLabel)
            $0.bottom.equalToSuperview().offset(-20.0)
        }
        
        for i in 0..<chipArray.count {
            let chip = chipArray[i]
            self.stackView.addArrangedSubview(chip)
            chip.do {
                if i == 0 {
                    $0.title = "Default"
                } else if i == 1 {
                    $0.title = "Selected"
                    $0.isSelected = true
                } else if i == 2 {
                    $0.title = "Disabled"
                    $0.isEnabled = false
                } else {
                    $0.title = nil
                    $0.singleImage = ClickableImage(named: "ic_refresh", needOriginColor: true)
                }
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

