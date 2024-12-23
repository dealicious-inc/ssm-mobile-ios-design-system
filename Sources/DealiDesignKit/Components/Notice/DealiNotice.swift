//
//  DealiNotice.swift
//  DealiDesignKit
//
//  Created by JohyeonYoon on 12/23/24.
//

import UIKit
//**TODO: @윤조현 창호님 작업 머지 후 변경
public class LabeledText: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let label = UILabel()
        self.addSubview(label)
        label.then {
            $0.numberOfLines = 0
            $0.attributedText = NSMutableAttributedString(string: "내용 가나다라마바사아자차카타파하가나다라마바사아자차카타파하")
                .font(.b3r13)
                .color(.g80)
                .setLineHeight()
        }.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public final class DealiNotice: UIView {

    public func setTextLinkButton(_ textLink: TextLink) {
        self.textLinkButton = textLink
        
        self.addSubview(textLink)
        textLink.snp.makeConstraints {
            $0.left.greaterThanOrEqualTo(self.titleLabel.snp.right).offset(16.0)
            $0.centerY.equalTo(self.titleLabel)
            $0.left.right.equalToSuperview().inset(16.0)
        }
    }
    
    public var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    private let titleLabel = UILabel()
    private var textLinkButton: TextLink?
    private let contentView = UIView()
    
    override internal init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addContents(_ view: UIView) {
        self.contentView.addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    public func addLabeledTexts(_ labeledTextArray: [LabeledText]) {
        let stackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 8.0
            $0.isLayoutMarginsRelativeArrangement = true
            $0.layoutMargins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        }
        
        for labeledText in labeledTextArray {
            stackView.addArrangedSubview(labeledText)
        }
        
        self.addContents(stackView)
    }
}

private extension DealiNotice {
    func setUI() {
        
        self.backgroundColor = .g10
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
        
        let titleView = self.titleView()
        self.addSubview(titleView)
        titleView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(16.0)
        }
        
        let dividerView = UIView()
        self.addSubview(dividerView)
        dividerView.then {
            $0.backgroundColor = .g30
        }.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.left.right.equalToSuperview().inset(16.0)
            $0.top.equalTo(titleView.snp.bottom).offset(16.0)
        }
        
        self.addSubview(self.contentView)
        self.contentView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func titleView() -> UIView {
        let titleContentView = UIView()
        
        let iconImageView = UIImageView()
        titleContentView.addSubview(iconImageView)
        iconImageView.then {
            $0.image = UIImage.dealiIcon(named: "ic_notice")
        }.snp.makeConstraints {
            $0.left.centerY.equalToSuperview()
            $0.size.equalTo(16.0)
        }
        
        titleContentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.left.equalTo(iconImageView.snp.right).offset(8.0)
        }
        
        return titleContentView
    }
    
    
}
