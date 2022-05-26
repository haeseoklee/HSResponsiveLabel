//
//  ElementKind.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import UIKit

public typealias ResponsiveElementKindIdentifier = String

public protocol ResponsiveElementKindType {
    
    var textColor: UIColor? { get set }
    
    var selectedTextColor: UIColor? { get set }

    var textAttributes: [NSAttributedString.Key: Any] { get set }

    var selectedTextAttributes: [NSAttributedString.Key: Any] { get set }
    
    var isEnabled: Bool { get set }
    
    var regexPattern: String { get set }
    
    var didTapHandler: ((ResponsiveElement) -> Void)? { get set }
}

public protocol ResponsiveElementKindIdentifiableType: Identifiable, Hashable, ResponsiveElementKindType {}

open class ElementKind: ResponsiveElementKindIdentifiableType {

    open var id: ResponsiveElementKindIdentifier
    
    open var textColor: UIColor? = .blue
    
    open var selectedTextColor: UIColor? = .blue

    open var textAttributes: [NSAttributedString.Key : Any] = [:]

    open var selectedTextAttributes: [NSAttributedString.Key : Any] = [:]
    
    open var isEnabled: Bool = true

    open var regexPattern: String
    
    open var didTapHandler: ((ResponsiveElement) -> Void)?
    
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
