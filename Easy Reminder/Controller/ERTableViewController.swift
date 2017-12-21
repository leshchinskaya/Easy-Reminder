//
//  ERTableViewController.swift
//  Easy Reminder
//
//  Created by Marie on 04.12.17.
//  Copyright © 2017 Mariya. All rights reserved.
//

import UIKit

class ERTableViewController: UITableViewController {
    
    var reminderTitles = ["Title1", "Title2"]
    var reminderDescs = ["Description1", "Description2"]
    
    var reminders: [ReminderItem]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reminders = []
        /*
        let reminder = ReminderItem()
        reminder.title = "Title1"
        reminder.itemDescription = "Description1"
        reminder.timestamp = "02/22/2016"
        reminder.location = "Office"
        reminders.append(reminder)
         */
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return reminders?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        if let reminder = reminders?[indexPath.row] {
            cell.textLabel?.text = reminder.title
            cell.detailTextLabel?.text = reminder.itemDescription
        }
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            reminders?.remove(at: indexPath.row)
        }
        
        /*
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
         */
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "detailSegue", sender: indexPath)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? InputViewController, segue.identifier == "addSegue" {
            destVC.delegate = self
        }
        
         if let destVC = segue.destination as? DetailViewController, segue.identifier == "detailSegue" {
            guard
                let reminder = reminders?[(sender as! IndexPath).row],
                let indexPath = sender as? IndexPath else { return }
            destVC.reminder = reminder
            destVC.indexPath = indexPath
            destVC.delegate = self
        }
    }

}

extension ERTableViewController: InputViewControllerDelegate {
    func inputViewController(_ inputViewController: InputViewController, didAddReminder reminder: ReminderItem) {
        print(reminder.title + " " + reminder.itemDescription!)
        reminders?.append(reminder)
    }
}

extension ERTableViewController: DetailViewControllerDelegate {
    func detailViewController(_ detailViewController: DetailViewController, didEditReminder reminder: ReminderItem, at indexPath: IndexPath) {
        reminders![indexPath.row] = reminder
//        tableView.reloadData()
    }
}
