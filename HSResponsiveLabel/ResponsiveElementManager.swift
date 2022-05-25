//
//  ResponsiveElementManager.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import Foundation

open class ResponsiveElementManager {
    
    private let regexParser: RegexParser = RegexParser()
    
    private var elements: [ResponsiveElement] = []
    
    func findElements(
        from text: String,
        with kinds: Set<URLElementKind>
    ) {
        elements += kinds.compactMap { regexParser.parse(from: text, with: $0) }
    }
    
    func setAttribute(
        
    ) {
        
    }
    
}
