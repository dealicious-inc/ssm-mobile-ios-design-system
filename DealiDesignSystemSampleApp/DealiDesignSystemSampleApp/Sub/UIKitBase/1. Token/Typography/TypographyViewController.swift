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
import SwiftUI

/**
 설명: 폰트 관련
 */
final class TypographyViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private let textInput = DealiTextInput()
    private let stackView = UIStackView()
    
    var text: String? {
        didSet {
            
        }
    }
    
    private var isSwiftUI: Bool
    
    init(isSwiftUI: Bool = false) {
        self.isSwiftUI = isSwiftUI
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var typoViewList = [
        TypoView(fontName: "h1sb32", font: .h1sb32),
        TypoView(fontName: "h2sb24", font: .h2sb24),
        
        TypoView(fontName: "sh1sb20", font: .sh1sb20),
        TypoView(fontName: "sh1r20", font: .sh1r20),
        
        TypoView(fontName: "sh2sb18", font: .sh2sb18),
        TypoView(fontName: "sh2r18", font: .sh2r18),
        
        TypoView(fontName: "sh3sb16", font: .sh3sb16),
        TypoView(fontName: "sh3r16", font: .sh3r16),
        
        TypoView(fontName: "sh3sb16", font: .sh3sb16),
        TypoView(fontName: "sh3r16", font: .sh3r16),
        
        TypoView(fontName: "b1sb15", font: .b1sb15),
        TypoView(fontName: "b1r15", font: .b1r15),
        
        TypoView(fontName: "b2sb14", font: .b2sb14),
        TypoView(fontName: "b2r14", font: .b2r14),
        
        TypoView(fontName: "b3sb13", font: .b3sb13),
        TypoView(fontName: "b3r13", font: .b3r13),
        
        TypoView(fontName: "b4sb12", font: .b4sb12),
        TypoView(fontName: "b4r12", font: .b4r12),
        
        TypoView(fontName: "c1sb10", font: .c1sb10),
        TypoView(fontName: "c1r10", font: .c1r10)
    ]
    
    override func loadView() {
        self.view = .init()
        
        self.title = "Typography"
        self.view.backgroundColor = .primary04
        
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
        
        contentView.addSubview(self.textInput)
        self.textInput.then {
            $0.isHidden = isSwiftUI
            $0.placeholder = "테스트할 문자열 입력"
            $0.keyboardCloseButtonString = "닫기"
        }.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(20.0)
        }
        
        contentView.addSubview(stackView)
        stackView.then {
            $0.axis = .vertical
            $0.spacing = 8.0
        }.snp.makeConstraints {
            $0.top.equalTo(self.textInput.snp.bottom).offset(20.0)
            $0.left.right.bottom.equalToSuperview()
        }
        
        if isSwiftUI {
            setSwiftUI()
        } else {
            setUIKit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textInput.rx.textEditingControlProperty
            .skip(1)
            .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                
                var showingText: String {
                    if let text, text.isEmpty == false {
                        return text
                    } else {
                        return  "…‘Beauty is in the eye of the beholder.’ 사랑하는 사람은 뭐든지 다 예뻐 보인다는 말인데, 마케팅에서 성공한 디자인은 다 예뻐 보이는 법이지요. —폴 랜드(Paul Rand)"
                    }
                }
                
                owner.typoViewList.forEach { typoView in
                    typoView.text = showingText
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    func setSwiftUI() {
        self.typoViewList.forEach { typoView in
            let font = typoView.font.swiftUIFont
            let attStr = AttributedString("…‘Beauty is in the eye of the beholder.’ 사랑하는 사람은 뭐든지 다 예뻐 보인다는 말인데, 마케팅에서 성공한 디자인은 다 예뻐 보이는 법이지요. —폴 랜드(Paul Rand)".byCharWrapping)
                .setFont(font)
                .setColor(.g100)
            
            let titleLabel = AttributedText(
                AttributedString("\(typoView.fontName ?? "") 333333")
                    .setFont(font)
                    .setColor(.g100))
                .background(Color.secondary03)
                .padding(.horizontal, 20)
                .UIKit()
            stackView.addArrangedSubview(titleLabel)
            stackView.setCustomSpacing(4, after: titleLabel)
            
            let verticalLine = UIView()
            let horizontalLine = UIView()
            titleLabel.addSubview(horizontalLine)
            horizontalLine.then {
                $0.backgroundColor = .red
            }.snp.makeConstraints {
                $0.centerY.left.right.equalTo(titleLabel)
                $0.height.equalTo(0.5)
            }
            
            titleLabel.addSubview(verticalLine)
            verticalLine.then {
                $0.backgroundColor = .red
            }.snp.makeConstraints {
                $0.centerX.top.bottom.equalTo(titleLabel)
                $0.width.equalTo(0.5)
            }
            
            let lineheightLabel = AttributedText(
                AttributedString("dealiLineHeight: \(font.lineHeight)".byCharWrapping)
                    .setFont(.b2sb14)
                    .setColor(.g100))
                .background(Color.secondary04)
                .padding(.horizontal, 20)
                .UIKit()
            stackView.addArrangedSubview(lineheightLabel)
            stackView.setCustomSpacing(4, after: lineheightLabel)
            
            let textView = AttributedText(attStr)
                .padding(.horizontal, 20)
                .UIKit()
            stackView.addArrangedSubview(textView)
            stackView.setCustomSpacing(20, after: textView)
        }
    }
    
    func setUIKit() {
        self.typoViewList.forEach { typoView in
            stackView.addArrangedSubview(typoView)
        }
    }

}

final class TypoView: UIView {
    
    var fontName: String?
    var font: UIFont
    var text: String {
        didSet {
            self.textLabel.attributedText = NSMutableAttributedString(string: self.text).color(UIColor.g100).font(self.font).setLineHeight()
        }
    }
    
    private let titleLabel = UILabel()
    private let lineHeightLabel = UILabel()
    private let textLabel = UILabel()
    
    init(fontName: String?,
         font: UIFont,
         text: String = "…‘Beauty is in the eye of the beholder.’ 사랑하는 사람은 뭐든지 다 예뻐 보인다는 말인데, 마케팅에서 성공한 디자인은 다 예뻐 보이는 법이지요. —폴 랜드(Paul Rand)"
    ) {
        self.font = font
        self.text = text
        self.fontName = fontName
        
        super.init(frame: .zero)
        
        let verticalLine = UIView()
        let horizontalLine = UIView()
        
        self.addSubview(titleLabel)
        titleLabel.then {
            $0.font = self.font
            $0.textColor = .g100
            $0.attributedText = NSMutableAttributedString(string: "\(self.fontName ?? "") 333333").color($0.textColor).font($0.font).setLineHeight()
            $0.backgroundColor = .secondary03
        }.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(20.0)
        }
        
        self.addSubview(horizontalLine)
        horizontalLine.then {
            $0.backgroundColor = .red
        }.snp.makeConstraints {
            $0.centerY.left.right.equalTo(titleLabel)
            $0.height.equalTo(0.5)
        }
        
        self.addSubview(verticalLine)
        verticalLine.then {
            $0.backgroundColor = .red
        }.snp.makeConstraints {
            $0.centerX.top.bottom.equalTo(titleLabel)
            $0.width.equalTo(0.5)
        }
        
        self.addSubview(self.lineHeightLabel)
        self.lineHeightLabel.then {
            $0.numberOfLines = 0
            $0.backgroundColor = .secondary04
        }.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.left.right.equalToSuperview().inset(20.0)
        }
        
        self.addSubview(textLabel)
        textLabel.then {
            $0.font =  self.font
            $0.textColor = .g100
            $0.numberOfLines = 0
            $0.attributedText = NSMutableAttributedString(string: self.text).color($0.textColor).font($0.font).setLineHeight()
        }.snp.makeConstraints {
            $0.top.equalTo(lineHeightLabel.snp.bottom).offset(10.0)
            $0.bottom.left.right.equalToSuperview().inset(20.0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.lineHeightLabel.attributedText = NSMutableAttributedString(string: "dealiLineHeight: \(self.font.dealiLineHeight) / labelHeight: \(self.titleLabel.frame.height)")
            .color(.g100).font(.b2sb14).setLineHeight()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
