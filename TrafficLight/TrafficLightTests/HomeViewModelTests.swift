import XCTest
@testable import TrafficLight

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testInitialStateIsEmpty() {
        XCTAssertEqual(viewModel.car.model, "", "Initial car model should be empty.")
        XCTAssertFalse(viewModel.showTrafficLight, "Traffic light should not be shown initially.")
        XCTAssertFalse(viewModel.showAlert, "Alert should not be shown initially.")
    }
    
    func testValidCarModel() {
        viewModel.car.model = "Tesla"
        viewModel.validateInput()
        
        XCTAssertTrue(viewModel.showTrafficLight, "Traffic light should be shown for valid car model.")
        XCTAssertFalse(viewModel.showAlert, "Alert should not be shown for valid car model.")
    }
    
    func testInvalidCarModel() {
        viewModel.car.model = "Te"
        viewModel.validateInput()
        
        XCTAssertFalse(viewModel.showTrafficLight, "Traffic light should not be shown for invalid car model.")
        XCTAssertTrue(viewModel.showAlert, "Alert should be shown for invalid car model.")
    }
    
    func testTrimmedCarModel() {
        viewModel.car.model = "  Tesla  "
        viewModel.validateInput()
        
        XCTAssertTrue(viewModel.showTrafficLight, "Traffic light should be shown for a valid car model with trimmed spaces.")
        XCTAssertFalse(viewModel.showAlert, "Alert should not be shown for valid car model after trimming spaces.")
    }
    
    func testEmptyCarModelWithSpaces() {
        viewModel.car.model = "   "
        viewModel.validateInput()
        
        XCTAssertFalse(viewModel.showTrafficLight, "Traffic light should not be shown for empty car model with spaces.")
        XCTAssertTrue(viewModel.showAlert, "Alert should be shown for empty car model with spaces.")
    }
    
    func testAlertForInvalidCarModel() {
        viewModel.car.model = "Te"
        viewModel.validateInput()
        
        XCTAssertTrue(viewModel.showAlert, "Alert should be shown for car models with less than 3 characters.")
    }

    func testNavigateToTrafficLightView() {
        viewModel.car.model = "Tesla"
        viewModel.validateInput()
        
        XCTAssertTrue(viewModel.showTrafficLight, "Traffic light view should be shown for valid car model.")
    }
}
