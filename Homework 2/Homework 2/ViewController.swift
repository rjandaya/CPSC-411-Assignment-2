//
//  ViewController.swift
//  Homework 2
//
//  Created by RJ Andaya on 11/20/20.
//

import UIKit

class ViewController: UIViewController {
    
    var title_field: UITextField?
    var date_field: UITextField?
    var status_field: UITextField?
    let dateFormatterGet = DateFormatter()

    @objc func addClaim(sender: UIButton) {
        print("\nAdd button pressed")

        let cService = ClaimService(vc: self)
        let title_val = title_field!.text
        let date_val = date_field!.text
        
        dateFormatterGet.dateFormat = "YYYY MM-DD"
        
//        Test for valid entry
        print("title:'\(title_val!)' date:'\(date_val!)'")
        if title_val! == "" || date_val! == "" {
            status_field?.text = "Claim title or date missing"
        } else if dateFormatterGet.date(from: date_val!) == nil {
            status_field?.text = "Invalid date"
        } else {
            cService.addClaim(cObj: Claim(this_title: title_val!, this_date: date_val!))
        }
    }
    
    func setStatusField(status: String) {
        status_field!.text = status
    }
    
    func refreshForm(title: String, date: String) {
        title_field!.text = title
        date_field!.text = date
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        1. Create screen
        let detailScreenGenerator = ClaimDetailScreenGenerator(v: view)
        print("Screen generator initialized")
        detailScreenGenerator.generate()
        
//        2. Prepare data
//        cService = ClaimService.getInstance(vc: self)
//        cService.addClaim(cObj: Claim(this_title: "", this_date: ""))
//        cService.getAll()
        
//        3. Set the event handling
        let aBtn = detailScreenGenerator.addBtn
        title_field = detailScreenGenerator.vals[0]
        date_field = detailScreenGenerator.vals[1]
        status_field = detailScreenGenerator.vals[2]
        
        aBtn?.addTarget(self, action: #selector(addClaim(sender:)), for: .touchUpInside)
    }


}

