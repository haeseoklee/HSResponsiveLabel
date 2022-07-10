//
//  ElementKind.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import UIKit

open class ElementKind: ResponsiveElementKindType {

    // MARK: Properties

    public let id: ResponsiveElementKindIdentifier
    
    open var textColor: UIColor? = .systemBlue {
        didSet {
            _textAttributes[NSAttributedString.Key.foregroundColor] = textColor
        }
    }
    
    open var selectedTextColor: UIColor? = .systemBlue {
        didSet {
            _selectedTextAttributes[NSAttributedString.Key.foregroundColor] = selectedTextColor
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
    
    open var isUserInteractionEnabled: Bool
    
    open var didTapHandler: DidTapElementHandlerType?
    
    open var configurationHandler: ConfigureElementHandlerType?
    
    // MARK: Methods
    
    public init(
        id: String,
        regexPattern: String,
        priority: ResponsiveElementPriority = .required,
        isUserInteractionEnabled: Bool = true,
        didTapHandler: DidTapElementHandlerType? = nil
    ) {
        self.id = id
        self.regexPattern = regexPattern
        self.priority = priority
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.didTapHandler = didTapHandler
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: ElementKind, rhs: ElementKind) -> Bool {
        return lhs.id == rhs.id
    }
}
