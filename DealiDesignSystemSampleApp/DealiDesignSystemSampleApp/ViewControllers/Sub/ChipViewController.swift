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

        let chipsOutlineLargePrimary01 = ChipContentView(name: "chipOutlineLarge01", chipArray: (0..<4).map { _ in
            DealiControl.chipOutlineLarge01()
        })
        self.stackView.addArrangedSubview(chipsOutlineLargePrimary01)
        
        let chipsOutlineMediumPrimary01 = ChipContentView(name: "chipOutlineMedium01", chipArray: (0..<4).map { _ in
            DealiControl.chipOutlineMedium01()
        })
        self.stackView.addArrangedSubview(chipsOutlineMediumPrimary01)
        
        let chipsOutlineMedium02 = ChipContentView(name: "chipOutlineMedium02", chipArray: (0..<4).map { _ in
            DealiControl.chipOutlineMedium02()
        })
        self.stackView.addArrangedSubview(chipsOutlineMedium02)
        
        
        let chipsOutlineSmallPrimary01 = ChipContentView(name: "chipOutlineSmall01", chipArray: (0..<4).map { _ in
            DealiControl.chipOutlineSmall01()
        })
        self.stackView.addArrangedSubview(chipsOutlineSmallPrimary01)
        
        
        
        let chipsFilledLargePrimary01 = ChipContentView(name: "chipFilledLarge01", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledLarge01()
        })
        self.stackView.addArrangedSubview(chipsFilledLargePrimary01)
        
        let chipsFilledMediumPrimary01 = ChipContentView(name: "chipFilledMedium01", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledMedium01()
        })
        self.stackView.addArrangedSubview(chipsFilledMediumPrimary01)
        
        let chipsFilledSmallPrimary01 = ChipContentView(name: "chipFilledSmall01", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledSmall01()
        })
        self.stackView.addArrangedSubview(chipsFilledSmallPrimary01)
        
        
        
        let chipsSquareLargePrimary01 = ChipContentView(name: "chipOutlineSquareLarge01", chipArray: (0..<4).map { _ in
            DealiControl.chipOutlineSquareLarge01()
        })
        self.stackView.addArrangedSubview(chipsSquareLargePrimary01)
        
        let chipsSquareMediumPrimary01 = ChipContentView(name: "chipOutlineSquareMedium01", chipArray: (0..<4).map { _ in
            DealiControl.chipOutlineSquareMedium01()
        })
        self.stackView.addArrangedSubview(chipsSquareMediumPrimary01)
        
        let chipsSquareSmallPrimary01 = ChipContentView(name: "chipOutlineSquareSmall01", chipArray: (0..<4).map { _ in
            DealiControl.chipOutlineSquareSmall01()
        })
        self.stackView.addArrangedSubview(chipsSquareSmallPrimary01)
        
        
        
        let chipsFilledSquareLargePrimary01 = ChipContentView(name: "chipFilledSquareLarge01", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledSquareLarge01()
        })
        self.stackView.addArrangedSubview(chipsFilledSquareLargePrimary01)
        
        let chipsFilledSquareLargePrimary02 = ChipContentView(name: "chipFilledSquareLarge02", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledSquareLarge02()
        })
        self.stackView.addArrangedSubview(chipsFilledSquareLargePrimary02)
        
        let chipsFilledSquareLargeScondary01 = ChipContentView(name: "chipFilledSquareLarge03", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledSquareLarge03()
        })
        self.stackView.addArrangedSubview(chipsFilledSquareLargeScondary01)
        
        let chipsFilledSquareMediumPrimary01 = ChipContentView(name: "chipFilledSquareMedium01", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledSquareMedium01()
        })
        self.stackView.addArrangedSubview(chipsFilledSquareMediumPrimary01)
        
        let chipsFilledSquareMediumScondary01 = ChipContentView(name: "chipFilledSquareMedium02", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledSquareMedium02()
        })
        self.stackView.addArrangedSubview(chipsFilledSquareMediumScondary01)
        
        let chipsFilledSquareSmallPrimary01 = ChipContentView(name: "chipFilledSquareSmall01", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledSquareSmall01()
        })
        self.stackView.addArrangedSubview(chipsFilledSquareSmallPrimary01)
        
        let chipsFilledSquareSmallScondary01 = ChipContentView(name: "chipFilledSquareSmall02", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledSquareSmall02()
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

