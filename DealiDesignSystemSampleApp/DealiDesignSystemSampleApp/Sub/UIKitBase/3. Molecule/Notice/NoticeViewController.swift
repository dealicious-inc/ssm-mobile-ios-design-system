//
//  NoticeViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 윤조현 on 12/24/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class NoticeViewController: UIViewController {
    
    private let noticeView = DealiNotice()

    private let noticeViewWithTitle = DealiNotice()
    private let noticeViewWithLabeledTexts = DealiNotice()
    private let noticeViewWithLabeledTextGroup = DealiNotice()

    override func loadView() {
        self.view = .init()
        
        self.setUI()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

private extension NoticeViewController {
    func setUI() {
        self.view.backgroundColor = .primary04
        
        let contentScrollView = UIScrollView()
        self.view.addSubview(contentScrollView)
        contentScrollView.then {
            $0.bounces = false
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let contentView = UIView()
        contentScrollView.addSubview(contentView)
        contentView.then {
            $0.backgroundColor = .clear
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        let customBodyView = UIView().then {
            $0.backgroundColor = .success
        }
        
        contentView.addSubview(noticeView)
        noticeView.then {
            $0.setTextLinkButton(DealiControl.textLinkSmall01().then {
                $0.title = ("TextLink")
            })
            
            $0.addContents(customBodyView) {
                $0.edges.equalToSuperview().inset(16.0)
                $0.height.equalTo(200.0)
            }
        }.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(16.0)
        }
        
        contentView.addSubview(noticeViewWithTitle)
        noticeViewWithTitle.then {
            $0.title = "Notice with Custom Body"
            $0.setTextLinkButton(DealiControl.textLinkSmall01().then {
                $0.title = ("TextLink")
            })
            
            $0.addContents(customBodyView) {
                $0.edges.equalToSuperview().inset(16.0)
                $0.height.equalTo(200.0)
            }
        }.snp.makeConstraints {
            $0.top.equalTo(noticeView.snp.bottom).offset(16.0)
            $0.left.right.equalToSuperview().inset(16.0)
        }
        
        
        let labeledTextViewModel: [DealiLabeledTextModel] = [
            DealiLabeledTextModel(message: "내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하"),
            DealiLabeledTextModel(message: "내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하 하하하"),
        ]
        
        let labeledTextViews = labeledTextViewModel.enumerated().map { (index, model) in
            if index == 0 {
                return DealiLabeledTextView(preset: .labeledTextBullet01, model: model)

            }
            return DealiLabeledTextView(preset: .labeledTextBullet02, model: model)
        }
        
        contentView.addSubview(noticeViewWithLabeledTexts)
        noticeViewWithLabeledTexts.then {
            $0.title = "Notice with LabeledText ArrayNotice with LabeledText ArrayNotice with LabeledText ArrayNotice with LabeledText ArrayNotice with LabeledText ArrayNotice with LabeledText Array"
            $0.addLabeledTexts(labeledTextViews)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
            $0.top.equalTo(noticeViewWithTitle.snp.bottom).offset(16.0)
        }
        
        let labeledTextGroupView = DealiLabeledText.labeledTextNumber01().then {
            $0.configure(modelArray: labeledTextViewModel)
        }
        
        contentView.addSubview(noticeViewWithLabeledTextGroup)
        noticeViewWithLabeledTextGroup.then {
            $0.title = "Notice with LabeledText Group"
            $0.addLabeledTextGroups(labeledTextGroupView)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(16.0)
            $0.top.equalTo(noticeViewWithLabeledTexts.snp.bottom).offset(16.0)
        }
        
    }
}
