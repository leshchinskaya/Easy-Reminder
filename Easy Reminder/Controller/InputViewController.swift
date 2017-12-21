//
//  InputViewController.swift
//  Easy Reminder
//
//  Created by Marie on 07.12.17.
//  Copyright © 2017 Mariya. All rights reserved.
//

import UIKit
import CoreLocation

protocol InputViewControllerDelegate: class  {
    func inputViewController(_ inputViewController: InputViewController, didAddReminder reminder: ReminderItem)
}

class InputViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    weak var delegate: InputViewControllerDelegate?
    
    lazy var geocoder = CLGeocoder()
    var itemManager: ItemManager?
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    
    @IBAction func save() {
        print ("Save")
        guard let titleString = titleTextField.text, titleString.characters.count > 0 else { return }
        let date: NSDate?
        if let dateText = self.dateTextField.text, dateText.characters.count > 0 {
            date = dateFormatter.date(from: dateText)! as NSDate
        } else {
            date = nil
        }
        let descriptionString: String?
        if descriptionTextField.text!.characters.count > 0 {
            descriptionString = descriptionTextField.text
        } else {
            descriptionString = nil
        }
        if let locationName = locationTextField.text, locationName.characters.count > 0 {
            if let address = addressTextField.text, address.characters.count > 0 {
                geocoder.geocodeAddressString(address) {
                    [unowned self] (placeMarks, error) -> Void in
                    let placeMark = placeMarks?.first
                    let item = ReminderItem(title: titleString,
                                        itemDescription: descriptionString,
                                        timestamp: date?.timeIntervalSince1970,
                                        location: Location(name: locationName,
                                                       coordinate: placeMark?.location?.coordinate))
                    DispatchQueue.main.async {
                        () -> Void in
                        self.delegate?.inputViewController(self, didAddReminder: item)
                        self.navigationController?.popViewController(animated: true)
                        self.itemManager?.addItem(item: item)
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                }
            } else {
                let item = ReminderItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: Location(name: locationName))
                self.delegate?.inputViewController(self, didAddReminder: item)
                self.navigationController?.popViewController(animated: true)
                self.itemManager?.addItem(item: item)
                dismiss(animated: true, completion: nil)
            }
        } else {
            let item = ReminderItem(title: titleString, itemDescription: descriptionString, timestamp: date?.timeIntervalSince1970, location: nil)
            self.delegate?.inputViewController(self, didAddReminder: item)
            self.navigationController?.popViewController(animated: true)
            self.itemManager?.addItem(item: item)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
