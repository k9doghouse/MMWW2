//
//  UILabelPads.swift
//  MMWW2
//
//  Created by murph on 11/10/18.
//  Copyright © 2018 k9doghouse. All rights reserved.
//

import Foundation
import UIKit

public class UILabelPads : UILabel
{
    @IBInspectable var topInset: CGFloat = 4.0
    @IBInspectable var bottomInset: CGFloat = 4.0
    @IBInspectable var leftInset: CGFloat = 10.0
    @IBInspectable var rightInset: CGFloat = 10.0

    public override func drawText(in rect: CGRect)
    {
        let insets = UIEdgeInsets.init(top: topInset,
                                       left: leftInset,
                                       bottom: bottomInset,
                                       right: rightInset)

        super.drawText(in: rect.inset(by: insets))
    }

    public override var intrinsicContentSize: CGSize
    {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    public override func sizeToFit()
    { super.sizeThatFits(intrinsicContentSize) }

    override public func layoutSubviews()
    {
        super.layoutSubviews()
        updateCornerRadiusRL()
    }

    var rounded : Bool = true
    {
        didSet
        {
            updateCornerRadiusRL()
        }
    }

    func updateCornerRadiusRL()
    { layer.cornerRadius = rounded ? frame.size.height / 24 : 0 }
}
