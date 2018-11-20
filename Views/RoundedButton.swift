//
//  RoundedButton.swift
//  MMWW2
//
//  Created by murph on 9/21/18.
//  Copyright © 2018 k9doghouse. All rights reserved.
//

import UIKit

@IBDesignable
public class RoundedButton : UIButton
{
    override public func layoutSubviews()
    {
        super.layoutSubviews()
        updateCornerRadiusAndBorder()
    }

    var rounded : Bool = true
        { didSet { updateCornerRadiusAndBorder() } }

    func updateCornerRadiusAndBorder()
    { layer.cornerRadius = rounded ? frame.size.height / 8 : 0
      layer.borderWidth = 2
      layer.borderColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
    }
}
