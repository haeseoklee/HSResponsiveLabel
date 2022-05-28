//
//  ElementKind.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import UIKit

public typealias ResponsiveElementKindIdentifier = String

public typealias ElementDidTapHandlerType = (ResponsiveElement) -> Void

public typealias ElementConfigureHandlerType = (ResponsiveElement, [NSAttributedString.Key : Any]) -> ElementConfigureHandlerResultType

public typealias ElementConfigureHandlerResultType = (canHook: Bool, newAttributes: [NSAttributedString.Key : Any])

// MARK: - ResponsiveElementKindType

public protocol ResponsiveElementKindType {
    
    var textColor: UIColor? { get set }
    
    var selectedTextColor: UIColor? { get set }

    var textAttributes: [NSAttributedString.Key: Any] { get set }

    var selectedTextAttributes: [NSAttributedString.Key: Any] { get set }
    
    var regexPattern: String { get set }
    
    var didTapHandler: ElementDidTapHandlerType? { get set }
    
    var configureHandler: ElementConfigureHandlerType? { get set }
}

// MARK: - ResponsiveElementKindIdentifiableType

public protocol ResponsiveElementKindIdentifiableType: Identifiable, Hashable, ResponsiveElementKindType {}

// MARK: - ElementKind

open class ElementKind: ResponsiveElementKindIdentifiableType {
    
    // MARK: Properties

    open var id: ResponsiveElementKindIdentifier
    
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

    open var regexPattern: String
    
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
