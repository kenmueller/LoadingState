import XCTest
@testable import LoadingState

final class LoadingStateTests: XCTestCase {
	static let allTests = [
		("testExample", testExample)
	]
	
	func testExample() {
		var loadingState = LoadingState()
		
		loadingState.succeed()
		XCTAssert(loadingState.didSucceed)
		
		loadingState.fail(message: "ERR")
		XCTAssert(loadingState.didFail)
		XCTAssertEqual(loadingState.errorMessage, "ERR")
		XCTAssertEqual(loadingState, .failure)
		
		loadingState.reset()
		XCTAssertEqual(loadingState, .none)
	}
}
