//
//  HSResponsiveLabel.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import UIKit

open class HSResponsiveLabel: UILabel {
    
    // MARK: Properties
    
    open override var text: String? {
        didSet {
            update()
        }
    }
    
    open override var font: UIFont! {
        didSet {
            update()
        }
    }
    
    open override var textColor: UIColor! {
        didSet {
            update()
        }
    }
    
    open override var shadowColor: UIColor? {
        didSet {
            update()
        }
    }
    
    open override var shadowOffset: CGSize {
        didSet {
            update()
        }
    }
    
    open override var textAlignment: NSTextAlignment {
        didSet {
            update()
        }
    }
    
    open override var lineBreakMode: NSLineBreakMode {
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
    
    open var lineSpacing: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
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

    private var heightForCenterYAlignment: CGFloat = 0
    
    private var isBatchUpdating: Bool = false
    
    // MARK: Methods
    
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
        updateTextContainer(size: CGSize(width: preferredMaxLayoutWidth, height: CGFloat.greatestFiniteMagnitude))
        let size = layoutManager.usedRect(for: textContainer)
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }

    open override func drawText(in rect: CGRect) {
        updateTextContainer(size: rect.size)
        let range = NSRange(location: 0, length: textStorage.length)
        let newOrigin = findNewOrigin(in: rect)
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
        handle(touch: touches.first)
        super.touchesCancelled(touches, with: event)
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if handle(touch: touches.first) { return }
        super.touchesEnded(touches, with: event)
    }
    
    open func batchUpdate(configuration: ((HSResponsiveLabel) -> Void)?) {
        guard !isBatchUpdating else { return }
        isBatchUpdating = true
        configuration?(self)
        isBatchUpdating = false
        update()
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
        guard !isBatchUpdating, let attributedText = attributedText else { return }
        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
        updateAttributes(mutAttrString: mutableAttributedText)
        elementManager.fetchElements(from: mutableAttributedText)
        elementManager.updateElementsAttributes(to: mutableAttributedText)
        textStorage.setAttributedString(mutableAttributedText)
        setNeedsDisplay()
    }

    func updateTextContainer(size: CGSize) {
        textContainer.size = size
    }

    func updateAttributes(mutAttrString: NSMutableAttributedString) {
        var (range, attributes) = mutAttrString.fetchAttributesAndEffectiveRange()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        paragraphStyle.alignment = textAlignment
        paragraphStyle.lineSpacing = lineSpacing
        attributes[NSAttributedString.Key.font] = font
        attributes[NSAttributedString.Key.foregroundColor] = textColor
        attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        mutAttrString.addAttributes(attributes, range: range)
    }

    func findNewOrigin(in rect: CGRect) -> CGPoint {
        let usedRect = layoutManager.usedRect(for: textContainer)
        heightForCenterYAlignment = (rect.height - usedRect.height) / 2
        let glyphOriginY = heightForCenterYAlignment > 0 ? rect.origin.y + heightForCenterYAlignment : rect.origin.y
        return CGPoint(x: rect.origin.x, y: glyphOriginY)
    }
    
    func findTextIndex(at point: CGPoint) -> Int? {
        guard textStorage.length > 0 else { return nil }
        var correctLocation = point
        correctLocation.y -= heightForCenterYAlignment
        let boundingRect = layoutManager.boundingRect(
            forGlyphRange: NSRange(location: 0, length: textStorage.length), in: textContainer
        )
        guard boundingRect.contains(correctLocation) else { return nil }
        let index = layoutManager.glyphIndex(for: correctLocation, in: textContainer)
        return index
    }
    
    @discardableResult
    func handle(touch: UITouch?) -> Bool {
        var canHandleTouchEvent = false
        guard let touch = touch else { return canHandleTouchEvent }
        switch touch.phase {
        case .began, .regionEntered, .regionMoved:
            let point = touch.location(in: self)
            canHandleTouchEvent = handleWhenRecognized(point: point)
            setNeedsDisplay()
            return canHandleTouchEvent
        
        case .ended, .regionExited:
            canHandleTouchEvent = handleWhenDerecognized(isSuccess: true)
            setNeedsDisplay()
            return canHandleTouchEvent

        case .cancelled:
            canHandleTouchEvent = handleWhenDerecognized(isSuccess: false)
            setNeedsDisplay()
            return canHandleTouchEvent

        default:
            break
        }
        
        return canHandleTouchEvent
    }
    
    func handleWhenRecognized(point: CGPoint) -> Bool {
        var canHandleTouchEvent = false
        guard let index = findTextIndex(at: point),
              let element = elementManager.findHighestPriorityElement(by: index),
              let kind = elementManager.findKind(by: element),
              !elementManager.checkIsCurrentSelectedElement(element),
              kind.isUserInteractionEnabled,
              element.isUserInteractionEnabled else {
            return canHandleTouchEvent
        }
        elementManager.update(currentSelectedElement: element)
        elementManager.updateElementAttributesWhenSelected(element: element, to: textStorage)
        canHandleTouchEvent = true
        return canHandleTouchEvent
    }
    
    func handleWhenDerecognized(isSuccess: Bool) -> Bool {
        var canHandleTouchEvent = false
        guard let element = elementManager.currentSelectedElement else {
            return canHandleTouchEvent
        }
        isSuccess ? elementManager.handleTouchEvent(element) : ()
        elementManager.updateElementAttributes(element: element, to: textStorage)
        elementManager.updateElementAttributes(element: element, highlightedTextColor: highlightedTextColor, from: textStorage)
        elementManager.update(currentSelectedElement: nil)
        canHandleTouchEvent = true
        return canHandleTouchEvent
    }
}


// MARK: - UIGestureRecognizerDelegate

extension HSResponsiveLabel: UIGestureRecognizerDelegate {

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
