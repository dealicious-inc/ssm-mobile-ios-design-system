//
//  NSAttributedString+Extension.swift
//  
//
//  Created by Lee Chang Ho on 8/22/24.
//

import UIKit

public struct TextStyleAttributes {
    var text: String
    var font: UIFont?
    var color: UIColor?
    var underline: Bool
    
    public init(text: String, font: UIFont? = nil, color: UIColor? = nil, underline: Bool = true) {
        self.text = text
        self.font = font
        self.color = color
        self.underline = underline
    }
}

public extension NSMutableAttributedString {
    
    func font(_ font: UIFont) -> NSMutableAttributedString {
        let source = self.string
        let range = (source as NSString).range(of: source)
        self.addAttribute(.font, value: font, range: range)
        return self
    }
    
    func color(_ color: UIColor) -> NSMutableAttributedString {
        let source = self.string
        let range = (source as NSString).range(of: source)
        self.addAttribute(.foregroundColor, value: color, range: range)
        return self
    }
    
    func alignment(_ alignment: NSTextAlignment) -> NSMutableAttributedString {
        let source = self.string
        
        guard source.isEmpty == false else { return self }
        
        let range = (source as NSString).range(of: source)
        var style: NSMutableParagraphStyle?
        if let paragraphStyle = self.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSMutableParagraphStyle {
            style = paragraphStyle
            style?.alignment = alignment
        } else {
            style = NSMutableParagraphStyle()
            style?.alignment = alignment
        }
        
        if let style = style {
            self.addAttribute(.paragraphStyle, value: style, range: range)
        }
        
        return self
    }
    
    func lineSpacing(_ lineSpacing: CGFloat) -> NSMutableAttributedString {
        let source = self.string
        
        guard source.isEmpty == false else { return self }
        
        let range = (source as NSString).range(of: source)
        var style: NSMutableParagraphStyle?
        if let paragraphStyle = self.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSMutableParagraphStyle {
            style = paragraphStyle
            style?.lineSpacing = lineSpacing
        } else {
            style = NSMutableParagraphStyle()
            style?.lineSpacing = lineSpacing
        }
        
        if let style = style {
            self.addAttribute(.paragraphStyle, value: style, range: range)
        }
        return self
    }
    
    func lineHeightMultiple(_ lineHeightMultiple: CGFloat) -> NSMutableAttributedString {
        let source = self.string
        
        guard source.isEmpty == false else { return self }
        
        let range = (source as NSString).range(of: source)
        var style: NSMutableParagraphStyle?
        if let paragraphStyle = self.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSMutableParagraphStyle {
            style = paragraphStyle
            style?.lineHeightMultiple = lineHeightMultiple
        } else {
            style = NSMutableParagraphStyle()
            style?.lineHeightMultiple = lineHeightMultiple
        }
        
        let font: UIFont = self.attribute(.font, at: 0, effectiveRange: nil) as! UIFont
        
        var baselineOffset = ((font.lineHeight * lineHeightMultiple) - font.lineHeight) / 4
        if #available(iOS 16.4, *) {
            baselineOffset = ((font.lineHeight * lineHeightMultiple) - font.lineHeight) / 2
        }
        
