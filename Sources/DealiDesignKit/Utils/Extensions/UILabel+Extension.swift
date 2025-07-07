//
//  UILabel+Extension.swift
//
//
//  Created by 윤조현 on 2023/04/12.
//

import UIKit

public extension UILabel {
    var dealiText: String? {
        get {
            return self.text
        }
        set(newValue) {
            
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = self.font.dealiLineHeight ?? self.font.lineHeight
            style.minimumLineHeight = self.font.dealiLineHeight ?? self.font.lineHeight
            style.alignment = self.textAlignment
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style,
                .baselineOffset: ((self.font.dealiLineHeight ?? self.font.lineHeight) - self.font.lineHeight) / 4,
            ]
            
            let attrString = NSAttributedString(string: newValue ?? "",
                                                attributes: attributes)
            self.text = newValue
            self.attributedText = attrString
        }
    }
    
    /// UILabel 내 특정 위치(point)의 링크 텍스트 추출
    /** 사용 예시
     label.rx.tapGesture().when(.recognized)
         .bind(onNext: { gesture in
             let location = gesture.location(in: label)
             if let link = label.tappedLinkText(at: location) {
                 print("Tapped link: \(link)")
             }
         })
         .disposed(by: disposeBag)
     */
    func tappedLinkText(at point: CGPoint, linkKey: NSAttributedString.Key = NSAttributedString.Key(TEXT_LINK)) -> String? {
        guard let attributedText = self.attributedText, let index = self.textIndex(at: point) else {
            return nil
        }
        return attributedText.linkText(at: index, linkKey: linkKey)
    }
    
    /// 입력된 포지션에 따라 라벨의 문자열의 인덱스 반환
    /// - Parameter point: 인덱스 값을 알고 싶은 CGPoint
    func textIndex(at point: CGPoint) -> Int? {
        guard let attributedText = self.attributedText, !attributedText.string.isEmpty else {
            return nil
        }
        
        // 1. 텍스트 저장소
        let textStorage = NSTextStorage(attributedString: attributedText)
        
        // 2. 레이아웃 매니저
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        
        // 3. 텍스트 컨테이너 설정
        let textContainer = NSTextContainer(size: self.bounds.size)
        textContainer.lineFragmentPadding = 0.0
        textContainer.maximumNumberOfLines = self.numberOfLines
        textContainer.lineBreakMode = self.lineBreakMode
        layoutManager.addTextContainer(textContainer)
        
        // 4. 실제 텍스트가 그려지는 영역 계산
        let glyphRange = layoutManager.glyphRange(for: textContainer)
        let boundingRect = layoutManager.boundingRect(forGlyphRange: glyphRange, in: textContainer)
        
        // 5. 터치 지점이 텍스트 영역 안에 있는지 확인
        guard boundingRect.contains(point) else {
            return nil
        }
        
        // 6. 해당 지점의 인덱스 반환
        return layoutManager.glyphIndex(for: point, in: textContainer)
    }
}
