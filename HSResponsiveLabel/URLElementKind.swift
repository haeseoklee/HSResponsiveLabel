//
//  URLElementKind.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import UIKit

public protocol URLElementKindIdentfiableType: ResponsiveElementKindIdentifiableType {
    
    var enabledURLList: [String] { get }
}

open class URLElementKind: ElementKind, URLElementKindIdentfiableType {
    
    public static let defaultURLRegexPattern: String = "defaultRegexPattern"
    
    open private(set) var enabledURLList: [String] = []
    
    public init(
        id: String,
        enabledURLList: [String] = [],
        didTapHandler: ((ResponsiveElement) -> Void)? = nil
    ) {
        self.enabledURLList = enabledURLList
        var regexPattern = URLElementKind.defaultURLRegexPattern
        
        // TODO: modify regex pattern when enabledURL is not empty
        if !enabledURLList.isEmpty {
            regexPattern = "newRegexPatternWithEnabledURLList"
        }
        
        super.init(id: id, regexPattern: regexPattern, didTapHandler: didTapHandler)
    }
    
    public init(id: String, didTapHandler: ((ResponsiveElement) -> Void)? = nil) {
        super.init(id: id, regexPattern: URLElementKind.defaultURLRegexPattern, didTapHandler: didTapHandler)
    }
}
