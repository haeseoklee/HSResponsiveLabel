//
//  ResponsiveElementManager.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import Foundation
import UIKit

class ResponsiveElementManager {
    
    private let regexParser: RegexParser = RegexParser()

    private var kinds: Set<ElementKind> = Set()

    private var elementDict: [ElementKind: [ResponsiveElement]] = [:]

    weak var responsiveLabel: HSResponsiveLabel?

    func update(kinds: [ElementKind]) {
        self.kinds = Set<ElementKind>(kinds)
    }
    
    func fetchElements(from mutAttrString: NSMutableAttributedString) {
        kinds.forEach { kind in
            elementDict[kind] = regexParser.parse(from: mutAttrString, kind: kind)
        }
        print(elementDict)
    }

    func updateElementsAttributes(from mutAttrString: NSMutableAttributedString) {
        var attributes = fetchAttributes(from: mutAttrString)
        kinds.forEach { kind in
            elementDict[kind]?.forEach { element in
                let foregroundColor = kind.textAttributes[NSMutableAttributedString.Key.foregroundColor]
                attributes[NSAttributedString.Key.foregroundColor] = foregroundColor != nil ? foregroundColor : kind.textColor
                mutAttrString.addAttributes(range: element.range)
            }
        }
    }

    func fetchAttributes(from mutAttrString: NSMutableAttributedString) -> [NSAttributedString.Key : Any] {
        var range = NSRange(location: 0, length: 0)
        let attributes = mutAttrString.attributes(at: 0, effectiveRange: &range)
        return attributes
    }
}
