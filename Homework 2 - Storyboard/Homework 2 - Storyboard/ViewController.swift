//
//  ViewController.swift
//  Homework 2 - Storyboard
//
//  Created by RJ Andaya on 11/22/20.
//

import UIKit

class ViewController: UIViewController {
    
    let dateFormatterGet = DateFormatter()
    
    @IBOutlet var title_val: UITextField!
    @IBOutlet var date_val: UITextField!
    @IBOutlet var status_val: UITextView!
    
    @IBAction func add() {
        print("\nAdd button pressed")
        
        let cService = ClaimService(vc: self)

        dateFormatterGet.dateFormat = "YYYY MM-DD"
        
//        Test for valid entry
        print("title:'\(title_val.text!)' date:'\(date_val.text!)'")
        if title_val.text! == "" || date_val.text! == "" {
            status_val.text = "Claim title or date missing"
        } else if dateFormatterGet.date(from: date_val.text!) == nil {
            status_val.text = "Invalid date"
        } else {
            cService.addClaim(cObj: Claim(this_title: title_val.text!, this_date: date_val.text!))
        }
    }
    
    func setStatusField(status: String) {
        status_val!.text = status
    }
    
    func refreshForm(title: String, date: String) {
        title_val!.text = title
        date_val!.text = date
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

