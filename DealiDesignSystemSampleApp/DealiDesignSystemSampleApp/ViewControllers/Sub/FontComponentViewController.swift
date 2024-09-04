//
//  FontComponentViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 9/4/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

class FontComponentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Font"
        self.view.backgroundColor = .white
    }

    override func loadView() {
        super.loadView()
        
        let contentScrollView = UIScrollView()
        self.view.addSubview(contentScrollView)
        contentScrollView.then {
            $0.bounces = false
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        let contentView = UIView()
        contentScrollView.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        let contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing = 10.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview().inset(20.0)
        }
        
        let c1r10 = FontLabel(font: .c1r10, fontString: "c1r10")
        contentStackView.addArrangedSubview(c1r10)
        c1r10.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let c1sb10 = FontLabel(font: .c1sb10, fontString: "c1sb10")
        contentStackView.addArrangedSubview(c1sb10)
        c1sb10.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let b4r12 = FontLabel(font: .b4r12, fontString: "b4r12")
        contentStackView.addArrangedSubview(b4r12)
        b4r12.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let b4sb12 = FontLabel(font: .b4sb12, fontString: "b4sb12")
        contentStackView.addArrangedSubview(b4sb12)
        b4sb12.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let b3r13 = FontLabel(font: .b3r13, fontString: "b3r13")
        contentStackView.addArrangedSubview(b3r13)
        b3r13.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        let b3sb13 = FontLabel(font: .b3sb13, fontString: "b3sb13")
        contentStackView.addArrangedSubview(b3sb13)
        b3sb13.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let b2r14 = FontLabel(font: .b2r14, fontString: "b2r14")
        contentStackView.addArrangedSubview(b2r14)
        b2r14.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let b2sb14 = FontLabel(font: .b2sb14, fontString: "b2sb14")
        contentStackView.addArrangedSubview(b2sb14)
        b2sb14.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let b1r15 = FontLabel(font: .b1r15, fontString: "b1r15")
        contentStackView.addArrangedSubview(b1r15)
        b1r15.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let b1sb15 = FontLabel(font: .b1sb15, fontString: "b1sb15")
        contentStackView.addArrangedSubview(b1sb15)
        b1sb15.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let sh3r16 = FontLabel(font: .sh3r16, fontString: "sh3r16")
        contentStackView.addArrangedSubview(sh3r16)
        sh3r16.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let sh3sb16 = FontLabel(font: .sh3sb16, fontString: "sh3sb16")
        contentStackView.addArrangedSubview(sh3sb16)
        sh3sb16.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let sh2r18 = FontLabel(font: .sh2r18, fontString: "sh2r18")
        contentStackView.addArrangedSubview(sh2r18)
        sh2r18.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let sh2sb18 = FontLabel(font: .sh2sb18, fontString: "sh2sb18")
        contentStackView.addArrangedSubview(sh2sb18)
        sh2sb18.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let sh1r20 = FontLabel(font: .sh1r20, fontString: "sh1r20")
        contentStackView.addArrangedSubview(sh1r20)
        sh1r20.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let sh1sb20 = FontLabel(font: .sh1sb20, fontString: "sh1sb20")
        contentStackView.addArrangedSubview(sh1sb20)
        sh1sb20.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let h3sb28 = FontLabel(font: .h3sb28, fontString: "h3sb28")
        contentStackView.addArrangedSubview(h3sb28)
        h3sb28.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let h2sb24 = FontLabel(font: .h2sb24, fontString: "h2sb24")
        contentStackView.addArrangedSubview(h2sb24)
        h2sb24.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let h1sb32 = FontLabel(font: .h1sb32, fontString: "h1sb32")
        contentStackView.addArrangedSubview(h1sb32)
        h1sb32.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }
}

class FontLabel: UIView {
    init(font: UIFont, fontString: String) {
        super.init(frame: .zero)
        
        let label = UILabel()
        self.addSubview(label)
        label.then {
            $0.attributedText = NSMutableAttributedString(string: "폰트asfgASFG_\(fontString)").font(font).color(DealiColor.g100).alignment(.left).setLineHeight()
            $0.backgroundColor = .yellow
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(6.0)
            $0.left.right.equalToSuperview()
        }
        
        let centerLineView = UIImageView()
        self.addSubview(centerLineView)
        centerLineView.then {
            $0.backgroundColor = .red
        }.snp.makeConstraints {
            $0.height.equalTo(0.5)
            $0.left.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
