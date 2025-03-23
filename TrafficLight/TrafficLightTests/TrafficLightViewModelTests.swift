import XCTest
@testable import TrafficLight

class TrafficLightViewModelTests: XCTestCase {
    var viewModel: TrafficLightViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = TrafficLightViewModel()
    }
    
    override func tearDown() {
        viewModel.stopTrafficLightCycle()
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialStateIsGreen() {
        viewModel.startTrafficLightCycle(from: .green)
        XCTAssertEqual(viewModel.currentLight, .green, "Initial state should be green.")
    }
    
    func testInitialStateIsRed() {
        viewModel.startTrafficLightCycle(from: .red)
        XCTAssertEqual(viewModel.currentLight, .red, "Initial state should be red.")
    }
    
    func testMultipleStartCalls() {
        let expectation = expectation(description: "Traffic light should change to orange")
        viewModel.startTrafficLightCycle(from: .green)
        viewModel.startTrafficLightCycle(from: .red) // This should not override the first start

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.viewModel.currentLight, .green, "Should remain green as multiple starts are ignored.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testOrangeTrafficLightCycle() {
        let expectation = expectation(description: "Traffic light should change to orange")
        viewModel.startTrafficLightCycle(from: .green)

        DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
            XCTAssertEqual(self.viewModel.currentLight, .orange, "State should change to orange.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testRedFromGreenTrafficLightCycle() {
        let expectation = expectation(description: "Traffic light should change to green after orange")
        viewModel.startTrafficLightCycle(from: .green)

        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            XCTAssertEqual(self.viewModel.currentLight, .red, "State should change to red.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 7)
    }
    
    func testFullTrafficLightCycle() {
        let expectation = expectation(description: "Traffic light should complete a full cycle back to red")
        let initLight = TrafficLightState.green
        viewModel.startTrafficLightCycle(from: initLight)

        DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
            XCTAssertEqual(self.viewModel.currentLight, initLight, "State should return to \(initLight) after a full cycle.")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 13)
    }
    
    func testOrangeEveryFiveSeconds() {
        let expectation = expectation(description: "Traffic light should be orange at 5, 10, 15 seconds")
        viewModel.startTrafficLightCycle(from: .green)

        let checkTimes = [5, 10, 15]
        var checkedCount = 0

        for time in checkTimes {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(time)) {
                XCTAssertEqual(self.viewModel.currentLight, .orange, "At \(time)s, state should be orange.")
                checkedCount += 1
                if checkedCount == checkTimes.count {
                    expectation.fulfill()
                }
            }
        }

        wait(for: [expectation], timeout: 16)
    }
    
    func testStopTrafficLightCycle() {
        let expectation = expectation(description: "Traffic light should not proceed after stopping")
        let initLight = TrafficLightState.green
        viewModel.startTrafficLightCycle(from: initLight)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.stopTrafficLightCycle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            XCTAssertEqual(self.viewModel.currentLight, initLight, "State should remain \(initLight) after stopping.")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 6)
    }
}
