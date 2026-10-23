//
//  ChipViewController.swift
//  
//
//  Created by 박경우 on 2023/10/23.
//

import UIKit
import DealiDesignKit

class ChipViewController: UIViewController {
    
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
        super.loadView()
        
        self.view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.left.right.equalTo(self.view.safeAreaLayoutGuide)
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

        if isSwiftUI {
            self.setAsSwiftUI()
        } else {
            self.setAsUIKit()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setAsUIKit() {
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
        
        let chipsFilledLargeSecondary01 = ChipContentView(name: "chipFilledLarge02", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledLarge02()
        })
        self.stackView.addArrangedSubview(chipsFilledLargeSecondary01)
        
        let chipsFilledLargePrimary02 = ChipContentView(name: "chipFilledLarge03", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledLarge03()
        })
        self.stackView.addArrangedSubview(chipsFilledLargePrimary02)
        
        let chipsFilledLargeSecondary02 = ChipContentView(name: "chipFilledLarge04", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledLarge04()
        })
        self.stackView.addArrangedSubview(chipsFilledLargeSecondary02)
        
        let chipsFilledMediumPrimary01 = ChipContentView(name: "chipFilledMedium01", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledMedium01()
        })
        self.stackView.addArrangedSubview(chipsFilledMediumPrimary01)
        
        let chipsFilledMediumSecondary01 = ChipContentView(name: "chipFilledMedium02", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledMedium02()
        })
        self.stackView.addArrangedSubview(chipsFilledMediumSecondary01)
        
        let chipsFilledMediumPrimary02 = ChipContentView(name: "chipFilledMedium03", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledMedium03()
        })
        self.stackView.addArrangedSubview(chipsFilledMediumPrimary02)
        
        let chipsFilledMediumSecondary02 = ChipContentView(name: "chipFilledMedium04", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledMedium04()
        })
        self.stackView.addArrangedSubview(chipsFilledMediumSecondary02)
        
        let chipsFilledSmallPrimary01 = ChipContentView(name: "chipFilledSmall01", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledSmall01()
        })
        self.stackView.addArrangedSubview(chipsFilledSmallPrimary01)
        
        let chipsFilledSmallScondary01 = ChipContentView(name: "chipFilledSmall02", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledSmall02()
        })
        self.stackView.addArrangedSubview(chipsFilledSmallScondary01)
        
        let chipsFilledSmallPrimary02 = ChipContentView(name: "chipFilledSmall03", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledSmall03()
        })
        self.stackView.addArrangedSubview(chipsFilledSmallPrimary02)
        
        let chipsFilledSmallSecondary02 = ChipContentView(name: "chipFilledSmall04", chipArray: (0..<4).map { _ in
            DealiControl.chipFilledSmall04()
        })
        self.stackView.addArrangedSubview(chipsFilledSmallSecondary02)
        
        
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

        self.stackView.addArrangedSubview(DepthChipContentView(name: "chipFilledDepthLarge01", chipArray: (0..<3).map { _ in
            DealiControl.chipFilledDepthLarge01()
        }))
        self.stackView.addArrangedSubview(DepthChipContentView(name: "chipFilledDepthMedium01", chipArray: (0..<3).map { _ in
            DealiControl.chipFilledDepthMedium01()
        }))
        self.stackView.addArrangedSubview(DepthChipContentView(name: "chipFilledDepthSmall01", chipArray: (0..<3).map { _ in
            DealiControl.chipFilledDepthSmall01()
        }))
    }
    
    func setAsSwiftUI() {
        let chipOutlineLarge01 = SwiftUIChipContentView(name: "chipOutlineLarge01", type: .chipOutlineLarge01)
        self.stackView.addArrangedSubview(chipOutlineLarge01)
        
        let chipOutlineMedium01 = SwiftUIChipContentView(name: "chipOutlineMedium01", type: .chipOutlineMedium01)
        self.stackView.addArrangedSubview(chipOutlineMedium01)
        
        let chipOutlineMedium02 = SwiftUIChipContentView(name: "chipOutlineMedium02", type: .chipOutlineMedium02)
        self.stackView.addArrangedSubview(chipOutlineMedium02)
        
        let chipOutlineSmall01 = SwiftUIChipContentView(name: "chipOutlineSmall01", type: .chipOutlineSmall01)
        self.stackView.addArrangedSubview(chipOutlineSmall01)
        
        let chipFilledLarge01 = SwiftUIChipContentView(name: "chipFilledLarge01", type: .chipFilledLarge01)
        self.stackView.addArrangedSubview(chipFilledLarge01)
        
        let chipFilledLarge02 = SwiftUIChipContentView(name: "chipFilledLarge02", type: .chipFilledLarge02)
        self.stackView.addArrangedSubview(chipFilledLarge02)
        
        let chipFilledLarge03 = SwiftUIChipContentView(name: "chipFilledLarge03", type: .chipFilledLarge03)
        self.stackView.addArrangedSubview(chipFilledLarge03)
        
        let chipFilledLarge04 = SwiftUIChipContentView(name: "chipFilledLarge04", type: .chipFilledLarge04)
        self.stackView.addArrangedSubview(chipFilledLarge04)
        
        let chipFilledMedium01 = SwiftUIChipContentView(name: "chipFilledMedium01", type: .chipFilledMedium01)
        self.stackView.addArrangedSubview(chipFilledMedium01)
        
        let chipFilledMedium02 = SwiftUIChipContentView(name: "chipFilledMedium02", type: .chipFilledMedium02)
        self.stackView.addArrangedSubview(chipFilledMedium02)
        
        let chipFilledMedium03 = SwiftUIChipContentView(name: "chipFilledMedium03", type: .chipFilledMedium03)
        self.stackView.addArrangedSubview(chipFilledMedium03)
        
        let chipFilledMedium04 = SwiftUIChipContentView(name: "chipFilledMedium04", type: .chipFilledMedium04)
        self.stackView.addArrangedSubview(chipFilledMedium04)
        
        let chipFilledSmall01 = SwiftUIChipContentView(name: "chipFilledSmall01", type: .chipFilledSmall01)
        self.stackView.addArrangedSubview(chipFilledSmall01)
        
        let chipFilledSmall02 = SwiftUIChipContentView(name: "chipFilledSmall02", type: .chipFilledSmall02)
        self.stackView.addArrangedSubview(chipFilledSmall02)
        
        let chipFilledSmall03 = SwiftUIChipContentView(name: "chipFilledSmall03", type: .chipFilledSmall03)
        self.stackView.addArrangedSubview(chipFilledSmall03)
        
        let chipFilledSmall04 = SwiftUIChipContentView(name: "chipFilledSmall04", type: .chipFilledSmall04)
        self.stackView.addArrangedSubview(chipFilledSmall04)
        
        let chipOutlineSquareLarge01 = SwiftUIChipContentView(name: "chipOutlineSquareLarge01", type: .chipOutlineSquareLarge01)
        self.stackView.addArrangedSubview(chipOutlineSquareLarge01)
        
        let chipOutlineSquareMedium01 = SwiftUIChipContentView(name: "chipOutlineSquareMedium01", type: .chipOutlineSquareMedium01)
        self.stackView.addArrangedSubview(chipOutlineSquareMedium01)
        
        let chipOutlineSquareSmall01 = SwiftUIChipContentView(name: "chipOutlineSquareSmall01", type: .chipOutlineSquareSmall01)
        self.stackView.addArrangedSubview(chipOutlineSquareSmall01)
        
        let chipFilledSquareLarge01 = SwiftUIChipContentView(name: "chipFilledSquareLarge01", type: .chipFilledSquareLarge01)
        self.stackView.addArrangedSubview(chipFilledSquareLarge01)
        
        let chipFilledSquareLarge02 = SwiftUIChipContentView(name: "chipFilledSquareLarge02", type: .chipFilledSquareLarge02)
        self.stackView.addArrangedSubview(chipFilledSquareLarge02)
        
        let chipFilledSquareLarge03 = SwiftUIChipContentView(name: "chipFilledSquareLarge03", type: .chipFilledSquareLarge03)
        self.stackView.addArrangedSubview(chipFilledSquareLarge03)
        
        let chipFilledSquareMedium01 = SwiftUIChipContentView(name: "chipFilledSquareMedium01", type: .chipFilledSquareMedium01)
        self.stackView.addArrangedSubview(chipFilledSquareMedium01)
        
        let chipFilledSquareMedium02 = SwiftUIChipContentView(name: "chipFilledSquareMedium02", type: .chipFilledSquareMedium02)
        self.stackView.addArrangedSubview(chipFilledSquareMedium02)
        
        let chipFilledSquareSmall01 = SwiftUIChipContentView(name: "chipFilledSquareSmall01", type: .chipFilledSquareSmall01)
        self.stackView.addArrangedSubview(chipFilledSquareSmall01)
        
        let chipFilledSquareSmall02 = SwiftUIChipContentView(name: "chipFilledSquareSmall02", type: .chipFilledSquareSmall02)
        self.stackView.addArrangedSubview(chipFilledSquareSmall02)
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
            $0.textColor = .g100
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

/// Depth 칩 샘플. Default / Selected / Disabled 세 개를 세로로 보여준다
final class DepthChipContentView: UIView {

    private let titleLabel = UILabel()
    private let stackView = UIStackView()

    init(name: String, chipArray: [DealiDepthChip]) {
        super.init(frame: CGRect.zero)

        self.backgroundColor = UIColor.white

        self.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.text = name
            $0.font = .b1sb15
            $0.textColor = .g100
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
            $0.top.equalToSuperview()
            $0.height.equalTo(60.0)
        }

        self.addSubview(self.stackView)
        self.stackView.then {
            $0.axis = .vertical
            $0.alignment = .leading
            $0.spacing = 12.0
        }.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.left.equalTo(titleLabel)
            $0.bottom.equalToSuperview().offset(-20.0)
        }

        for (index, chip) in chipArray.enumerated() {
            self.stackView.addArrangedSubview(chip)
            chip.items = [
                DealiDepthChipItem(title: "여성의류"),
                DealiDepthChipItem(title: "아우터", leftImage: index == 1 ? UIImage.dealiIcon(named: "ic_bookmark_1") : nil),
                DealiDepthChipItem(title: index == 0 ? "Default" : (index == 1 ? "Selected" : "Disabled"))
            ]
            chip.onDeleteTap = { [weak chip] in
                guard let chip, let stackView = chip.superview as? UIStackView else { return }
                stackView.removeArrangedSubview(chip)
                chip.removeFromSuperview()
            }
            if index == 1 {
                chip.status = .selected
            } else if index == 2 {
                chip.status = .disabled
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class SwiftUIChipContentView: UIView {
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    
    init(name: String, type: ChipViewType) {
        super.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.white
        
        self.addSubview(self.titleLabel)
        self.titleLabel.then {
            $0.text = name
            $0.font = .b1sb15
            $0.textColor = .g100
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(20.0)
            $0.top.equalToSuperview()
            $0.height.equalTo(60.0)
        }
        
        self.addSubview(self.stackView)
        self.stackView.then {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.left.right.equalTo(titleLabel)
            $0.bottom.equalToSuperview().offset(-20.0)
        }
        
        for i in 0..<4 {
            let chipViewModel = ChipViewModel(type: type)
            let chip = ChipView(viewModel: chipViewModel)
            self.stackView.addArrangedSubview(chip.UIKit())
            if i == 0 {
                chipViewModel.text = "Default"
                chipViewModel.status = .normal
            } else if i == 1 {
                chipViewModel.text = "Selected"
                chipViewModel.status = .selected
            } else if i == 2 {
                chipViewModel.text = "Disabled"
                chipViewModel.status = .disabled
            } else {
                chipViewModel.text = nil
                chipViewModel.singleImage = UIImage(named: "ic_refresh")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

