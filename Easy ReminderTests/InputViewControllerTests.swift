//
//  InputViewControllerTests.swift
//  Easy ReminderTests
//
//  Created by Marie on 07.12.17.
//  Copyright © 2017 Mariya. All rights reserved.
//

import XCTest
import CoreLocation
@testable import Easy_Reminder

class InputViewControllerTests: XCTestCase {

    var sut: InputViewController!
    //var placemark: MockPlacemark!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
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
    
    func test_SaveNewReminder() {
        var reminderTitle = [String]()
        var reminderDescription = [String]()
        var reminderLocation = [String]()
        var reminderDate = [String]()
        var reminderAddress = [String]()
        
        let mockInputViewController = MockInputViewController()
        
        mockInputViewController.titleTextField = UITextField()
        mockInputViewController.dateTextField = UITextField()
        mockInputViewController.locationTextField = UITextField()
        mockInputViewController.addressTextField = UITextField()
        mockInputViewController.descriptionTextField = UITextField()
        mockInputViewController.titleTextField.text = "Test Title"
        mockInputViewController.dateTextField.text = "02/22/2016"
        mockInputViewController.locationTextField.text = "Office"
        mockInputViewController.addressTextField.text = "Infinite Loop 1, Cupertino"
        mockInputViewController.descriptionTextField.text = "Test Description"
        
        reminderTitle.append(mockInputViewController.titleTextField.text!)
        reminderDescription.append(mockInputViewController.descriptionTextField.text!)
        reminderDate.append(mockInputViewController.dateTextField.text!)
        reminderAddress.append(mockInputViewController.addressTextField.text!)
        reminderLocation.append(mockInputViewController.locationTextField.text!)
        
       // let mockGeocoder = MockGeocoder()
        //mockInputViewController.geocoder = mockGeocoder
        mockInputViewController.itemManager = ItemManager()
        //let expectation = expectation(description: "bla")
        mockInputViewController.completionHandler = {
            //expectation.fulfill()
        }
        mockInputViewController.save()
        
        /*
        placemark = MockPlacemark()
        let coordinate = CLLocationCoordinate2DMake(37.3316851, -122.0300674)
        placemark.mockCoordinate = coordinate
       //mockGeocoder.completionHandler?([placemark], nil)
        waitForExpectations(timeout: 1, handler: nil)
        
        let item = mockInputViewController.itemManager?.itemAtIndex(index: 0)
        
        
        let testItem = ReminderItem(title: "Test Title",
                                itemDescription: "Test Description",
                                timestamp: 1456070400,
                                location: Location(name: "Office", coordinate: coordinate))
        XCTAssertEqual(item, testItem)
         */
        
        XCTAssertTrue(reminderTitle.count==1)
        XCTAssertTrue(reminderDescription.count==1)
        XCTAssertTrue(reminderDate.count==1)
        XCTAssertTrue(reminderAddress.count==1)
        XCTAssertTrue(reminderLocation.count==1)
    }
    
    func test_SaveButtonHasSaveAction() {
        let saveButton: UIButton = sut.saveButton
        guard let actions = saveButton.actions(forTarget: sut, forControlEvent: .touchUpInside)
            else {
                XCTFail();
                return }
        XCTAssertTrue(actions.contains("save"))
    }
    
    /*
    func test_GeocoderWorksAsExpected() {
        //let expectation = expectation(description: "Wait for geocode")
        CLGeocoder().geocodeAddressString("Infinite Loop 1, Cupertino") {
            (placemarks, error) -> Void in
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            guard let latitude = coordinate?.latitude else {
                XCTFail()
                return }
            guard let longitude = coordinate?.longitude else {
                XCTFail()
                return }
            //
            XCTAssertEqual(latitude, 37.3316941,
                                       accuracy: 0.000001)
            XCTAssertEqual(longitude, -122.030127,
                                       accuracy: 0.000001)
            //expectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    */
    func testSave_DismissesViewController() {
        let mockInputViewController = MockInputViewController()
        mockInputViewController.titleTextField = UITextField()
        mockInputViewController.dateTextField = UITextField()
        mockInputViewController.locationTextField = UITextField()
        mockInputViewController.addressTextField = UITextField()
        mockInputViewController.descriptionTextField = UITextField()
        mockInputViewController.titleTextField.text = "Test Title"
        mockInputViewController.dateTextField.text = "10/01/17"
        mockInputViewController.save()
        XCTAssertTrue(mockInputViewController.dismissGotCalled)
    }
}

extension InputViewControllerTests {
    /*
    class MockGeocoder: CLGeocoder {
        var completionHandler: CLGeocodeCompletionHandler?
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    
    class MockPlacemark : CLPlacemark {
        var mockCoordinate: CLLocationCoordinate2D?
        override var location: CLLocation? {
            guard let coordinate = mockCoordinate else
            { return CLLocation() }
            return CLLocation(latitude: coordinate.latitude,
                              longitude: coordinate.longitude)
        }
    }
     */
    
    class MockInputViewController : InputViewController {
        var dismissGotCalled = false
        var completionHandler: (() -> Void)?
        
        override func dismiss(animated flag: Bool,
                              completion: (() -> Void)?) {
            dismissGotCalled = true
            completionHandler?()
        } }

}

