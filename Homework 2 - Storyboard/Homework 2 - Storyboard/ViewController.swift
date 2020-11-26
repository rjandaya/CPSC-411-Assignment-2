//
//  ViewController.swift
//  Homework 2 - Storyboard
//
//  Created by RJ Andaya on 11/22/20.
//

import UIKit

class ViewController: UIViewController {
    
    let cService = ClaimService()
    let dateFormatterGet = DateFormatter()
    
    @IBOutlet var title_val: UITextField!
    @IBOutlet var date_val: UITextField!
    @IBOutlet var status_val: UITextField!
    
    @IBAction func add() {
        print("\nAdd button pressed")
        dateFormatterGet.dateFormat = "YYYY MM-DD"
        
//        Test for valid entry
        print("title:'\(title_val.text!)' date:'\(date_val.text!)'")
        if title_val.text! == "" || date_val.text! == "" {
            status_val.text = "Claim title or date missing"
        } else if dateFormatterGet.date(from: date_val.text!) == nil {
            status_val.text = "Invalid date"
        } else {
            cService.addClaim(cObj: Claim(this_title: title_val.text!, this_date: date_val.text!))
            if cService.addComplete == true {
                status_val.text! = "Claim \(title_val.text!) created"
                title_val!.text?.removeAll()
                date_val!.text?.removeAll()
            } else if cService.addComplete == false {
                status_val.text! = "Claim \(title_val.text!) was not created"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cService.addClaim(cObj: Claim(this_title: "", this_date: ""))

    }


}

