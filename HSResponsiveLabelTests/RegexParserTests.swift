//
//  RegexParserTests.swift
//  HSResponsiveLabelTests
//
//  Created by Haeseok Lee on 2022/05/25.
//

import XCTest
@testable import HSResponsiveLabel

class RegexParserTests: XCTestCase {

    let sut: RegexParser = RegexParser()

    var customKind: ElementKind?
    
    var urlKind: URLElementKind?

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        customKind = nil
        urlKind = nil
    }

    func testParseAlphabet() throws {

        // given
        let alphabetRegexPattern: String = "[a-zA-Z]+"
        let text: String =
        """
        도시속밀림 반포 한강공원 세빛섬에서 한강 요트 투어를 즐길 수 있습니다.
        골든블루마리나의 레인보우브릿지 한강 요트 대여로 요트 투어를 즐겨보세요!
        6/23은 FoundationTF 회식이 있어서 제외했습니다.
        결정: 이번주 Weekly 시간에.
        1번이 한강 크루즈 + 뷔페인거죠? ㅎ
        스총무 어떻게 되나요?
        크루즈를 가겠군요
        Dewey의 열렬한 반응으로 크루즈 + 선상뷔페 에서 식사후 + 요트 코스로 변경하겠습니다.
        """
        
        // when
        customKind = ElementKind(id: "test.custom", regexPattern: alphabetRegexPattern)
        let attrString = NSAttributedString(string: text)
        let mutAttrString = NSMutableAttributedString(attributedString: attrString)
        let results = sut.parse(from: mutAttrString, kind: customKind!)

        // then
        let expectedResults = ["FoundationTF", "Weekly", "Dewey"]

        XCTAssertEqual(results.count, expectedResults.count)

        XCTAssertTrue(
            zip(results, expectedResults).reduce(true) { partialResult, result in
                return partialResult && (result.0.string == result.1)
            }
        )
    }
    
    func testParseURL() throws {
        // given
        let text: String =
        """
        - https://m.search.daum.net
        - https://qandastudent.page.link/
        - fasdfasfasfsa.com
        - sdsdfafa.fasdfasdf.ac.kr
        - www.google.com
        - http://www.naver.com
        
        nQETC9sEQjAgt3oJ6 콴다 dadsfadsfadf.com - 문제가 문제 되지 않을 때까지
        친구가 콴다 스터디 그룹에 초대했어요!함께 공부하러 가볼까요~?
        """
        
        // when
        urlKind = URLElementKind(id: "test.url")
        let attrString = NSAttributedString(string: text)
        let mutAttrString = NSMutableAttributedString(attributedString: attrString)
        let results = sut.parse(from: mutAttrString, kind: urlKind!)

        // then
        let expectedResults = [
            "https://m.search.daum.net",
            "https://qandastudent.page.link/",
            "www.google.com",
            "http://www.naver.com"
        ]

        XCTAssertEqual(results.count, expectedResults.count)

        XCTAssertTrue(
            zip(results, expectedResults).reduce(true) { partialResult, result in
                return partialResult && (result.0.string == result.1)
            }
        )
    }
}
