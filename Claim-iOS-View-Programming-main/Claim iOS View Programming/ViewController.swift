//
//  ViewController.swift
//  Claim iOS View Programming
//
//  Created by Brian Chung on 11/24/20.
//

import UIKit

class ViewController: UIViewController {
    var claimTitleField: UITextField?
    var claimDateField: UITextField?
    var statusTextField: UITextField?
    
    @objc func sendData(sender: UIButton) {
        //
        let cService = ClaimService(vc : self)
        let claimTitle = claimTitleField!.text
        let claimDate = claimDateField!.text
        
        let claimObj = Claim(title: claimTitle!, date: claimDate!)
        
        cService.addClaim(claim: claimObj)
        
        // Reset Form
        claimTitleField!.text = ""
        claimDateField!.text = ""
    }
    
    
    func setStatusField(status: String) {
        statusTextField!.text = status
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let viewGen = ViewGenerator(v: view)
        
        viewGen.generate()
        
        let sendBtn = viewGen.sendBtn
        claimTitleField = viewGen.vals[0]
        claimDateField = viewGen.vals[1]
        statusTextField = viewGen.vals[2]
        
        
        sendBtn?.addTarget(self, action: #selector(sendData(sender:)), for: .touchUpInside)
    }
    
}

