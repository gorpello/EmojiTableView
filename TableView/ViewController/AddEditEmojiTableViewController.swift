//
//  AddEditEmojiTableViewController.swift
//  TableView
//
//  Created by Gianluca Orpello on 10/06/21.
//

import UIKit

class AddEditEmojiTableViewController: UITableViewController {
    
    var emoji: Emoji?
    
    @IBOutlet weak var symbolTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var usageTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        if let emoji = emoji {
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            usageTextField.text = emoji.usage
            descriptionTextField.text = emoji.description
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SaveEmojiFromUnwind" else { return }
        
        emoji = Emoji(symbol: symbolTextField.text ?? "",
                          name: nameTextField.text ?? "",
                          description: descriptionTextField.text ?? "",
                          usage: usageTextField.text ?? "")
    }

}
