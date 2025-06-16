//
//  BottomSheetViewController.swift
//
//
//  Created by JohyeonYoon on 11/6/23.
//

import UIKit
import DealiDesignKit

class BottomSheetViewController: DealiBottomSheetViewController {
    override func loadView() {
        super.loadView()
        
        self.titleLabel.text = "탈퇴확인"
        
        let contentLabel = UILabel()
        self.contentview.addSubview(contentLabel)
        contentLabel.then {
            
            let attrStr = "고객님의 데이터가 안전하게 삭제 완료되면 문자로 안내드리겠습니다.\n정말로 탈퇴하시겠습니까?"
            
            $0.numberOfLines = 0
            $0.textAlignment = .left
            $0.font = .b2r14
            $0.textColor = .g80
            $0.text = attrStr
        }.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(16.0)
            $0.bottom.equalToSuperview().inset(30.0)
        }
    }
       
}