        if let style = style {
            self.addAttributes([.paragraphStyle: style, .baselineOffset: baselineOffset], range: range)
        }
        return self
    }

    /// 폰트사이즈에 정의되어 있는 LineHeight값으로 text max LineHeight 값 설정 및 baselineOffset 정의
    /// 반드시 모든 AttString을 합친뒤 가장 마지막에만 적용합니다.
    func setLineHeight() -> NSMutableAttributedString {
        let source = self.string
        guard source.isEmpty == false else { return self }
        
        var maxLineHeight: CGFloat = 0.0
        var firstFont: UIFont?
        
        self.enumerateAttribute(.font, in: NSRange(location: 0, length: self.length), options: []) { value, _, _ in
            if let font = value as? UIFont {
                // 적용된 폰트들을 비교해 maxLineHeight 저장
                maxLineHeight = max(maxLineHeight, font.dealiLineHeight)
                // baseLineOffset을 위해 첫번째 font 확인
                if firstFont == nil { firstFont = font }
            }
        }
        
        guard let font = firstFont else { return self }
        
        let range = (source as NSString).range(of: source)
        var style: NSMutableParagraphStyle?
        if let paragraphStyle = self.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSMutableParagraphStyle {
            style = paragraphStyle
        } else {
            style = NSMutableParagraphStyle()
        }
        
        style?.minimumLineHeight = maxLineHeight
        style?.maximumLineHeight = maxLineHeight
        
        let baselineOffset = ((maxLineHeight - font.lineHeight) / 4) + 1.0
        
        if let style = style {
            self.addAttributes([.paragraphStyle: style, .baselineOffset: baselineOffset], range: range)
        }
        
        return self
    }
    
    func updateAttributes(for textStyle: TextStyleAttributes) -> NSMutableAttributedString {
        let source = self.string
        
        guard source.isEmpty == false, source.contains(textStyle.text) == true else { return self }
        
        let updateRange = (source as NSString).range(of: textStyle.text)
        if let font = textStyle.font {
            self.addAttribute(.font, value: font, range: updateRange)
        }
        if let color = textStyle.color {
            self.addAttribute(.foregroundColor, value: color, range: updateRange)
        }
        return self
    }
    
    /// stringArray와 대응되는 index의 font와 color를 사용합니다.
    func updateMultipleAttributes(for textStyleArray: [TextStyleAttributes]) -> NSMutableAttributedString {
        let source = self.string
        
        guard source.isEmpty == false else { return self }
        
        for (_, textStyle) in textStyleArray.enumerated() {
            if source.contains(textStyle.text) {
                let updateRange = (source as NSString).range(of: textStyle.text)
                if let font = textStyle.font {
                    self.addAttribute(.font, value: font, range: updateRange)
                }
                if let color = textStyle.color {
                    self.addAttribute(.foregroundColor, value: color, range: updateRange)
                }
            }
        }
        return self
    }

    func bullet(_ bullet: String) -> NSMutableAttributedString {
        let source = self.string
        
        guard source.isEmpty == false else { return self }
        
        let range = (source as NSString).range(of: source)
        var style: NSMutableParagraphStyle?
        if let paragraphStyle = self.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSMutableParagraphStyle {
            style = paragraphStyle
            style?.headIndent = (bullet as NSString).size().width
        } else {
            style = NSMutableParagraphStyle()
            style?.headIndent = (bullet as NSString).size().width
        }
        
        if let style = style {
            self.addAttribute(.paragraphStyle, value: style, range: range)
        }
        return self
    }
    
    func underLine(style: NSUnderlineStyle, color: UIColor) -> NSMutableAttributedString {
        let source = self.string
        
        guard source.isEmpty == false else { return self }
        
        let range = (source as NSString).range(of: source)
        self.addAttribute(.underlineStyle, value: style.rawValue, range: range)
        self.addAttribute(.underlineColor, value: color, range: range)
        
        return self
    }
    
    func underline(if condition: Bool, color: UIColor) -> NSMutableAttributedString {
        guard condition else { return self }
        return self.underLine(style: .single, color: color)
    }
    
    func headIndent(_ headIndent: CGFloat) -> NSMutableAttributedString {
        let source = self.string
        
        let range = (source as NSString).range(of: source)
        var style: NSMutableParagraphStyle?
        if let paragraphStyle = self.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSMutableParagraphStyle {
            style = paragraphStyle
            style?.headIndent = headIndent
        } else {
            style = NSMutableParagraphStyle()
            style?.headIndent = headIndent
        }
        
        if let style = style {
            self.addAttribute(.paragraphStyle, value: style, range: range)
        }
        
        return self
    }
    
    func lineBreakMode(_ mode: NSLineBreakMode) -> NSMutableAttributedString {
        let source = self.string
        
        guard source.isEmpty == false else { return self }
        
        let range = (source as NSString).range(of: source)
        var style: NSMutableParagraphStyle?
        if let paragraphStyle = self.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSMutableParagraphStyle {
            style = paragraphStyle
            style?.lineBreakMode = mode
        } else {
            style = NSMutableParagraphStyle()
            style?.lineBreakMode = mode
        }
        
        if let style = style {
            self.addAttribute(.paragraphStyle, value: style, range: range)
        }
        return self
    }
    
    private func htmlString(_ string: String?, fontSize: CGFloat? = nil) -> NSMutableAttributedString? {
        do {
            var htmlString = string
            if let fontSize = fontSize, let string = string {
                htmlString = String(format: "<span style=\"font-size: \(fontSize);\">%@</span>", string)
            }
            guard let htmlString, let data = htmlString.data(using: .utf8) else { return nil }
            return try NSMutableAttributedString(data: data,
                                             options: [.documentType: NSAttributedString.DocumentType.html,
                                                       .characterEncoding: String.Encoding.utf8.rawValue],
                                             documentAttributes: nil)
            
        } catch {
            return nil
        }
    }
    
    func cdataString(fontSize: CGFloat? = nil) -> NSMutableAttributedString? {
        let source = self.string
        let htmlString = string.replacingOccurrences(of: "(<\\!\\[CDATA\\[|\\]\\]>)",
                                                     with: "",
                                                     options: .regularExpression)
            .trimmingCharacters(in: .whitespacesAndNewlines)
        return self.htmlString(htmlString, fontSize: fontSize)
    }
    
    func applyLinkStyle(for linkStyle: TextStyleAttributes) -> NSMutableAttributedString {
        let source = self.string
        guard source.isEmpty == false, source.contains(linkStyle.text) else { return self }
        
        let range = (source as NSString).range(of: linkStyle.text)
        
        // 기존에 적용된 색상 가져오기 (없으면 systemBlue 사용)
        let existingColor = self.attribute(.foregroundColor, at: range.location, effectiveRange: nil) as? UIColor
        let resolvedColor = linkStyle.color ?? existingColor ?? UIColor.g100
        
        if let font = linkStyle.font {
            self.addAttribute(.font, value: font, range: range)
        }
        
        self.addAttribute(.foregroundColor, value: resolvedColor, range: range)
        
        if linkStyle.underline {
            self.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
            self.addAttribute(.underlineColor, value: resolvedColor, range: range)
        }
        
        self.addAttribute(.init(TEXT_LINK), value: linkStyle.text, range: range)
        
        return self
    }
    
    func applyMultipleLinkStyle(for linkStyleArray: [TextStyleAttributes]) -> NSMutableAttributedString {
        
        let source = self.string
        
        guard source.isEmpty == false else { return self }
        
        for (_, linkStyle) in linkStyleArray.enumerated() {
            if source.contains(linkStyle.text) {
                let range = (source as NSString).range(of: linkStyle.text)
                // 기존에 적용된 색상 가져오기 (없으면 systemBlue 사용)
                let existingColor = self.attribute(.foregroundColor, at: range.location, effectiveRange: nil) as? UIColor
                let resolvedColor = linkStyle.color ?? existingColor ?? UIColor.g100
                
                if let font = linkStyle.font {
                    self.addAttribute(.font, value: font, range: range)
                }
                
                self.addAttribute(.foregroundColor, value: resolvedColor, range: range)
                
                if linkStyle.underline {
                    self.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: range)
                    self.addAttribute(.underlineColor, value: linkStyle.color ?? UIColor.systemBlue, range: range)
                }
                
                self.addAttribute(.init(TEXT_LINK), value: linkStyle.text, range: range)
            }
        }
        return self
    }
}

public extension NSAttributedString {
    /// 지정된 인덱스에 해당하는 커스텀 링크 텍스트 반환
    func linkText(at index: Int, linkKey: NSAttributedString.Key = NSAttributedString.Key(TEXT_LINK)) -> String? {
        guard index >= 0 && index < self.length else { return nil }
        let attributes = self.attributes(at: index, effectiveRange: nil)
        if let linkText = attributes[linkKey] as? String {
            return linkText
        }
        return nil
    }
}
