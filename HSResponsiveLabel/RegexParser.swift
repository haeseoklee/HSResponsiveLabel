//
//  RegexParser.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import Foundation

final class RegexParser: RegexParserType {
    
    func parse(from text: String, pattern: String) -> [RegexParserResultType] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        let textCheckingResults = regex.matches(in: text, options: [], range: NSRange(text.startIndex..., in: text))
        let results = textCheckingResults.compactMap { checkingResult -> RegexParserResultType? in
            guard let range = Range(checkingResult.range, in: text) else { return nil }
            let string = String(text[range])
            return (range: checkingResult.range, string: string)
        }
        return results
    }
}
