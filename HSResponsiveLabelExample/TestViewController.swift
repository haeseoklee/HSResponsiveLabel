//
//  TestViewController.swift
//  HSResponsiveLabelExample
//
//  Created by Louie Lee on 2022/06/02.
//

import UIKit
import HSResponsiveLabel

class TestViewController: UIViewController {

    lazy var responsiveLabel: HSResponsiveLabel = {
        let label = HSResponsiveLabel()



        let customKind = ElementKind(id: "my.custom.kind", regexPattern: "#FoundationTF") { element in
            self.alert(element.string, message: element.string)
        }
        customKind.textColor = .red
        customKind.selectedTextColor = .purple


        let customKind2 = ElementKind(id: "my.custom.kind2", regexPattern: "ationTF 회식")
        customKind2.textAttributes = [NSAttributedString.Key.backgroundColor: UIColor.yellow]

        customKind2.configurationHandler = {element, attributes in
            if element.string == "ationTF 회식" {
                element.isUserInteractionEnabeld = false
                return (true, attributes)
            }
            return (false, attributes)
        }


        label.kinds = [customKind, customKind2]
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        responsiveLabel.text =
                """
                도시속밀림 반포 한강공원 세빛섬에서 한강 요트 투어를 즐길 수 있습니다.
                골든블루마리나의 레인보우브릿지 한강 요트 대여로 요트 투어를 즐겨보세요!
                6/23은 #FoundationTF 회식이 있어서 제외했습니다.
                결정: 이번주 Weekly 시간에.
                1번이 한강 크루즈 + 뷔페인거죠? ㅎ
                스총무 어떻게 되나요?
                크루즈를 가겠군요
                Dewey의 열렬한 반응으로 크루즈 + 선상뷔페 에서 식사후 + 요트 코스로 변경하겠습니다.
                """

        view.addSubview(responsiveLabel)
        NSLayoutConstraint.activate([
            responsiveLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            responsiveLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            responsiveLabel.widthAnchor.constraint(equalTo: view.widthAnchor),
            responsiveLabel.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        // Do any additional setup after loading the view.
    }


    func alert(_ title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        vc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(vc, animated: true, completion: nil)
    }
}
