//
//  AttributedText.swift
//  DealiDesignKit
//
//  Created by 이창호 on 3/11/25.
//

import SwiftUI


public struct AttributedText: View {
    @ObservedObject private var viewModel = ViewModel()

    final class ViewModel: ObservableObject {
        @Published var font: UIFont = .h1sb32
        @Published var color: UIColor = .g100
        @Published var text: String?
        @Published var updateTextStyles: [TextStyleAttributes]?
    }
    
    public init(_ text: String) {
        
        registerDealiSystemFonts()
        
        viewModel.text = text
        
//        var error: Unmanaged<CFError>?
//        let _ = CTFontManagerRegisterFontsForURL(Bundle.module.url(forResource: "PretendardJP-Bold", withExtension: "otf")! as CFURL, .process, &error)
//        let _ = CTFontManagerRegisterFontsForURL(Bundle.module.url(forResource: "PretendardJP-Medium", withExtension: "otf")! as CFURL, .process, &error)
//        let _ = CTFontManagerRegisterFontsForURL(Bundle.module.url(forResource: "PretendardJP-Regular", withExtension: "otf")! as CFURL, .process, &error)
//        let _ = CTFontManagerRegisterFontsForURL(Bundle.module.url(forResource: "PretendardJP-SemiBold", withExtension: "otf")! as CFURL, .process, &error)
        
    }
    
    public var body: some View {
        
        if let text = viewModel.text {
            var attributedString = {
                var text = AttributedString(text)
                if let range1 = text.range(of: "안녕") {
                    text[range1].foregroundColor = Color.blue
                    text[range1].font = .b3r13
                }
                if let range2 = text.range(of: "반갑") {
                    text[range2].foregroundColor = Color.red
                    text[range2].font = .b3r13
                }
                return text
            }
            
            Text(attributedString())
                .foregroundStyle(Color(uiColor: viewModel.color))
                .font(viewModel.font)
        }
        
    }
    
    public func font(_ font: UIFont) -> Self {
        viewModel.font = font
        return self
    }
    
    public func color(_ color: UIColor) -> Self {
        viewModel.color = color
        return self
    }
    
//    public func text(_ text: String) -> Self {
//        viewModel.text = text
//        return self
//    }
    
    public func updateTextStyles(_ textStyles: [TextStyleAttributes]) -> Self {
        viewModel.updateTextStyles = textStyles
        return self
    }
}

//#Preview {
//    AttributedText("Hello, World!\n안녕하세요")
//}

struct AttributedText_Previews: PreviewProvider {
    static var previews: some View {
        AttributedText("Hello, World!\n안녕하세요").loadCustomFonts()
    }
}

public extension View {
    
    func font(_ font: UIFont) -> some View {
        let lineHeight = font.dealiLineHeight
        let offset = ((lineHeight - font.lineHeight) / 2.0)
        
        return self
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
            .background(Color(uiColor: .green))
            .padding(.vertical, offset)
            .background(Color(uiColor: .red))
    }
}
