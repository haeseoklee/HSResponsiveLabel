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
    
    private var _textAttributes: [NSAttributedString.Key: Any] = [:]

    open var textAttributes: [NSAttributedString.Key: Any] {
        get {
            if let textColor = textColor {
                _textAttributes[NSAttributedString.Key.foregroundColor] = textColor
            }
            return _textAttributes
        }
        set {
            _textAttributes = newValue
        }
    }
    
    private var _selectedTextAttributes: [NSAttributedString.Key: Any] = [:]

    open var selectedTextAttributes: [NSAttributedString.Key: Any] {
        get {
            if let selectedTextColor = selectedTextColor {
                _selectedTextAttributes[NSAttributedString.Key.foregroundColor] = selectedTextColor
            }
            return _selectedTextAttributes
        }
        set {
            _selectedTextAttributes = newValue
        }
    }
    
    public let regexPattern: String

    public let priority: ResponsiveElementPriority
    
    open var didTapHandler: ((ResponsiveElement) -> Void)?
    
    open var configurationHandler: ElementConfigureHandlerType?
    
    // MARK: Methods
    
    public init(
        id: String,
        regexPattern: String,
        priority: ResponsiveElementPriority = .required,
        didTapHandler: ((ResponsiveElement) -> Void)? = nil
    ) {
        self.id = id
        self.regexPattern = regexPattern
        self.priority = priority
        self.didTapHandler = didTapHandler
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: ElementKind, rhs: ElementKind) -> Bool {
        return lhs.id == rhs.id
    }
}
