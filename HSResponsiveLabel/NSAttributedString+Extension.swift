//
//  NSAttributedString+Extension.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/28.
//

import UIKit

extension NSAttributedString {
    
    func fetchAttributesAndEffectiveRange() -> (NSRange, [NSAttributedString.Key : Any]) {
        var range = NSRange(location: 0, length: 0)
        let attributes = self.attributes(at: 0, effectiveRange: &range)
        return (range, attributes)
    }
}
