//
//  BottomSheetPopupTestViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by hoji on 2023/11/21.
//  Copyright © 2023 Dealicious Inc. All rights reserved.
//

import UIKit
import DealiDesignKit

final class BottomSheetPopupTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "BottomSheetPopup"
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
        
        let bottomSheetPopupButton01 = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(bottomSheetPopupButton01)
        bottomSheetPopupButton01.then {
            $0.title = "2버튼 팝업"
            $0.addTarget(self, action: #selector(bottomSheetPopupButton01Pressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let singleSelectBottomSheetButton = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(singleSelectBottomSheetButton)
        singleSelectBottomSheetButton.then {
            $0.title = "Single Select BottomSheet"
            $0.addTarget(self, action: #selector(singleSelectBottomSheetButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let multiSelectBottomSheetButton = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(multiSelectBottomSheetButton)
        multiSelectBottomSheetButton.then {
            $0.title = "Multi Select BottomSheet"
            $0.addTarget(self, action: #selector(multiSelectBottomSheetButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let iconWithTextBottomSheetButton = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(iconWithTextBottomSheetButton)
        iconWithTextBottomSheetButton.then {
            $0.title = "Icon + Text BottomSheet"
            $0.addTarget(self, action: #selector(iconWithTextBottomSheetButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
        
        let slotWithTextBottomSheetButton = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(slotWithTextBottomSheetButton)
        slotWithTextBottomSheetButton.then {
            $0.title = "Slot + Text BottomSheet"
            $0.addTarget(self, action: #selector(slotWithTextBottomSheetButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
      
        let customBottomSheetButton = DealiControl.btnOutlineLarge01()
        contentStackView.addArrangedSubview(customBottomSheetButton)
        customBottomSheetButton.then {
            $0.title = "custom 팝업"
            $0.addTarget(self, action: #selector(customBottomSheetButtonPressed), for: .touchUpInside)
        }.snp.makeConstraints {
            $0.left.right.equalToSuperview()
        }
    }

}

extension BottomSheetPopupTestViewController {
    @objc func bottomSheetPopupButton01Pressed() {
        debugPrint("bottomSheetPopupButton01Pressed")

        DealiBottomSheet.showTextOnly(
            titleType: .titleCloseButton(title: "2버튼 팝업"),
            message: "일이삼사오육칠팔구십일이삼사오육칠팔구십일이삼사오육칠팔구십일이삼사오육칠팔구십일이삼사오육칠팔구십일이삼사오육칠팔구십일이삼사오육칠팔구십일이삼사오육칠팔구십일이삼사오육칠팔구십일이삼사오육칠팔구십일이삼사오육칠팔구십일이삼사오육칠팔구십일이삼사오육칠팔구십",
            buttonType: .twoButton(confirmTitle: "확인", cancelTitle: "취소"),
            popupPresentingViewController: self,
            cancelAction: nil, confirmAction: nil
        )
    }
    
    @objc func singleSelectBottomSheetButtonPressed() {
        
        let optionData: [DealiBottomSheetOptionData] = [
            DealiBottomSheetOptionData(optionName: "옵션1", isSelected: true),
            DealiBottomSheetOptionData(optionName: "옵션2"),
            DealiBottomSheetOptionData(optionName: "옵션3"),
            DealiBottomSheetOptionData(optionName: "옵션4"),
            DealiBottomSheetOptionData(optionName: "옵션5"),
            DealiBottomSheetOptionData(optionName: "옵션6"),
            DealiBottomSheetOptionData(optionName: "옵션7"),
            DealiBottomSheetOptionData(optionName: "옵션8"),
            DealiBottomSheetOptionData(optionName: "옵션9"),
            DealiBottomSheetOptionData(optionName: "옵션0"),
            DealiBottomSheetOptionData(optionName: "옵션1"),
            DealiBottomSheetOptionData(optionName: "옵션2"),
            DealiBottomSheetOptionData(optionName: "옵션3"),
            DealiBottomSheetOptionData(optionName: "옵션4"),
            DealiBottomSheetOptionData(optionName: "옵션5"),
            DealiBottomSheetOptionData(optionName: "옵션6"),
            DealiBottomSheetOptionData(optionName: "옵션7"),
            DealiBottomSheetOptionData(optionName: "옵션8"),
            DealiBottomSheetOptionData(optionName: "옵션9"),
            DealiBottomSheetOptionData(optionName: "옵션10"),
            DealiBottomSheetOptionData(optionName: "옵션11"),
            DealiBottomSheetOptionData(optionName: "옵션2"),
            DealiBottomSheetOptionData(optionName: "옵션2"),
            DealiBottomSheetOptionData(optionName: "옵션2"),
            DealiBottomSheetOptionData(optionName: "옵션2"),
            DealiBottomSheetOptionData(optionName: "옵션2"),
            DealiBottomSheetOptionData(optionName: "옵션2"),
            DealiBottomSheetOptionData(optionName: "옵션2"),
            DealiBottomSheetOptionData(optionName: "옵션2")
            
        ]
                                                        
        DealiBottomSheet.showSingleSelectionType(
            titleType: .titleCloseButton(title: "단일선택 바텀시트"),
            option: optionData, 
            popupPresentingViewController: self,
            selectAction: { indecies in
                debugPrint("눌림:\(indecies)")
                
            }, cancelAction: nil,
            confirmAction: nil
        )
    }
    
    @objc func multiSelectBottomSheetButtonPressed() {
        
        let optionData: [DealiBottomSheetOptionData] = [DealiBottomSheetOptionData(optionName: "옵션1", isSelected: true), DealiBottomSheetOptionData(optionName: "옵션2")]
                                                        
        DealiBottomSheet.showMultiSelectionType(
            titleType: .title(title: "다중선택 바텀시트"),
            option: optionData,
            popupPresentingViewController: self,
            selectAction: { indecies in
                debugPrint("다중선택 눌림:\(indecies)")
                
            }, cancelAction: nil,
            confirmAction: nil
        )
    }
    
    @objc func iconWithTextBottomSheetButtonPressed() {
        
        let optionData: [DealiBottomSheetOptionData] = [
            DealiBottomSheetOptionData(optionName: "옵션1", isSelected: true, imageName: "img_mbs_filled_16_ver01"),
            DealiBottomSheetOptionData(optionName: "옵션2", imageName: "img_mbs_filled_16_ver01")
        ]
                                                        
        DealiBottomSheet.showIconWithTextType(
            titleType: .title(title: "icon + Text 바텀시트"),
            option: optionData,
            popupPresentingViewController: self,
            selectAction: { indecies in
                debugPrint("icon + Text 눌림:\(indecies)")
                
            }, cancelAction: nil,
            confirmAction: nil
        )
    }
    
    @objc func slotWithTextBottomSheetButtonPressed() {
        
        let optionData: [DealiBottomSheetOptionData] = [
            DealiBottomSheetOptionData(optionName: "옵션1", isSelected: true, imageName: "img_mbs_filled_16_ver01"),
            DealiBottomSheetOptionData(optionName: "옵션2", imageName: "img_mbs_filled_16_ver01")
        ]
                                                        
        DealiBottomSheet.showSlotWithTextType(
            titleType: .title(title: "slot + Text 바텀시트"),
            option: optionData,
            slotSize: .large,
            popupPresentingViewController: self,
            selectAction: { indecies in
                debugPrint("slot + Text 눌림:\(indecies)")
                
            }, cancelAction: nil,
            confirmAction: nil
        )
    }
    
    @objc func customBottomSheetButtonPressed() {
        let customView = UIView()
        customView.do {
            $0.backgroundColor = .g05
        }
        
        let colorImageView = UIImageView()
        customView.addSubview(colorImageView)
        colorImageView.then {
            $0.backgroundColor = .secondary01
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 50.0
        }.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.size.equalTo(CGSize(width: 100.0, height: 100.0))
        }
        
        DealiBottomSheet.showBottomSheet(optionContentView: customView, popupPresentingViewController: self, cancelAction: nil, confirmAction: nil)
    }
}
