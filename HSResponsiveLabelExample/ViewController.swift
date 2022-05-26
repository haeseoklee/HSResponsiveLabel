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
        let myCustomKind = ElementKind(id: "my.custom", regexPattern: "[a-zA-Z]+") { element in
            self.alert("my.custom", message: element.string)
//            element.id
        }
        //navigation
        let urlKind = URLElementKind(id: "url")
        label.kinds = [myCustomKind, urlKind]
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //  ActiveLabel, TTTAttributedLabel 이기고 싶다면,
        //  Mention

        responsiveLabel.text =
        """
            도시속밀림 반포 한강공원 세빛섬에서 한강 요트 투어를 즐길 수 있습니다.
            골든블루마리나의 레인보우브릿지 한강 요트 대여로 요트 투어를 즐겨보세요!
            6/23은 FoundationTF 회식이 있어서 제외했습니다.
            결정: 이번주 Weekly 시간에.
            1번이 한강 크루즈 + 뷔페인거죠? ㅎ
            스총무 어떻게 되나요?
            Stanley, Tim
            크루즈를 가겠군요
            Dewey의 열렬한 반응으로 크루즈 + 선상뷔페 에서 식사후 + 요트 코스로 변경하겠습니다.
        """

        view.addSubview(responsiveLabel)
        NSLayoutConstraint.activate([
            responsiveLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            responsiveLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            responsiveLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            responsiveLabel.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
        ])
    }

    func alert(_ title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        vc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(vc, animated: true, completion: nil)
    }
}

