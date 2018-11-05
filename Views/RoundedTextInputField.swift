//
//  RoundedTextInputField.swift
//  MMWW2
//
//  Created by k9doghouse on 10oct2018.
//  Copyright © 2018 k9doghouse. All rights reserved.
//

import UIKit
 
class RoundedTextInputField : UITextField
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        updateCornerRadiusTF()
    }
    
    var rounded : Bool = true
    { didSet { updateCornerRadiusTF() } }

    func updateCornerRadiusTF()
    {
        layer.cornerRadius = rounded ? frame.size.height / 9 : 0
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
}

