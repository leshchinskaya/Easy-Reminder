//
//  ItemManager.swift
//  Easy Reminder
//
//  Created by Marie on 04.12.17.
//  Copyright © 2017 Mariya. All rights reserved.
//

import UIKit

class ItemManager: NSObject {
    var toDoCount: Int { return toDoItems.count}
    var doneCount: Int { return doneItems.count}
    private var toDoItems = [ReminderItem]()
    private var doneItems = [ReminderItem]()
    
    
    func addItem(item: ReminderItem) {
        
        if !toDoItems.contains(item) {
            toDoItems.append(item)
        }
    }
    
    func itemAtIndex(index: Int) -> ReminderItem {
        
        return  toDoItems[index]
    }
    
    func checkItemAtIndex(index: Int) {
        
        let item = toDoItems.remove(at: index)
        doneItems.append(item)
    }
    
    func doneItemAtIndex(index: Int) -> ReminderItem {
        return doneItems[index]
    }
    
    func removeAllItems() {
        toDoItems.removeAll()
        doneItems.removeAll()
    }
    
    func uncheckItemAtIndex(index: Int) {
        let item = doneItems.remove(at: index)
        toDoItems.append(item)
    }
    
    @objc func save() {
        //save todo
        var nsToDoItems = [AnyObject]()
        for item in toDoItems {
            nsToDoItems.append(item.plistDict)
        }
        
        // save done
        var nsDoneItems = [AnyObject]()
        for item in doneItems {
            nsDoneItems.append(item.plistDict)
        }
        
    }
    
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ItemManager.save),
            name: NSNotification.Name.UIApplicationWillResignActive,
            object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        save()
    }
}
