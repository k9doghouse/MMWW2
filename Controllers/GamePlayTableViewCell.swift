//  https://github.com/k9doghouse/MMWW2.git
//  GamePlayTableViewCell.swift
//  MMWW2
//
//  2018 k9doghouse
//

import UIKit

class GamePlayTableViewCell : UITableViewCell
{
    @IBOutlet weak var cellGuessLabel: UILabel!
    @IBOutlet weak var cellResultLabel: UILabel!
    @IBOutlet weak var cellCountLabel: UILabel!

    override func awakeFromNib()
    { super.awakeFromNib() }
}

extension UITableViewCell
{
    public func replaceContentViewSubviewsWith(_ view: UIView,
                                               minHeight: CGFloat = 24,
                                               margin: CGFloat = 4)

    { self.contentView.subviews.forEach
        { $0.removeFromSuperview() }

        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: margin),
            view.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -margin),
            view.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            view.heightAnchor.constraint(greaterThanOrEqualToConstant: minHeight),
            ])
    }
}
