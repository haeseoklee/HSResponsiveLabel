//
//  URLElementKind.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import UIKit

public protocol URLElementKindIdentfiableType: ResponsiveElementKindIdentifiableType {
    
    var enabledURLList: [String] { get }

    var baseURL: String? { get }

    var scheme: String? { get }
}

open class URLElementKind: ElementKind, URLElementKindIdentfiableType {

    public static let urlRegexPattern: String = "defaultRegexPattern"
    
    open private(set) var enabledURLList: [String] = []

    open private(set) var baseURL: String?

    open private(set) var scheme: String?

    public init(
        id: String,
        didTapHandler: ((ResponsiveElement) -> Void)? = nil
    ) {
        super.init(id: id, regexPattern: URLElementKind.urlRegexPattern, didTapHandler: didTapHandler)
    }

    public init(
        id: String,
        enabledURLList: [String] = [],
        didTapHandler: ((ResponsiveElement) -> Void)? = nil
    ) {
        self.enabledURLList = enabledURLList
        var regexPattern = URLElementKind.urlRegexPattern
        
        // TODO: modify regex pattern when enabledURL is not empty
        if !enabledURLList.isEmpty {
            regexPattern = "newRegexPatternWithEnabledURLList"
        }
        
        super.init(id: id, regexPattern: regexPattern, didTapHandler: didTapHandler)
    }

    public init(
        id: String,
        baseURL: String,
        didTapHandler: ((ResponsiveElement) -> Void)? = nil
    ) {
        self.baseURL = baseURL
        var regexPattern = URLElementKind.urlRegexPattern

        // TODO: modify regex pattern when baseURL is not empty
        if let baseURL = self.baseURL, !baseURL.isEmpty {
            regexPattern = "newRegexPatternWithEnabledURLList"
        }

        super.init(id: id, regexPattern: regexPattern, didTapHandler: didTapHandler)
    }

}
