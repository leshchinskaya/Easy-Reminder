//
//  ERTableViewControllerTests.swift
//  Easy ReminderTests
//
//  Created by Marie on 21.12.17.
//  Copyright © 2017 Mariya. All rights reserved.
//

import XCTest
@testable import Easy_Reminder

//удаление
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
        //let mockERTableViewController = MockERTableViewController()
    
        var reminderTitles = ["Title1", "Title2"]
        var reminderDescs = ["Description1", "Description2"]
        
        //mockERTableViewController.
    
    }
}


//принятие данных из инпут
//принятие данных из дитейл
