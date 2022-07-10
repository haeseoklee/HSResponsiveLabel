//
//  HashtagElementKind.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/07/09.
//

import UIKit

open class HashtagElementKind: ElementKind {
    
    private let regexBuilder: RegexBuilderType = HashtagRegexBuilder()
    
    public init(
        id: String,
        priority: ResponsiveElementPriority = .required,
        isUserInteractionEnabled: Bool = true,
        didTapHandler: DidTapElementHandlerType? = nil
    ) {
        super.init(
            id: id,
            regexPattern: regexBuilder.makeRegexPattern(),
            priority: priority,
            isUserInteractionEnabled: isUserInteractionEnabled,
            didTapHandler: didTapHandler
        )
    }
}
