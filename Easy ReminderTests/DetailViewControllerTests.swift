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
    
    func test_SaveGenerReminder() {
        
        var reminderTitle = ["Test Title"]
        var reminderDescription = ["Test Description"]
        var reminderLocation = ["Office"]
        var reminderDate = ["02/22/2016"]
        var reminderAddress = ["Infinite Loop 1, Cupertino"]
        var reminderTitleNew = ["New Test Title"]
        
        let mockDetailViewController = MockDetailViewController()
        
        mockDetailViewController.titleTextField = UITextField()
        mockDetailViewController.dateTextField = UITextField()
        mockDetailViewController.locationTextField = UITextField()
        mockDetailViewController.addressTextField = UITextField()
        mockDetailViewController.descriptionTextField = UITextField()
        mockDetailViewController.titleTextField.text = "New Test Title"
        
        reminderTitle.remove(at: 0)
        reminderTitle.append(mockDetailViewController.titleTextField.text!)
        reminderDescription.append(reminderDescription[0])
        reminderDate.append(reminderDate[0])
        reminderAddress.append(reminderAddress[0])
        reminderLocation.append(reminderLocation[0])
        
        
        mockDetailViewController.save(NSObject())
        
        XCTAssertTrue(reminderTitle[0]==reminderTitleNew[0])
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
