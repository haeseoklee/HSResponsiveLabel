//
//  RegexParser.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import Foundation

class RegexParser {
    func parse(
        from mutAttrString: NSMutableAttributedString,
        kind: ElementKind
    ) -> [ResponsiveElement] {
        guard let regex = try? NSRegularExpression(pattern: kind.regexPattern, options: []) else {
            return []
        }
        let text = mutAttrString.string
        let checkingResults = regex.matches(in: text, options: [], range: NSRange(text.startIndex..., in: text))
        let responsiveElements = checkingResults.compactMap { checkingResult -> ResponsiveElement? in
            guard let range = Range(checkingResult.range, in: text) else {
                return nil
            }
            let resultString = String(text[range])
            return ResponsiveElement(id: kind.id, range: checkingResult.range, string: resultString)
        }
        return responsiveElements
    }
    
}
