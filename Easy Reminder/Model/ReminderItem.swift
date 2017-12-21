//
//  ReminderItem.swift
//  Easy Reminder
//
//  Created by Marie on 04.12.17.
//  Copyright © 2017 Mariya. All rights reserved.
//

import Foundation

struct ReminderItem: Equatable {
    
    var title: String
    var itemDescription: String?
    var timestamp: Date?
    var location: Location?
    private let titleKey = "titleKey"
    private let itemDescriptionKey = "itemDescriptionKey"
    private let timestampKey = "timestampKey"
    private let locationKey = "locationKey"
    
    var plistDict: NSDictionary {
        var dict = [String:AnyObject]()
        dict[titleKey] = title as AnyObject
        if let itemDescription = itemDescription {
            dict[itemDescriptionKey] = itemDescription as AnyObject
        }
        if let timestamp = timestamp {
            dict[timestampKey] = timestamp as AnyObject
        }
        if let location = location {
            let locationDict = location.plistDict
            dict[locationKey] = locationDict
        }
        return dict as NSDictionary
    }
    
    init(title: String, itemDescription: String? = nil, timestamp: Date? = nil, location: Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
    
    init?(dict: NSDictionary) {
        guard let title = dict[titleKey] as? String else
        { return nil }
        self.title = title
        self.itemDescription = dict[itemDescriptionKey] as? String
        self.timestamp = dict[timestampKey] as? Date
        if let locationDict = dict[locationKey] as? NSDictionary {
            self.location = Location(dict: locationDict)
        } else {
            self.location = nil
        }
    }
    
}

extension ReminderItem {
    static func ==(lhs: ReminderItem, rhs: ReminderItem) -> Bool {
        if lhs.location != rhs.location {
            return false
        }
        if lhs.timestamp != rhs.timestamp {
            return false
        }
        if lhs.itemDescription != rhs.itemDescription {
            return false
        }
        if lhs.title != rhs.title {
            return false
        }
        
        return true
    }
}
