//
//  TypographyViewController.swift
//  DealiDesignSystemSampleApp
//
//  Created by 이남준 on 2023/05/18.
//

import UIKit
import RxSwift
import RxCocoa
import DealiDesignKit

/**
 설명: 폰트 관련
 */
final class TypographyViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = .init()
        
        self.title = "Typography"
        self.view.backgroundColor = DealiColor.primary04
        
        let scrollView = UIScrollView()
        
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
        
        let stackView = UIStackView()
        scrollView.addSubview(stackView)
        stackView.then {
            $0.axis = .vertical
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let h1sb32 = TypoView(fontName: "h1sb32", font: .h1sb32, text: "₩ 30,000")
        stackView.addArrangedSubview(h1sb32)
    
    }

}

final class TypoView: UIView {
    
    var fontName: String?
    var font: UIFont?
    var text: String?
    
    private let titleLabel = UILabel()
    private let textLabel = UILabel()
    
    convenience init(fontName: String?,
         font: UIFont?,
         text: String?) {
        self.init(frame: .zero)
        
        self.titleLabel.text = fontName
        self.textLabel.text = text
        self.textLabel.font = font
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(titleLabel)
        titleLabel.then {
            $0.font = .h1sb32
            $0.text = self.fontName
            $0.textColor = DealiColor.g100
            $0.backgroundColor = DealiColor.secondary03
        }.snp.makeConstraints {
            $0.top.left.equalToSuperview().inset(20.0)
        }
        
        self.addSubview(textLabel)
        textLabel.then {
            $0.font =  self.font
            $0.text = self.text
            $0.textColor = DealiColor.g100
        }.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10.0)
            $0.bottom.left.equalToSuperview().inset(20.0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
