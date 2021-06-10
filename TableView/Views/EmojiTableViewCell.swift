//
//  EmojiTableViewCell.swift
//  TableView
//
//  Created by Gianluca Orpello on 10/06/21.
//

import UIKit

class EmojiTableViewCell: UITableViewCell {

    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    

    func updateUI(with emoji: Emoji)  {
        self.symbolLabel.text = emoji.symbol
        self.nameLabel.text = emoji.name
        self.descriptionLabel.text = emoji.description
    }

}
