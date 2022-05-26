//
//  HSResponsiveLabel.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import Foundation
import UIKit

open class HSResponsiveLabel: UILabel {
    
    open lazy var kinds: [ElementKind] = [] {
        willSet {
            elementManager.update(kinds: newValue)
        }
    }

    open override var text: String? {
        didSet {
            update()
        }
    }

    open override var attributedText: NSAttributedString? {
        didSet {
            update()
        }
    }

    private var mutableAttributedText: NSMutableAttributedString?

    private let elementManager: ResponsiveElementManager = ResponsiveElementManager()
    
    private let textStorage: NSTextStorage = NSTextStorage()
    
    private let layoutManager: NSLayoutManager = NSLayoutManager()
    
    private let textContainer: NSTextContainer = NSTextContainer()

    private var heightCorrection: CGFloat = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    open override func drawText(in rect: CGRect) {
        let range = NSRange(location: 0, length: textStorage.length)

        textContainer.size = rect.size
        let newOrigin = textOrigin(inRect: rect)

        layoutManager.drawBackground(forGlyphRange: range, at: newOrigin)
        layoutManager.drawGlyphs(forGlyphRange: range, at: newOrigin)
    }
    

}

private extension HSResponsiveLabel {

    func setup() {
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
        textContainer.lineBreakMode = lineBreakMode
        textContainer.maximumNumberOfLines = numberOfLines
        elementManager.responsiveLabel = self
        isUserInteractionEnabled = true
    }

    func update() {
        print(attributedText)

        guard let attributedText = attributedText else {
            return
        }
        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
        self.mutableAttributedText = mutableAttributedText


        // find elements by enabled types
        // parse text and get elements
        elementManager.fetchElements(from: mutableAttributedText)

        elementManager.updateElementsAttributes(from: mutableAttributedText)

        textStorage.setAttributedString(mutableAttributedText)

        // apply attribute to elements
        setNeedsDisplay()
        setNeedsLayout()
    }

    func textOrigin(inRect rect: CGRect) -> CGPoint {
        let usedRect = layoutManager.usedRect(for: textContainer)
        heightCorrection = (rect.height - usedRect.height)/2
        let glyphOriginY = heightCorrection > 0 ? rect.origin.y + heightCorrection : rect.origin.y
        return CGPoint(x: rect.origin.x, y: glyphOriginY)
    }
}
