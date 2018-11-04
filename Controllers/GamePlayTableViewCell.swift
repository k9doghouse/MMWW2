//  https://github.com/k9doghouse/MMWW2.git
//  GamePlayTableViewCell.swift
//  MMWW2
//
//  2018 k9doghouse
//

import UIKit

class GamePlayTableViewCell: UITableViewCell
{
    @IBOutlet weak var cellGuessLabel: UILabel!
    @IBOutlet weak var cellResultLabel: UILabel!
    @IBOutlet weak var cellCountLabel: RoundedLabel!
    
    override func awakeFromNib()
    { super.awakeFromNib() }
}
