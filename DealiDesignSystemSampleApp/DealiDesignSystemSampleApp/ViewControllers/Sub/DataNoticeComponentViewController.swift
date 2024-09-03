//
//  DataNoticeComponentViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by Lee Chang Ho on 8/23/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class DataNoticeComponentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Data Notice"
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
            $0.backgroundColor = .white
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        let contentStackView = UIStackView()
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing =  30.0
            $0.alignment = .center
            $0.distribution = .equalSpacing
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.left.right.equalToSuperview()
        }
         
        let testContentStringArray = ["내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하",
                                      "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하"]
        
        let onlyBulletDataNoticeItemView = DealiDataNoticeItem(preset: .bullet)
        contentStackView.addArrangedSubview(onlyBulletDataNoticeItemView)
        onlyBulletDataNoticeItemView.then {
            $0.contentStringArray = testContentStringArray
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
        
        let onlyNumberDataNoticeItemView = DealiDataNoticeItem(preset: .numbering)
        contentStackView.addArrangedSubview(onlyNumberDataNoticeItemView)
        onlyNumberDataNoticeItemView.then {
            $0.contentStringArray = testContentStringArray
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
        
        let rTitleBulletDataNoticeItemView = DealiDataNoticeItemWithTitle(titlePreset: .regular, itemPreset: .bullet)
        contentStackView.addArrangedSubview(rTitleBulletDataNoticeItemView)
        rTitleBulletDataNoticeItemView.then {
            $0.title = "타이틀"
            $0.contentStringArray = testContentStringArray
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
        
        let rTitleNumberDataNoticeItemView = DealiDataNoticeItemWithTitle(titlePreset: .regular, itemPreset: .numbering)
        contentStackView.addArrangedSubview(rTitleNumberDataNoticeItemView)
        rTitleNumberDataNoticeItemView.then {
            $0.title = "타이틀"
            $0.contentStringArray = testContentStringArray
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
        
        let bTitleBulletDataNoticeItemView = DealiDataNoticeItemWithTitle(titlePreset: .bold, itemPreset: .bullet)
        contentStackView.addArrangedSubview(bTitleBulletDataNoticeItemView)
        bTitleBulletDataNoticeItemView.then {
            $0.title = "타이틀"
            $0.contentStringArray = testContentStringArray
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
        
        let bTitleNumberDataNoticeItemView = DealiDataNoticeItemWithTitle(titlePreset: .bold, itemPreset: .numbering)
        contentStackView.addArrangedSubview(bTitleNumberDataNoticeItemView)
        bTitleNumberDataNoticeItemView.then {
            $0.title = "타이틀"
            $0.contentStringArray = testContentStringArray
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
        }
    
//        let testLabel01 = UILabel()
//        contentStackView.addArrangedSubview(testLabel01)
//        testLabel01.then {
//            $0.numberOfLines = 0
//            $0.attributedText = NSMutableAttributedString(string: "안녕하세요dfgdfgdfg").font(.b1r15).color(DealiColor.g100).alignment(.center).setLineHeight()
//            $0.backgroundColor = .yellow
//        }.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//        }
//        
//        let testLabel02 = UILabel()
//        contentStackView.addArrangedSubview(testLabel02)
//        testLabel02.then {
//            $0.numberOfLines = 0
//            $0.attributedText = NSMutableAttributedString(string: "안녕하세요dfgdfgdfg").font(.b2r14).color(DealiColor.g100).alignment(.center).setLineHeight()
//            $0.backgroundColor = .yellow
//        }.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//        }
//        let testLabel03 = UILabel()
//        contentStackView.addArrangedSubview(testLabel03)
//        testLabel03.then {
//            $0.numberOfLines = 0
//            $0.attributedText = NSMutableAttributedString(string: "안녕하세요dfdfgdfg").font(.b1sb15).color(DealiColor.g100).alignment(.center).setLineHeight()
//            $0.backgroundColor = .yellow
//        }.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//        }
//        let testLabel04 = UILabel()
//        contentStackView.addArrangedSubview(testLabel04)
//        testLabel04.then {
//            $0.numberOfLines = 0
//            $0.attributedText = NSMutableAttributedString(string: "안녕하세요dfgdfgdfg").font(.h2sb24).color(DealiColor.g100).alignment(.center).setLineHeight()
//            $0.backgroundColor = .yellow
//        }.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//        }
//        let testLabel05 = UILabel()
//        contentStackView.addArrangedSubview(testLabel05)
//        testLabel05.then {
//            $0.numberOfLines = 0
//            $0.attributedText = NSMutableAttributedString(string: "안녕하세요dfgdfgdfg").font(.sh2r18).color(DealiColor.g100).alignment(.center).setLineHeight()
//            $0.backgroundColor = .yellow
//        }.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//        }
//        let testLabel06 = UILabel()
//        contentStackView.addArrangedSubview(testLabel06)
//        testLabel06.then {
//            $0.numberOfLines = 0
//            $0.attributedText = NSMutableAttributedString(string: "안녕하세요dfgdfgdfg").font(.sh3sb16).color(DealiColor.g100).alignment(.center).setLineHeight()
//            $0.backgroundColor = .yellow
//        }.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//        }
//        let testLabel07 = UILabel()
//        contentStackView.addArrangedSubview(testLabel07)
//        testLabel07.then {
//            $0.numberOfLines = 0
//            $0.attributedText = NSMutableAttributedString(string: "안녕하세요dfgdfgddfg").font(.h2sb24).color(DealiColor.g100).alignment(.center).setLineHeight()
//            $0.backgroundColor = .yellow
//        }.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//        }
    }

}
