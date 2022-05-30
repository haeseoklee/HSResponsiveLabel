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
        #"[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)"#
    }
    
    func makeRegexPattern(enabledURLs: [URL?]) -> String {
        #"(\#(enabledURLs.compactMap({ $0?.absoluteString }).joined(separator: "|")))"#
    }
    
    func makeRegexPattern(enabledBaseURLs: [URL?]) -> String {
        #"(\#(enabledBaseURLs.compactMap({ $0?.absoluteString }).joined(separator: "|")))\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)"#
    }
    
    func makeRegexPattern(enabledSchemes: [String]) -> String {
        #"(\#(enabledSchemes.joined(separator: "|"))):\/\/[(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)"#
    }
}
