//
//  ResponsiveElement.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import Foundation

public class ResponsiveElement: Identifiable {
    
    public let id: ResponsiveElementKindIdentifier
    
    public let range: NSRange
    
    public let string: String
    
    public var isUserInteractionEnabled: Bool
    
    public init(
        id: ResponsiveElementKindIdentifier,
        range: NSRange,
        string: String,
        isUserInteractionEnabled: Bool = true
    ) {
        self.id = id
        self.range = range
        self.string = string
        self.isUserInteractionEnabled = isUserInteractionEnabled
    }
}
