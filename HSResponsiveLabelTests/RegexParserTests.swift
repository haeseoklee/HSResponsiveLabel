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

    let alphabetRegexPattern: String = "[a-zA-Z]+"

    var elementKind: ElementKind?

    override func setUpWithError() throws {
        try super.setUpWithError()
        elementKind = ElementKind(id: "test", regexPattern: alphabetRegexPattern)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        elementKind = nil
    }

    func testParse() throws {

        // given & when
        let results = sut.parse(from: text, kind: elementKind!)

        // then
        let expectedResults = ["FoundationTF", "Weekly", "Dewey"]

        XCTAssertEqual(results.count, expectedResults.count)

        XCTAssertTrue(
            zip(results, expectedResults).reduce(true) { partialResult, result in
                return partialResult && (result.0.string == result.1)
            }
        )
    }
}
