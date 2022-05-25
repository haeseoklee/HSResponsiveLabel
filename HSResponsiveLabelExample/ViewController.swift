//
//  ViewController.swift
//  HSResponsiveLabelExample
//
//  Created by Haeseok Lee on 2022/05/25.
//

import UIKit
import HSResponsiveLabel

class ViewController: UIViewController {
    
    private lazy var responsiveLabel: HSResponsiveLabel = {
        let label = HSResponsiveLabel()
        
        let myCustomKind = ElementKind(id: "my.custom.kind", regexPattern: "myRegexPattern") { element in
            self.alert("my.custom.kind", message: element.string)
        }
        
        let urlKind = URLElementKind(id: "my.url.kind") { element in
            self.alert("my.url.kind", message: element.string)
        }
        
        let urlKind2 = URLElementKind(id: "my.url.kind2") { element in
            self.alert("my.url.kind2", message: element.string)
        }
        
        label.kinds = [myCustomKind, urlKind, urlKind2]
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func alert(_ title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        vc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(vc, animated: true, completion: nil)
    }
}

