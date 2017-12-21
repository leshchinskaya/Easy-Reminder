//
//  DetailViewControllerTests.swift
//  Easy ReminderTests
//
//  Created by Marie on 21.12.17.
//  Copyright © 2017 Mariya. All rights reserved.
//

import XCTest
@testable import Easy_Reminder

class DetailViewControllerTests: XCTestCase {
    
    var sut: DetailViewController!
    //var placemark: MockPlacemark!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        _ = sut.view
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func test_HasAllTextField() {
        XCTAssertNotNil(sut.titleTextField)
        XCTAssertNotNil(sut.locationTextField)
        XCTAssertNotNil(sut.addressTextField)
        XCTAssertNotNil(sut.descriptionTextField)
        XCTAssertNotNil(sut.dateTextField)
    }
    
    func test_SaveReminder() {
        let mockDetailViewController = MockDetailViewController()
        
        mockDetailViewController.titleTextField = UITextField()
        mockDetailViewController.dateTextField = UITextField()
        mockDetailViewController.locationTextField = UITextField()
        mockDetailViewController.addressTextField = UITextField()
        mockDetailViewController.descriptionTextField = UITextField()
        mockDetailViewController.titleTextField.text = "Test Title"
        mockDetailViewController.dateTextField.text = "02/22/2016"
        mockDetailViewController.locationTextField.text = "Office"
        mockDetailViewController.addressTextField.text = "Infinite Loop 1, Cupertino"
        mockDetailViewController.descriptionTextField.text = "Test Description"
        mockDetailViewController.save(NSObject())
    }
    
    func test_SaveButtonHasSaveAction() {
        let saveButton: UIButton = sut.saveButton
        guard let actions = saveButton.actions(forTarget: sut, forControlEvent: .touchUpInside)
            else {
                XCTFail();
                return
        }
        XCTAssertTrue(actions.contains("save:"))
    }
 
}

extension DetailViewControllerTests {
    
    class MockDetailViewController : DetailViewController {
        var dismissGotCalled = false
        var completionHandler: (() -> Void)?
        
        override func dismiss(animated flag: Bool,
                              completion: (() -> Void)?) {
            dismissGotCalled = true
            completionHandler?()
        }
        
    }
    
}
