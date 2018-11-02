//
//  RoundedTextInputField.swift
//  WordWink
//
//  Created by k9doghouse on 10oct2018.
//  Copyright © 2018 k9doghouse. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedTextInputField: UITextField
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
        layer.borderColor = #colorLiteral(red: 0.6344695144, green: 0.6991830822, blue: 0.6485863625, alpha: 1)
    }
} // end class RoundedTextInputField...

private var kAssociationKeyMaxLength: Int = 0

extension UITextField
{
    @IBInspectable var maxLength: Int
    {
    get { if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int
        { return length }
    else { return Int.max } }

    set { objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
        addTarget(self, action: #selector(checkMaxLength), for: .editingChanged) }
    }


    @objc func checkMaxLength(textField: UITextField)
    {
        guard let prospectiveText = self.text, prospectiveText.count > maxLength
        else
        { return }

        let selection = selectedTextRange

        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        selectedTextRange = selection
    }
}
