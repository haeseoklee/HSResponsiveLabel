//
//  ResponsiveElementKindType.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/29.
//

import UIKit

public typealias ResponsiveElementKindIdentifier = String

public typealias DidTapElementHandlerType = (ResponsiveElement) -> Void

public typealias ConfigureElementHandlerType = (ResponsiveElement, [NSAttributedString.Key: Any]) -> ConfigureElementHandlerResultType

public typealias ConfigureElementHandlerResultType = (canHook: Bool, newAttributes: [NSAttributedString.Key: Any])

// MARK: - ResponsiveElementKindType

public protocol ResponsiveElementKindType: Identifiable, Hashable {
    
    var textColor: UIColor? { get set }
    
    var selectedTextColor: UIColor? { get set }

    var textAttributes: [NSAttributedString.Key: Any] { get set }

    var selectedTextAttributes: [NSAttributedString.Key: Any] { get set }
    
    var regexPattern: String { get }
    
    var priority: ResponsiveElementPriority { get }
    
    var isUserInteractionEnabled: Bool { get set }
    
    var didTapHandler: DidTapElementHandlerType? { get set }
    
    var configurationHandler: ConfigureElementHandlerType? { get set }
}
