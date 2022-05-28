//
//  HSResponsiveLabel.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import UIKit

open class HSResponsiveLabel: UILabel {
    
    // MARK: Override Properties
    
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
    
    open override var numberOfLines: Int {
        didSet {
            textContainer.maximumNumberOfLines = numberOfLines
        }
    }
    
    open override var lineBreakMode: NSLineBreakMode {
        didSet {
            textContainer.lineBreakMode = lineBreakMode
        }
    }
    
    // MARK: Properties
    
    open lazy var kinds: [ElementKind] = [] {
        didSet {
            elementManager.update(kinds: kinds)
            update()
        }
    }
    
    private let elementManager: ResponsiveElementManager = ResponsiveElementManager()
    
    private let textStorage: NSTextStorage = NSTextStorage()
    
    private let layoutManager: NSLayoutManager = NSLayoutManager()
    
    private let textContainer: NSTextContainer = NSTextContainer()

    private var heightCorrection: CGFloat = 0
    
    // MARK: Override Methods
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    open override var intrinsicContentSize: CGSize {
        guard let text = text, !text.isEmpty else { return .zero }
        textContainer.size = CGSize(width: self.preferredMaxLayoutWidth, height: CGFloat.greatestFiniteMagnitude)
        let size = layoutManager.usedRect(for: textContainer)
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }

    open override func drawText(in rect: CGRect) {
        let range = NSRange(location: 0, length: textStorage.length)
        let newOrigin = findNewOrigin(in: rect)
        textContainer.size = rect.size
        layoutManager.drawBackground(forGlyphRange: range, at: newOrigin)
        layoutManager.drawGlyphs(forGlyphRange: range, at: newOrigin)
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if handle(touch: touches.first) { return }
        super.touchesBegan(touches, with: event)
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if handle(touch: touches.first) { return }
        super.touchesMoved(touches, with: event)
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        _ = handle(touch: touches.first)
        super.touchesCancelled(touches, with: event)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if handle(touch: touches.first) { return }
        super.touchesEnded(touches, with: event)
    }
}

// MARK: - Private Methods

private extension HSResponsiveLabel {

    func setup() {
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = lineBreakMode
        textContainer.maximumNumberOfLines = numberOfLines
        isUserInteractionEnabled = true
    }
    
    func update() {
        guard let attributedText = attributedText else { return }
        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
        
        updateAttributes(mutAttrString: mutableAttributedText)
        elementManager.fetchElements(from: mutableAttributedText)
        elementManager.updateElementsAttributes(to: mutableAttributedText)
        
        textStorage.setAttributedString(mutableAttributedText)
        setNeedsDisplay()
    }

    func updateAttributes(mutAttrString: NSMutableAttributedString) {
        var (range, attributes) = mutAttrString.fetchAttributesAndEffectiveRange()
        
        let paragraphStyle = attributes[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle ?? NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.alignment = textAlignment
        
        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle

        mutAttrString.addAttributes(attributes, range: range)
    }

    func findNewOrigin(in rect: CGRect) -> CGPoint {
        let usedRect = layoutManager.usedRect(for: textContainer)
        heightCorrection = (rect.height - usedRect.height) / 2
        let glyphOriginY = heightCorrection > 0 ? rect.origin.y + heightCorrection : rect.origin.y
        return CGPoint(x: rect.origin.x, y: glyphOriginY)
    }
    
    func findTextIndex(at point: CGPoint) -> Int? {
        guard textStorage.length > 0 else { return nil }
        var correctLocation = point
        correctLocation.y -= heightCorrection
        let boundingRect = layoutManager.boundingRect(
            forGlyphRange: NSRange(location: 0, length: textStorage.length), in: textContainer
        )
        guard boundingRect.contains(correctLocation) else { return nil }
        let index = layoutManager.glyphIndex(for: correctLocation, in: textContainer)
        return index
    }
    
    func handle(touch: UITouch?) -> Bool {
        var canHandleTouchEvent = false
        guard let touch = touch else { return canHandleTouchEvent }
        
        switch touch.phase {
        case .began, .moved, .regionEntered, .regionMoved:
            let point = touch.location(in: self)
            canHandleTouchEvent = handleWhenRecognized(point: point)
            return canHandleTouchEvent
        
        case .ended, .regionExited, .cancelled:
            canHandleTouchEvent = handleWhenDerecognized()
            return canHandleTouchEvent
            
        default:
            break
        }
        
        return canHandleTouchEvent
    }
    
    func handleWhenRecognized(point: CGPoint) -> Bool {
        var canHandleTouchEvent = false
        guard let index = findTextIndex(at: point),
              let element = elementManager.findElement(by: index),
              !elementManager.checkIsCurrentSelectedElement(element),
              element.isUserInteractionEnabeld else {
            return canHandleTouchEvent
        }
        elementManager.update(currentSelectedElement: element)
        elementManager.updateElementAttributesWhenSelected(element: element, to: textStorage)
        setNeedsDisplay()
        canHandleTouchEvent = true
        return canHandleTouchEvent
    }
    
    func handleWhenDerecognized() -> Bool {
        var canHandleTouchEvent = false
        guard let element = elementManager.currentSelectedElement else {
            return canHandleTouchEvent
        }
        elementManager.handleTouchEvent(element)
        elementManager.updateElementAttributes(element: element, to: textStorage)
        elementManager.updateElementAttributes(element: element, highlightedTextColor: highlightedTextColor, from: textStorage)
        elementManager.update(currentSelectedElement: nil)
        setNeedsDisplay()
        canHandleTouchEvent = true
        return canHandleTouchEvent
    }}


// MARK: - UIGestureRecognizerDelegate

extension HSResponsiveLabel: UIGestureRecognizerDelegate {

    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }
    
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }
    
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }
}
