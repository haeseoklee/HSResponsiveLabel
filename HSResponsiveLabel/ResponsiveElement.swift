//
//  ResponsiveElement.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import Foundation

public struct ResponsiveElement: Identifiable {
    
    public var id: ResponsiveElementKindIdentifier
    
    public var range: NSRange
    
    public var string: String
}
