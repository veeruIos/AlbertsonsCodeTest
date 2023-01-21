//
//  TestNetworkManager.swift
//  AlbertsonsCodeVeeru
//
//  Created by Suthari, Veerabrahmam on 1/20/23.
//

import XCTest

final class TestNetworkManager: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRandomUrl() throws {
        NetworkManager.resetRandomNumber(isPortrait: true)
        let randomUrl1 = NetworkManager.randomImageUrl()
        NetworkManager.resetRandomNumber(isPortrait: false)
        let newRandomUr = NetworkManager.randomImageUrl()
        XCTAssertNotEqual(randomUrl1, newRandomUr)
    }
    
    func testImageUrl() throws {
        let url = NetworkManager.randomImageUrl()
        XCTAssertTrue(url.hasPrefix("https://placekitten.com/"))
    }
    
    func testGetRandomFact() throws {
        let networkManager = NetworkManager()
        let exp = expectation(description: "Loading facts")
        networkManager.config(session: URLSession.shared)
        // call my asynchronous method
        NetworkManager.getRandomFact { fact in
            XCTAssertTrue(!fact.isEmpty)
            exp.fulfill()
        }
        // wait three seconds for all outstanding expectations to be fulfilled
        waitForExpectations(timeout: 3)
        
    }
    
    func testFailureGetRandomFact() throws {
        let networkManager = NetworkManager()
        let session = URLSessionMock()
        let exp = expectation(description: "Loading facts")
        
        // call my asynchronous method
        networkManager.config(session: session)
        NetworkManager.getRandomFact { fact in
            XCTAssertTrue(fact.isEmpty)
            exp.fulfill()
        }
        // wait three seconds for all outstanding expectations to be fulfilled
        waitForExpectations(timeout: 3)
        
        let exp1 = expectation(description: "Loading wrong data")
        session.data = .init()
        NetworkManager.getRandomFact { fact in
            XCTAssertTrue(fact.isEmpty)
            exp1.fulfill()
        }
        waitForExpectations(timeout: 3)
    }
}
