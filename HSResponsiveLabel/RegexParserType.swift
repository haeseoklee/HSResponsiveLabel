//
//  RegexParserType.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/07/09.
//

import Foundation

protocol RegexParserType {
    
    typealias RegexParserResultType = (range: NSRange, string: String)
    
    func parse(from text: String, pattern: String) -> [RegexParserResultType]
}
