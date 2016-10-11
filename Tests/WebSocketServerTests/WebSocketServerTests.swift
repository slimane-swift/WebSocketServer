import XCTest
@testable import WebSocketServer

class WebSocketServerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(WebSocketServer().text, "Hello, World!")
    }


    static var allTests : [(String, (WebSocketServerTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
