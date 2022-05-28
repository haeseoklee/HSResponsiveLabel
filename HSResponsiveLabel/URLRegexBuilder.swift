//
//  URLRegexBuilder.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/28.
//

import Foundation

protocol URLRegexBuilerType: RegexBuilderType {
    
    func makeRegexPattern(enabledURLs: [URL?]) -> String
    
    func makeRegexPattern(enabledBaseURLs: [URL?]) -> String
    
    func makeRegexPattern(enabledSchemes: [String]) -> String
}

class URLRegexBuilder: URLRegexBuilerType {
    
    func makeRegexPattern() -> String {
        return #"(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})"#
    }
    
    func makeRegexPattern(enabledURLs: [URL?]) -> String {
        #"\#(enabledURLs.compactMap({ $0?.absoluteString }).joined(separator: "|"))"#
    }
    
    func makeRegexPattern(enabledBaseURLs: [URL?]) -> String {
        #"(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})"#
    }
    
    func makeRegexPattern(enabledSchemes: [String]) -> String {
        #"(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})"#
    }
}
