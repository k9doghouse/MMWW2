//
//  RoundedUITextInputField.swift
//  MMWW2
//
//  Created by murph on 11/4/18.
//  Copyright © 2018 k9doghouse. All rights reserved.
//

import UIKit

class RoundedTextView: UITextView
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        updateCornerRadiusTV()
    }


    var rounded : Bool = true
    { didSet { updateCornerRadiusTV() } }


    func updateCornerRadiusTV()
    {
        layer.cornerRadius = rounded ? frame.size.height / 6 : 0
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.4980392157, green: 0.7607843137, blue: 0.7647058824, alpha: 1)
    }
}
