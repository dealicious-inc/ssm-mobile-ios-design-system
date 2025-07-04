//
//  AccordionComponentViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이창호 on 10/21/24.
//  Copyright © 2024 Dealicious Inc. All rights reserved.
//

import UIKit
import SwiftUI
import DealiDesignKit

final class AccordionComponentViewController: UIViewController {
    
    private var isSwiftUI: Bool
    
    let contentStackView = UIStackView()
    
    init(isSwiftUI: Bool = false) {
        self.isSwiftUI = isSwiftUI
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Accordion Component"
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
        
        contentView.addSubview(contentStackView)
        contentStackView.then {
            $0.axis = .vertical
            $0.spacing =  30.0
            $0.alignment = .top
            $0.distribution = .fill
        }.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.bottom.left.right.equalToSuperview().inset(16.0)
        }
         
        if self.isSwiftUI {
            self.setSwiftUI()
        } else {
            self.setUIKit()
        }
    }

    func setUIKit() {
        let accordionView01 = DealiAccordionView()
        contentStackView.addArrangedSubview(accordionView01)
        accordionView01.then {
            $0.title = "아코디언 01"
            $0.accordionItemViewArray = self.createAccordionTestViewArray(count: 1)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionView02 = DealiAccordionView()
        contentStackView.addArrangedSubview(accordionView02)
        accordionView02.then {
            $0.title = "아코디언 02"
            $0.accordionItemSpacing = 12.0
            $0.accordionItemViewArray = self.createAccordionTestViewArray(count: 7)
            $0.showAccordion(isOpen: true, animation: false)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionView03 = DealiAccordionView()
        contentStackView.addArrangedSubview(accordionView03)
        accordionView03.then {
            $0.title = "아코디언 03"
            $0.accordionItemViewArray = self.createAccordionTestViewArray(count: 5)
            $0.accordionItemSpacing = 8.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionWithLabeledTextBullet01 = DealiAccordionWithLabeledTextView()
        contentStackView.addArrangedSubview(accordionWithLabeledTextBullet01)
        accordionWithLabeledTextBullet01.then {
            $0.title = "LabeledText Accordion Bullet01"
            $0.accordionLabeledTextModelArray = [self.createLabeledTextItemModel(preset: .labeledTextBullet01, count: 4)]
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionWithLabeledTextBullet02 = DealiAccordionWithLabeledTextView()
        contentStackView.addArrangedSubview(accordionWithLabeledTextBullet02)
        accordionWithLabeledTextBullet02.then {
            $0.title = "LabeledText Accordion Bullet02"
            $0.accordionLabeledTextModelArray = [self.createLabeledTextItemModel(preset: .labeledTextBullet02, count: 5)]
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionWithLabeledTextNumber01 = DealiAccordionWithLabeledTextView()
        contentStackView.addArrangedSubview(accordionWithLabeledTextNumber01)
        accordionWithLabeledTextNumber01.then {
            $0.title = "LabeledText Accordion Number01"
            $0.accordionLabeledTextModelArray = [self.createLabeledTextItemModel(preset: .labeledTextNumber01, count: 6)]
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionWithLabeledTextNumber02 = DealiAccordionWithLabeledTextView()
        contentStackView.addArrangedSubview(accordionWithLabeledTextNumber02)
        accordionWithLabeledTextNumber02.then {
            $0.title = "LabeledText Accordion Number02"
            $0.accordionLabeledTextModelArray = [self.createLabeledTextItemModel(preset: .labeledTextNumber02, count: 7)]
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionWithLabeledTextIcon01 = DealiAccordionWithLabeledTextView()
        contentStackView.addArrangedSubview(accordionWithLabeledTextIcon01)
        accordionWithLabeledTextIcon01.then {
            $0.title = "LabeledText Accordion Icon01"
            $0.accordionLabeledTextModelArray = [self.createLabeledTextItemModel(preset: .labeledTextIcon01, count: 6)]
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionWithLabeledTextIcon02 = DealiAccordionWithLabeledTextView()
        contentStackView.addArrangedSubview(accordionWithLabeledTextIcon02)
        accordionWithLabeledTextIcon02.then {
            $0.title = "LabeledText Accordion Icon02"
            $0.accordionLabeledTextModelArray = [self.createLabeledTextItemModel(preset: .labeledTextNumber02, count: 5)]
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let accordionWithLabeledTextTotal = DealiAccordionWithLabeledTextView()
        contentStackView.addArrangedSubview(accordionWithLabeledTextTotal)
        accordionWithLabeledTextTotal.then {
            $0.title = "LabeledText Accordion Total"
            $0.accordionLabeledTextModelArray = [self.createLabeledTextItemModel(preset: .labeledTextBullet01, title: "Bullet01", count: 1),
                                                 self.createLabeledTextItemModel(preset: .labeledTextBullet02, title: "Bullet02", titleImageName: "ic_info", count: 2),
                                                 self.createLabeledTextItemModel(preset: .labeledTextNumber01, title: "Number01", count: 3),
                                                 self.createLabeledTextItemModel(preset: .labeledTextNumber02, title: "Number02", titleImageName: "ic_info", count: 4),
                                                 self.createLabeledTextItemModel(preset: .labeledTextIcon01, title: "Icon01", count: 3),
                                                 self.createLabeledTextItemModel(preset: .labeledTextIcon02, title: "Icon02", titleImageName: "ic_info", count: 2)]
            $0.accordionItemSpacing = 50.0
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }
    
    func setSwiftUI() {
        let modelArray: [LabeledTextModel] = {
            [
                LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Rectangle().frame(width: 32.0, height: 16.0).foregroundStyle(MbsGradient.gradient01.swiftUIGradient)),
                LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Circle().frame(width: 16.0, height: 16.0).foregroundStyle(MbsGradient.gradient02.swiftUIGradient)),
                LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Rectangle().frame(width: 32.0, height: 16.0).foregroundStyle(MbsGradient.gradient01.swiftUIGradient)),
                LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Circle().frame(width: 16.0, height: 16.0).foregroundStyle(MbsGradient.gradient02.swiftUIGradient)),
                LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Rectangle().frame(width: 32.0, height: 16.0).foregroundStyle(MbsGradient.gradient01.swiftUIGradient))
            ]
        }()
        
        let view = VStack(spacing: 20.0) {
                AccordionView()
                    .title("LabeledText_03")
                    .isInitiallyOpen()
                    .withLabeledText(preset: .labeledTextNumber02, labeledModelArray: modelArray)
                AccordionView()
                    .title("LabeledText_04")
                    .withLabeledText(labeledModelArray: modelArray)
            }
            .padding(EdgeInsets(top: 16.0, leading: 16.0, bottom: 0.0, trailing: 16.0))
        
        self.contentStackView.addArrangedSubview(view.UIKit())
        
//        var result = AccordionView()
//            .title("LabeledText_04")
//            .withLabeledText(labeledModelArray: modelArray)
//            .toUIView(embeddedIn: self)
        
//        self.detachBag.add(result)
        
//        let view = result.view
//        self.contentStackView.addArrangedSubview(view)
        
        let accordionView = AccordionUIView()
        accordionView.setContentCompressionResistancePriority(.required, for: .vertical)
        self.contentStackView.addArrangedSubview(accordionView)
        accordionView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
//        
//        let accordionView2 = AccordionUIView()
//        accordionView2.setContentCompressionResistancePriority(.required, for: .vertical)
//        self.contentStackView.addArrangedSubview(accordionView2)
//        accordionView2.snp.makeConstraints {
//            $0.left.right.equalToSuperview()
//        }
        
        
//        let contentView = UIView()
//        self.contentStackView.addArrangedSubview(contentView)
//        contentView.snp.makeConstraints( {
//            $0.height.equalTo(52.0)
//            $0.left.right.equalToSuperview()
//        })
//        var accordionView = AccordionView()
//            .title("LabeledText_04")
//            .withLabeledText(labeledModelArray: modelArray)
//        accordionView.onHeightChange = { [weak self] newHeight in
//            guard let self else { return }
//            print("현재 AccordionView 높이: \(newHeight)")
//            contentView.snp.updateConstraints {
//                $0.height.equalTo(newHeight)
//            }
//            self.view.layoutIfNeeded()
//        }
//        let view = accordionView.UIKit()
//        contentView.addSubview(view)
//        view.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
        
        
//        let contentView2 = UIView()
//        self.contentStackView.addArrangedSubview(contentView2)
//        contentView2.snp.makeConstraints( {
////            $0.height.equalTo(52.0)
//            $0.height.greaterThanOrEqualTo(52.0)
//            $0.left.right.equalToSuperview()
//        })
//        var accordionView2 = AccordionView()
//            .title("LabeledText_04")
//            .withLabeledText(labeledModelArray: modelArray)
//        accordionView2.onHeightChange = { [weak self] newHeight in
//            guard let self else { return }
//            print("현재 AccordionView 높이: \(newHeight)")
//            contentView2.snp.updateConstraints {
//                $0.height.equalTo(newHeight)
//            }
//            self.view.layoutIfNeeded()
//        }
//        let view2 = accordionView2.UIKit()
//        contentView2.addSubview(view2)
//        view2.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
    }
    
    private func createAccordionTestViewArray(count: Int) -> [UIView] {
        var accordionTestViewArray: [UIView] = []
        for _ in 0..<count {
            let accordionTestView = UIView()
            accordionTestView.then {
                $0.backgroundColor = self.getRandomColor()
            }.snp.makeConstraints {
                $0.height.equalTo(200.0)
            }
            accordionTestViewArray.append(accordionTestView)
        }
        
        return accordionTestViewArray
    }
    
    private func createLabeledTextItemModel(preset: DealiLabeledTextPreset, title: String? = nil, titleImageName: String? = nil, count: Int) -> DealiAccordionLabeledTextModel {
        var labeledModelArray: [DealiLabeledTextModel] = []
        for index in 0..<count {
            labeledModelArray.append(DealiLabeledTextModel(message: "내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하", iconName: ((index % 2 == 0) ? "ic_plus_ad_forward" : "ic_repeat")))
        }
        
        return DealiAccordionLabeledTextModel(preset: preset, modelArray: labeledModelArray, title: title, titleImageName: titleImageName)
    }
    
    private func getRandomColor() -> UIColor {
        let red: CGFloat = CGFloat(drand48())
        let green: CGFloat = CGFloat(drand48())
        let blue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

class AccordionUIView: UIView {
    private var accordionView: AccordionView?
    private var hostingViewController: UIViewController?
    
    let modelArray: [LabeledTextModel] = {
        [
            LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Rectangle().frame(width: 32.0, height: 16.0).foregroundStyle(MbsGradient.gradient01.swiftUIGradient)),
            LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Circle().frame(width: 16.0, height: 16.0).foregroundStyle(MbsGradient.gradient02.swiftUIGradient)),
            LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Rectangle().frame(width: 32.0, height: 16.0).foregroundStyle(MbsGradient.gradient01.swiftUIGradient)),
            LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Circle().frame(width: 16.0, height: 16.0).foregroundStyle(MbsGradient.gradient02.swiftUIGradient)),
            LabeledTextModel(message: AttributedString("내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하"), icon: .dealiIcon(named: "ic_plus_ad_forward"), customView: Rectangle().frame(width: 32.0, height: 16.0).foregroundStyle(MbsGradient.gradient01.swiftUIGradient))
        ]
    }()
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard hostingViewController == nil else { return }
        
        var accordionView = AccordionView()
            .title("LabeledText_04")
            .withLabeledText(labeledModelArray: modelArray)
        accordionView.onSizeChange = { [weak self] in
//            self?.setNeedsLayout()
//            self?.layoutIfNeeded()
            self?.invalidateIntrinsicContentSize()
        }
        self.accordionView = accordionView
        hostingViewController = UIHostingController(rootView: accordionView)
        
        guard let embeddedView = hostingViewController?.view else { return }
        
        // Pin view to edges of hosting view
        embeddedView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(embeddedView)
        [
            embeddedView.topAnchor.constraint(equalTo: topAnchor),
            embeddedView.bottomAnchor.constraint(equalTo: bottomAnchor),
            embeddedView.leadingAnchor.constraint(equalTo: leadingAnchor),
            embeddedView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ].forEach { $0.isActive = true }
    }
    
    override var intrinsicContentSize: CGSize {
        return hostingViewController?.view.intrinsicContentSize ?? .zero // #4
    }
}
