import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
	[testCase(LoadingStateTests.allTests)]
}
#endif
