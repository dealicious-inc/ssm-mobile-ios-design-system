//
//  File.swift
//  
//
//  Created by JohyeonYoon on 11/6/23.
//

import UIKit
import DealiDesignKit

class MyViewController: DealiBottomSheetViewController {
    override func loadView() {
        super.loadView()
        
        self.titleLabel.text = "탈퇴확인"
        
        let contentLabel = UILabel()
        self.contentview.addSubview(contentLabel)
        contentLabel.then {
            
            let attrStr = NSAttributedString.make(string: "loc_text_447".localized(hint: "고객님의 데이터가 안전하게 삭제 완료되면 문자로 안내드리겠습니다.\n정말로 탈퇴하시겠습니까?"), font: .regular(14.0), color: UIColor.ssm.gray80, lineheightMultiple: 1.25)
            $0.attributedText = attrStr
            
            $0.numberOfLines = 0
            $0.textAlignment = .left
            $0.font = .regular(14.0)
            $0.textColor = UIColor.ssm.gray80
        }.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(16.0)
        }
       
}

