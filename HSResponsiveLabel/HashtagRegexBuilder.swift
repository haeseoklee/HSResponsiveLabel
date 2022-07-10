//
//  HashtagRegexBuilder.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/07/09.
//

import Foundation

protocol HashtagRegexBuilerType: RegexBuilderType {}

class HashtagRegexBuilder: HashtagRegexBuilerType {

    func makeRegexPattern() -> String {
        #"#[^ !@#$%^&*(),.?":{}|<>]*"#
    }
}
