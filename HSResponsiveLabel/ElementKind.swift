//
//  ElementKind.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import UIKit

open class ElementKind: ResponsiveElementKindIdentifiableType {
    
    // MARK: Properties

    public let id: ResponsiveElementKindIdentifier
    
    open var textColor: UIColor? = .blue {
        didSet {
            textAttributes[NSAttributedString.Key.foregroundColor] = textColor
        }
    }
    
    open var selectedTextColor: UIColor? = .blue {
        didSet {
            selectedTextAttributes[NSAttributedString.Key.foregroundColor] = selectedTextColor
        }
    }

    open var textAttributes: [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.foregroundColor: UIColor.blue
    ]

    open var selectedTextAttributes: [NSAttributedString.Key : Any] = [
        NSAttributedString.Key.foregroundColor: UIColor.blue
    ]

    public let regexPattern: String
    
    open var didTapHandler: ((ResponsiveElement) -> Void)?
    
    open var configureHandler: ElementConfigureHandlerType?
    
    // MARK: Methods
    
    public init(
        id: String,
        regexPattern: String,
        didTapHandler: ((ResponsiveElement) -> Void)? = nil
    ) {
        self.id = id
        self.regexPattern = regexPattern
        self.didTapHandler = didTapHandler
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: ElementKind, rhs: ElementKind) -> Bool {
        return lhs.id == rhs.id
    }
}
