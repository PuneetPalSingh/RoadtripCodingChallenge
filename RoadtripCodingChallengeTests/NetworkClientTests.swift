//
//  NetworkClientTests.swift
//  RoadtripCodingChallengeTests
//
//  Created by Puneet Pal Singh on 12/3/20.
//

import XCTest
@testable import RoadtripCodingChallenge

class NetworkClientTests: RoadtripCodingChallengeTests {
    var testAuthToken: String?
    override func setUpWithError() throws {
        testAuthToken = "BQBfVTzW_8rMmxrPhaFgoAAlCRtIXl5p074IzLsYkjJ5e3L4TUDaAO-W3mZtAjB1AUYbOh-0VKbOIM2XAzmFPElszcx9cQPciDKkIBD5GglhVydcJDFKzveUxHX3m6IlnKilbMnfjEqHq3Cg80HMrbpJGZqo_5Z0NDO-gL83aOzCkclWEkscOQ"
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        testAuthToken = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    override func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    override func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSetAuthToken() {
        if NetworkClient.shared.authenticationType == .AuthenticationSpotifyType {
            XCTAssertTrue(NetworkClient.shared.setAuthToken(authToken: testAuthToken))
            XCTAssertFalse(NetworkClient.shared.setAuthToken(authToken: ""))
            XCTAssertFalse(NetworkClient.shared.setAuthToken(authToken: nil))
        }
    }

}
