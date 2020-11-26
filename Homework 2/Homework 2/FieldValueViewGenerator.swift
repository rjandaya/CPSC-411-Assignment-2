//
//  FieldValueGenerator.swift
//  Homework 2
//
//  Created by RJ Andaya on 11/24/20.
//

import Foundation
import UIKit

class FieldValueViewGenerator {
    var lblName: String!
    var fieldValue: String!
    
    init(n: String, f: String) {
        lblName = n
        fieldValue = f
    }
    
    init(n: String) {
        lblName = n
    }
    
    func generate() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        
        let lbl = UILabel()
        lbl.text = lblName
        lbl.sizeToFit()
        stackView.addArrangedSubview(lbl)
        
        let val = UITextField()
        val.placeholder = fieldValue
        val.text = ""
        val.borderStyle = .roundedRect
        stackView.addArrangedSubview(val)
        
        return stackView
    }
}
