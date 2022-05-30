//
//  ResponsiveElementKindType.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/29.
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
    
    var regexPattern: String { get }
    
    var didTapHandler: ElementDidTapHandlerType? { get set }
    
    var configureHandler: ElementConfigureHandlerType? { get set }
}

// MARK: - ResponsiveElementKindIdentifiableType

public protocol ResponsiveElementKindIdentifiableType: Identifiable, Hashable, ResponsiveElementKindType {}