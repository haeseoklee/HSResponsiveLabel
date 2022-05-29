//
//  ResponsiveElementManager.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import UIKit

final class ResponsiveElementManager {
    
    typealias ResponsiveElementDict = [ElementKind: [ResponsiveElement]]
    
    // MARK: Properties
    
    private let regexParser: RegexParserType = RegexParser()

    private var kinds: Set<ElementKind> = Set()

    private var elementDict: ResponsiveElementDict = [:]
    
    private(set) var currentSelectedElement: ResponsiveElement?
}

// MARK: - Methods

extension ResponsiveElementManager {
    
    func fetchElements(from mutAttrString: NSMutableAttributedString) {
        kinds.forEach { kind in
            elementDict[kind] = regexParser
                .parse(from: mutAttrString.string, pattern: kind.regexPattern)
                .map { result in ResponsiveElement(id: kind.id, range: result.range, string: result.string) }
        }
    }
    
    func update(kinds: [ElementKind]) {
        self.kinds = Set<ElementKind>(kinds)
    }
    
    func update(currentSelectedElement: ResponsiveElement?) {
        self.currentSelectedElement = currentSelectedElement
    }

    func updateElementsAttributes(to mutAttrString: NSMutableAttributedString) {
        kinds.forEach { kind in
            elementDict[kind]?.forEach { element in
                mutAttrString.addAttributes(kind.textAttributes, range: element.range)
                _ = updateElementAttributes(element: element, hook: kind.configureHandler, to: mutAttrString)
            }
        }
    }
    
    func updateElementAttributes(element: ResponsiveElement, to textStorage: NSTextStorage) {
        guard let kind = findKind(by: element) else { return }
        let result = updateElementAttributes(element: element, hook: kind.configureHandler, to: textStorage)
        if result.canHook {
            return
        }
        textStorage.addAttributes(kind.textAttributes, range: element.range)
    }
    
    func updateElementAttributesWhenSelected(element: ResponsiveElement, to textStorage: NSTextStorage) {
        guard let kind = findKind(by: element) else { return }
        textStorage.addAttributes(kind.selectedTextAttributes, range: element.range)
    }
    
    func updateElementAttributes(element: ResponsiveElement, highlightedTextColor: UIColor?, from textStorage: NSTextStorage) {
        guard let highlightedTextColor = highlightedTextColor else { return }
        textStorage.addAttributes([NSAttributedString.Key.foregroundColor: highlightedTextColor], range: element.range)
    }
    
    func updateElementAttributes<T: NSMutableAttributedString>(
        element: ResponsiveElement,
        hook: ElementConfigureHandlerType?,
        to mutAttrString: T
    ) -> ElementConfigureHandlerResultType {
        guard let hook = hook else {
            return (canHook: false, newAttributes: [:])
        }
        let attrSubString = mutAttrString.attributedSubstring(from: element.range)
        let (_, attributes) = attrSubString.fetchAttributesAndEffectiveRange()
        let result = hook(element, attributes)
        if result.canHook {
            mutAttrString.addAttributes(result.newAttributes, range: element.range)
        }
        return result
    }
    
    func findElement(by index: Int?) -> ResponsiveElement? {
        guard let index = index else { return nil }
        for kind in kinds where elementDict[kind] != nil {
            for element in elementDict[kind]! {
                let startIndex = element.range.location
                let endIndex = element.range.location + element.range.length
                if index >= startIndex && index <= endIndex {
                    return element
                }
            }
        }
        return nil
    }
    
    func findKind(by element: ResponsiveElement) -> ElementKind? {
        return kinds.filter({ $0.id == element.id }).first
    }
    
    func checkIsCurrentSelectedElement(_ element: ResponsiveElement) -> Bool {
        guard let currentSelectedElement = currentSelectedElement else {
            return false
        }
        let isSameLocation = element.range.location == currentSelectedElement.range.location
        let isSameLength = element.range.length == currentSelectedElement.range.length
        return !isSameLocation && !isSameLength
    }
    
    func handleTouchEvent(_ element: ResponsiveElement) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .microseconds(300)) { [weak self] in
            guard let kind = self?.findKind(by: element), element.isUserInteractionEnabeld else { return }
            kind.didTapHandler?(element)
            self?.currentSelectedElement = nil
        }
    }
}
