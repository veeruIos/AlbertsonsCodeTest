//
//  TestHomeView.swift
//  AlbertsonsCodeVeeru
//
//  Created by Suthari, Veerabrahmam on 1/20/23.
//

import XCTest

final class TestCatView: XCTestCase {
    private var homeView = HomeView()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSetUp() throws {
        let homeView = HomeView()
        XCTAssertNotNil(homeView)
        XCTAssertEqual(homeView.axis, .vertical)
        XCTAssertEqual(homeView.spacing, 5)
        XCTAssertEqual(homeView.distribution, .fillProportionally)
        XCTAssertEqual(homeView.arrangedSubviews.count, 2)
    }
    
    func testchangeAxis() throws {
        homeView.changeAxis(isPortrait: false)
        XCTAssertTrue(homeView.axis == .horizontal)
        homeView.changeAxis(isPortrait: true)
        XCTAssertTrue(homeView.axis == .vertical)
    }
    func testUpdateLabel() throws {
        let title = "test"
        homeView.updateLabel(title: title)
        XCTAssertEqual(title, homeView.testHook.factLabel.text)
    }

}
