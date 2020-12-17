//
//  ViewGenerator.swift
//  Claim iOS View Programming
//
//  Created by Brian Chung on 11/24/20.
//

import UIKit

class ViewGenerator {
    var root : UIView!
    var vals : [UITextField]!
    var sendBtn : UIButton!
    var completeStackView : UIStackView!
    
    init(v : UIView) {
        root = v
    }
    
    func setViewReference() {
        vals = [UITextField]()
        
        //
        for sv in completeStackView.arrangedSubviews {    // 3 of them
            
            if sv is UILabel {
                continue
            }
            
            let innerStackView = sv as! UIStackView
            for ve in innerStackView.arrangedSubviews { // 2 of them
                if ve is UITextField {
                    vals.append(ve as! UITextField)
                }
                if ve is UIButton {
                    let btn = ve as! UIButton
                    if btn.titleLabel?.text == "Add" {
                        sendBtn = btn
                    }
                }
            }

        }
    }

    func generate() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        
        let lbl = UILabel()
        lbl.text = "Please Enter Claim Information"
        lbl.textAlignment = .center
        lbl.sizeToFit()
        stackView.addArrangedSubview(lbl)
        
        var fvGenerator : FieldValueViewGenerator!
        var sView : UIStackView!
        fvGenerator = FieldValueViewGenerator(n:"Claim Title", v: "Example Claim")
        sView = fvGenerator.generate()
        stackView.addArrangedSubview(sView)
        
        fvGenerator = FieldValueViewGenerator(n:"Date", v: "2011-03-19")
        sView = fvGenerator.generate()
        stackView.addArrangedSubview(sView)
        
        let btnGenerator = ButtonViewGenerator(n: "Add")
        sView = btnGenerator.generate()
        stackView.addArrangedSubview(sView)
        
        fvGenerator = FieldValueViewGenerator(n:"Status", v: "Awaiting Response...", readOnly: true)
        sView = fvGenerator.generate()
        stackView.addArrangedSubview(sView)
        
        completeStackView = stackView
        root.addSubview(stackView)
        
        setViewReference()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let spCnt1 = stackView.topAnchor.constraint(equalTo: root.safeAreaLayoutGuide.topAnchor)
        let spCnt2 = stackView.leadingAnchor.constraint(equalTo: root.safeAreaLayoutGuide.leadingAnchor)
        let spCnt3 = stackView.bottomAnchor.constraint(equalTo: root.safeAreaLayoutGuide.bottomAnchor)
        let spCnt4 = stackView.trailingAnchor.constraint(equalTo: root.safeAreaLayoutGuide.trailingAnchor)
        spCnt1.isActive = true
        spCnt2.isActive = true
        spCnt3.isActive = false
        spCnt4.isActive = true
    }
}


class FieldValueViewGenerator {
    var lblName : String!
    var initVal : String!
    var readOnlyState : Bool!
    
    init(n : String, v : String = "Initial Value", readOnly : Bool = false) {
        lblName = n
        initVal = v
        readOnlyState = readOnly
    }
    
    func generate() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        //
        let lbl = UILabel()
        lbl.text = lblName
        lbl.sizeToFit()
        stackView.addArrangedSubview(lbl)
        let val = UITextField()
        val.text = initVal
        val.backgroundColor = UIColor.lightGray
        stackView.addArrangedSubview(val)
        
        if (readOnlyState) {
            val.isUserInteractionEnabled = false
        }
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.widthAnchor.constraint(equalToConstant: 100).isActive = true;
        
        // Expand
        lbl.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        val.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        return stackView
    }
}


class ButtonViewGenerator {
    var lblName : String!
    
    init(n : String) {
        lblName = n
    }
    
    func generate() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        //
        let btn = UIButton()
        btn.setTitle(lblName, for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.systemBlue
        
        stackView.addArrangedSubview(btn)
        
        return stackView
    }
}
