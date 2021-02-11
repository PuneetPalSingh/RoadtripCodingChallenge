//
//  TracksViewModelTests.swift
//  TracksViewModelTests
//
//  Created by Puneet Pal Singh on 12/3/20.
//

import XCTest
@testable import RoadtripCodingChallenge

class TracksViewModelTests: RoadtripCodingChallengeTests {
    private var viewModel: TracksViewModel?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        viewModel = TracksViewModel.init(view: nil)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        viewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    override func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    override func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testTracksFetch() {
        let expectation = self.expectation(description: "Fetch release tracks")
        
        viewModel?.fetchNewReleaseTracks(complitionHandler: { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (com.puneetpalsingh.RoadtripCodingChallenge error 401.)")
            case .success(let tracks):
                XCTAssertEqual(tracks.count, 20)
            }
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                print("Fetch release tracks Time out: " + error.localizedDescription)
            }
        }
    }
}
