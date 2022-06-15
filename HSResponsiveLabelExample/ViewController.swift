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
        
        let myCustomKind = ElementKind(id: "my.custom.kind", regexPattern: "[a-zA-Z]+") { element in
            self.alert("my.custom.kind", message: element.string)
        }
        myCustomKind.textColor = .systemBlue
        myCustomKind.selectedTextColor = .systemYellow
        
        let urlKind = URLElementKind(id: "my.url.kind", enabledSchemes: [
            "http", "https"
        ]) { element in
            self.alert("my.url.kind", message: element.string)
        }
        urlKind.textColor = .systemRed
        urlKind.textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
        urlKind.selectedTextColor = .systemYellow
        urlKind.selectedTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)]
        urlKind.configurationHandler = { element, attributes in
            var newAttributes = attributes
            switch element.string {
            case "http://www.naver.com":
                newAttributes[NSAttributedString.Key.foregroundColor] = UIColor.systemGreen
                newAttributes[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 20)
                return (true, newAttributes)
            default:
                break
            }
            return (false, newAttributes)
        }
        
        label.kinds = [urlKind]
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        label.textColor = .systemGray2
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        responsiveLabel.text =
//        """
//        도시속밀림 반포 한강공원 세빛섬에서 한강 요트 투어를 즐길 수 있습니다.
//        골든블루마리나의 레인보우브릿지 한강 요트 대여로 요트 투어를 즐겨보세요!
//        6/23은 FoundationTF 회식이 있어서 제외했습니다.
//        결정: 이번주 Weekly 시간에.
//        1번이 한강 크루즈 + 뷔페인거죠? ㅎ
//        스총무 어떻게 되나요?
//        크루즈를 가겠군요
//        Dewey의 열렬한 반응으로 크루즈 + 선상뷔페 에서 식사후 + 요트 코스로 변경하겠습니다.
//        """
        """
        - https://m.search.daum.net
        - https://qandastudent.page.link/
        - fasdfasfasfsa.com
        - sdsdfafa.fasdfasdf.ac.kr
        - www.google.com
        - http://www.naver.com
        - https://www.google.com/search?q=qanda&oq=qanda&aqs=chrome..69i57j0i512j69i60l2j69i65l2j69i61j69i60.2422j0j7&sourceid=chrome&ie=UTF-8
        
        nQETC9sEQjAgt3oJ6 콴다 dadsfadsfadf.com - 문제가 문제 되지 않을 때까지
        친구가 콴다 스터디 그룹에 초대했어요!함께 공부하러 가볼까요~?
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

