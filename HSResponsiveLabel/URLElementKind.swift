//
//  URLElementKind.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import UIKit

// MARK: - URLElementKindIdentfiableType

public protocol URLElementKindType: ResponsiveElementKindIdentifiableType {
    
    var enabledURLs: [URL?] { get }

    var enabledBaseURLs: [URL?] { get }

    var enabledSchemes: [String] { get }
}

// MARK: - URLElementKind

open class URLElementKind: ElementKind, URLElementKindType {
    
    // MARK: Properties
    
    open private(set) var enabledURLs: [URL?] = []

    open private(set) var enabledBaseURLs: [URL?] = []

    open private(set) var enabledSchemes: [String] = []
    
    private let regexBuilder: URLRegexBuilerType = URLRegexBuilder()
    
    // MARK: Methods
    
    public init(id: String, didTapHandler: ElementDidTapHandlerType? = nil) {
        super.init(id: id, regexPattern: regexBuilder.makeRegexPattern(), didTapHandler: didTapHandler)
    }

    public init(
        id: String,
        enabledURLs: [URL?],
        didTapHandler: ElementDidTapHandlerType? = nil
    ) {
        self.enabledURLs = enabledURLs
        var regexPattern = regexBuilder.makeRegexPattern()
        if !enabledURLs.isEmpty {
            regexPattern = regexBuilder.makeRegexPattern(enabledURLs: enabledURLs)
        }
        super.init(id: id, regexPattern: regexPattern, didTapHandler: didTapHandler)
    }

    public init(
        id: String,
        enabledBaseURLs: [URL?],
        didTapHandler: ElementDidTapHandlerType? = nil
    ) {
        self.enabledBaseURLs = enabledBaseURLs
        var regexPattern = regexBuilder.makeRegexPattern()
        if !enabledBaseURLs.isEmpty {
            regexPattern = regexBuilder.makeRegexPattern(enabledBaseURLs: enabledBaseURLs)
        }
        super.init(id: id, regexPattern: regexPattern, didTapHandler: didTapHandler)
    }
    
    public init(
        id: String,
        enabledSchemes: [String],
        didTapHandler: ElementDidTapHandlerType? = nil
    ) {
        self.enabledSchemes = enabledSchemes
        var regexPattern = regexBuilder.makeRegexPattern()
        if !enabledSchemes.isEmpty {
            regexPattern = regexBuilder.makeRegexPattern(enabledSchemes: enabledSchemes)
        }
        super.init(id: id, regexPattern: regexPattern, didTapHandler: didTapHandler)
    }
}
