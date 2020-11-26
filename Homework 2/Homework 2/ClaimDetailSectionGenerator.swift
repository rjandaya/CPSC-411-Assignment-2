//
//  ClaimDetailSectionGenerator.swift
//  Homework 2
//
//  Created by RJ Andaya on 11/24/20.
//

import Foundation
import UIKit

// Section Definitions
class HeaderSectionGenerator {
    
    func generate() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        
        let hLbl = UILabel()
        hLbl.text = "Please Enter Claim Information"
        hLbl.textAlignment = .center
        stackView.addArrangedSubview(hLbl)
        
        return stackView
    }
}

class ClaimDetailSectionGenerator {
    
    func generate() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        
        var vGenerator: FieldValueViewGenerator!
        var sView: UIStackView!
        vGenerator = FieldValueViewGenerator(n: "Claim Title", f: "Enter claim title")
        sView = vGenerator.generate()
        stackView.addArrangedSubview(sView)
        vGenerator = FieldValueViewGenerator(n: "Date", f: "Enter date (YYYY MM-DD)")
        sView = vGenerator.generate()
        stackView.addArrangedSubview(sView)
        
        return stackView
    }
}

class buttonSectionGenerator {
    
    func generate() -> UIStackView {
        
        let bStackView = UIStackView()
        bStackView.axis = .horizontal
        bStackView.distribution = .fill
        bStackView.spacing = 5
        let btn = UIButton()
        btn.setTitle("Add", for: .normal)
        btn.setTitleColor(UIColor.systemRed, for: .normal)
        bStackView.addArrangedSubview(btn)
        
        return bStackView
    }
}

class ClaimStatusSectionGenerator {
    
    func generate() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 5
        
        var vGenerator: FieldValueViewGenerator!
        var sView: UIStackView!
        vGenerator = FieldValueViewGenerator(n: "Status", f: "<Status Message>")
        sView = vGenerator.generate()
        stackView.addArrangedSubview(sView)
        
        return stackView
    }
}

class ClaimDetailScreenGenerator {
    
    var root: UIView!
    var headerSecView: UIStackView!
    var detailSecView: UIStackView!
    var buttonSecView: UIStackView!
    var claimStatSecView: UIStackView!
    var vals: [UITextField]!
    var lbls: [UILabel]!
    var addBtn: UIButton!
    
    init(v: UIView) {
        root = v
    }
    
    func setViewReference() {
        vals = [UITextField]()
        lbls = [UILabel]()
        
        for sv in detailSecView.arrangedSubviews {      // Header, Claim Title, Date
            let innerStackView = sv as! UIStackView
            for ve in innerStackView.arrangedSubviews { // UILabel, UITexField
                if ve is UITextField {
                    vals.append(ve as! UITextField)
                } else {
                    lbls.append(ve as! UILabel)
                }
            }
        }
        
        for sv in claimStatSecView.arrangedSubviews {   // Status
            let innerStackView = sv as! UIStackView
            for ve in innerStackView.arrangedSubviews { // UILabel, UITexField
                if ve is UITextField {
                    vals.append(ve as! UITextField)
                } else {
                    lbls.append(ve as! UILabel)
                }
            }
        }
        print("UITextField references created")
        
        for v in vals {
            if v.placeholder == "<Status Message>" {
                v.isUserInteractionEnabled = false
                v.borderStyle = .none
            }
        }
        
        for sv in buttonSecView.arrangedSubviews {
            let btn = sv as! UIButton
            if btn.titleLabel?.text == "Add" {
                addBtn = btn
            }
        }
    }
    
//    Header Section Constraints
    func setHeaderSecConstraints() {
        headerSecView.translatesAutoresizingMaskIntoConstraints = false
        let tConst = headerSecView.topAnchor.constraint(equalTo: root.safeAreaLayoutGuide.topAnchor, constant: 32)
        let lConst = headerSecView.leadingAnchor.constraint(equalTo: root.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        let trConst = headerSecView.trailingAnchor.constraint(equalTo: root.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        tConst.isActive = true
        lConst.isActive = true
        trConst.isActive = true
    }
    
//    Detail Section Constraints
    func setDetailSecConstraints() {
//        Label Constraints
        for i in  0...lbls.count - 1 {
            lbls[i].setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
            lbls[i].setContentHuggingPriority(.defaultHigh, for: .horizontal)
        }
        let constr = lbls[0].widthAnchor.constraint(equalToConstant: root.frame.width * 0.25)
        let dConst = lbls[1].topAnchor.constraint(equalTo: lbls[0].bottomAnchor, constant: 16)
        let dFConst = vals[1].topAnchor.constraint(equalTo: vals[1].bottomAnchor, constant: 16)
        constr.isActive = true
//        dConst.isActive = true
//        dFConst.isActive = true
        
        for i in 0...lbls.count - 1 {
            lbls[i].translatesAutoresizingMaskIntoConstraints = false
            let constr = lbls[i].trailingAnchor.constraint(equalTo: lbls[0].trailingAnchor)
            constr.isActive = true
        }
        
//        TextField Constraints
        for i in 0...vals.count - 1 {
            vals[i].setContentHuggingPriority(.defaultLow, for: .horizontal)
        }
        
//        Full Detail Section Constraints
        detailSecView.translatesAutoresizingMaskIntoConstraints = false
        let tConst = detailSecView.topAnchor.constraint(equalTo: headerSecView.bottomAnchor, constant: 64)
        let lConst = detailSecView.leadingAnchor.constraint(equalTo: root.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        let trConst = detailSecView.trailingAnchor.constraint(equalTo: root.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        tConst.isActive = true
        lConst.isActive = true
        trConst.isActive = true
    }
    
//    Button Section Constraints
    func setButtonSecConstraints() {
        buttonSecView.translatesAutoresizingMaskIntoConstraints = false
        let tConst = buttonSecView.topAnchor.constraint(equalTo: detailSecView.bottomAnchor, constant: 16)
        let trConst = buttonSecView.trailingAnchor.constraint(equalTo: root.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        tConst.isActive = true
        trConst.isActive = true
    }
    
//    Status Section Constraints
    func setClaimStatConstraints() {
        claimStatSecView.translatesAutoresizingMaskIntoConstraints = false
        let tConst = claimStatSecView.topAnchor.constraint(equalTo: buttonSecView.bottomAnchor, constant: 16)
        let lConst = claimStatSecView.leadingAnchor.constraint(equalTo: root.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        let trConst = claimStatSecView.trailingAnchor.constraint(equalTo: root.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        tConst.isActive = true
        lConst.isActive = true
        trConst.isActive = true
    }
    
//    Initialize Display and Constraints
    func generate() {
        headerSecView = HeaderSectionGenerator().generate()
        print("Header section created")
        detailSecView = ClaimDetailSectionGenerator().generate()
        print("Detail section created")
        buttonSecView = buttonSectionGenerator().generate()
        print("Button section generated")
        claimStatSecView = ClaimStatusSectionGenerator().generate()
        print("Claim status section generated")
        root.addSubview(headerSecView)
        root.addSubview(detailSecView)
        root.addSubview(buttonSecView)
        root.addSubview(claimStatSecView)
        
        setViewReference()
        print("setViewReference() called")
        
        setHeaderSecConstraints()
        print("setHeaderSecConstraints() called")
        
        setDetailSecConstraints()
        print("setDetailSecConstraints() called")
        
        setButtonSecConstraints()
        print("setButtonSecConstraints() called")
        
        setClaimStatConstraints()
        print("setClaimStatConstraints() called")
    }
}
