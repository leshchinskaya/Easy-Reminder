//
//  ERTableViewControllerTests.swift
//  Easy ReminderTests
//
//  Created by Marie on 21.12.17.
//  Copyright © 2017 Mariya. All rights reserved.
//

import XCTest
@testable import Easy_Reminder

class ERTableViewControllerTests: XCTestCase {
    
    var sut: ERTableViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "ERTableViewController") as! ERTableViewController
        _ = sut.view
        
    }
    
    
    func test_DeleteReminder() {
        
        var reminderTitle = ["Title1"]
        var reminderDescription = ["Description1"]
        var reminderLocation = ["Office"]
        var reminderDate = ["10/10/2010"]
        var reminderAddress = ["Infinite Loop 1, Cupertino"]
        
        reminderTitle.remove(at: 0)
        reminderDescription.remove(at: 0)
        reminderDate.remove(at: 0)
        reminderAddress.remove(at: 0)
        reminderLocation.remove(at: 0)
    
    }
}
