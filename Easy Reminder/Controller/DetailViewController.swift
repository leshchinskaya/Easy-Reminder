//
//  DetailViewController.swift
//  Easy Reminder
//
//  Created by Marie on 14.12.17.
//  Copyright © 2017 Mariya. All rights reserved.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func detailViewController(_ detailViewController: DetailViewController, didEditReminder reminder: ReminderItem, at indexPath: IndexPath)
}

class DetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var reminder: ReminderItem?
    var indexPath: IndexPath?
    
    weak var delegate: DetailViewControllerDelegate?
    
    @IBAction func save(_ sender: Any) {
        print("save detail")
        reminder?.title = titleTextField.text!
        reminder?.timestamp = dateTextField.text?.dateRepresentation
        reminder?.itemDescription = descriptionTextField.text
        guard let reminder = reminder, let indexPath = indexPath else {
            return
        }
        delegate?.detailViewController(self, didEditReminder: reminder, at: indexPath)
        dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.text = reminder?.title
        locationTextField.text = reminder?.location?.name
        dateTextField.text = reminder?.timestamp?.stringRepresentation
        addressTextField.text = "Chto-to"
        descriptionTextField.text = reminder?.itemDescription
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Date {
    var stringRepresentation: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: self)
    }
}

extension String {
    var dateRepresentation: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: self)!
    }
}
