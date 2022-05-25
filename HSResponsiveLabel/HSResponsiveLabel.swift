//
//  HSResponsiveLabel.swift
//  HSResponsiveLabel
//
//  Created by Haeseok Lee on 2022/05/25.
//

import Foundation
import UIKit

open class HSResponsiveLabel: UILabel {
    
    open var kinds: [ElementKind] = []
    
    private var identifiableKinds: Set<ElementKind> {
        Set<ElementKind>(kinds)
    }
    
    private var textStorage: NSTextStorage = NSTextStorage()
    
    private var layoutManager: NSLayoutManager = NSLayoutManager()
    
    private var textContainer: NSTextContainer = NSTextContainer()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        textStorage.addLayoutManager(layoutManager)
        layoutManager.addTextContainer(textContainer)
    }
}
