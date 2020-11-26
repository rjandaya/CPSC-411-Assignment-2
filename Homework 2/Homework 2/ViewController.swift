//
//  ViewController.swift
//  Homework 2
//
//  Created by RJ Andaya on 11/20/20.
//

import UIKit

class ViewController: UIViewController {
    
    var cService = ClaimService()
    var detailScreenGenerator: ClaimDetailScreenGenerator!
    
    var vals = [UITextField]()
    var title_val: String!
    var date_val: String!
    var status_val: String!
//    var addStatus: Bool?
    let dateFormatterGet = DateFormatter()
    
//    func addComplete() {
//        addStatus = true
//    }
//
//    func addIncomplete() {
//        addStatus = false
//    }
    
    @objc func addClaim(sender: UIButton) {
        print("\nAdd button pressed")
//        Assign UITextField values to variables
        title_val = detailScreenGenerator.vals[0].text!
        date_val = detailScreenGenerator.vals[1].text!
        dateFormatterGet.dateFormat = "YYYY MM-DD"
        
//        Test for valid entry
        print("title:'\(title_val!)' date:'\(date_val!)'")
        if title_val! == "" || date_val! == "" {
            status_val = "Claim title or date missing"
        } else if dateFormatterGet.date(from: date_val!) == nil {
            status_val = "Invalid date"
        } else {
            cService.addClaim(cObj: Claim(this_title: title_val!, this_date: date_val!))
            if cService.addComplete == true {
                status_val = "Claim \(title_val!) created"
                detailScreenGenerator.vals[0].text?.removeAll()
                detailScreenGenerator.vals[1].text?.removeAll()
            } else if cService.addComplete == false {
                status_val = "Claim \(title_val!) was not created"
            }
        }
        
//        Refresh data
        detailScreenGenerator.vals[2].text = status_val
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        1. Create screen
        detailScreenGenerator = ClaimDetailScreenGenerator(v: view)
        print("Screen generator initialized")
        detailScreenGenerator.generate()
        
//        2. Prepare data
//        cService = ClaimService.getInstance(vc: self)
        cService.addClaim(cObj: Claim(this_title: "", this_date: ""))
//        cService.getAll()
        
//        3. Set the event handling
        let aBtn = detailScreenGenerator.addBtn
        aBtn?.addTarget(self, action: #selector(addClaim(sender:)), for: .touchUpInside)
    }


}

