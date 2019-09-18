//
//  ConcurrencyTestTests.swift
//  ConcurrencyTestTests
//


import XCTest
@testable import ConcurrencyTest

private var viewController: ViewController!

class ConcurrencyTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Using this, a new instance of ViewController will be created
        // before each test is run.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewController = storyboard.instantiateInitialViewController() as? ViewController
        let _ = viewController.view
    }
    
    func testviewDidLoad() {
        viewController.viewDidLoad()
        XCTAssertNotNil(viewController.label)
    }
    
    func testloadSuccessMessage() {
        loadMessage { combinedMessage in
            XCTAssertEqual("Hello world", viewController.label.text)
        }
    }
    
    func testloadFailMessage() {
        loadMessage { combinedMessage in
            XCTAssertEqual("Unable to load message - Time out exceeded", combinedMessage)
        }
    }
    
    func testfetchMessageOne() {
        fetchMessageOne { messageOne in
            XCTAssertEqual("Hello", messageOne)
        }
    }
    
    func testfetchMessageTwo() {
        fetchMessageTwo { messageTwo in
            XCTAssertEqual( "world", messageTwo)
        }
    }
    
    func testgetDispatchTimeOutResult() {
        let dispatchGroup = DispatchGroup()
        let dispatchTimeForMessage = (DispatchTime.now() + DispatchTimeInterval.milliseconds(2*1000))
        let dispatchTimeoutResult = dispatchGroup.wait(timeout:dispatchTimeForMessage)
        XCTAssertFalse(getDispatchTimeOutResult(dispatchTimeoutResult:dispatchTimeoutResult))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        viewController = nil
    }
    

}
