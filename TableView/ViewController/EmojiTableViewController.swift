//
//  EmojiTableViewController.swift
//  TableView
//
//  Created by Gianluca Orpello on 10/06/21.
//

import UIKit

class EmojiTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var emojiList: [Emoji] = [] {
        didSet {
            Emoji.saveToFile(emojiList)
        }
    }
        
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        if let savedEmoji = Emoji.loadFromFile() {
            emojiList = savedEmoji
        } else {
            emojiList = Emoji.semplesEmojis
        }
        
    }
    
    // Data Sources Func
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiList.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiTableViewCell", for: indexPath) as! EmojiTableViewCell
        
        let emoji = emojiList[indexPath.row]
        cell.updateUI(with: emoji)

        return cell
        
    }
    
    
    // Delegate Func
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete from emoji list
            emojiList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        } else {
          // .insert
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let emoji = emojiList.remove(at: sourceIndexPath.row)
        emojiList.insert(emoji, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // indexPath
        performSegue(withIdentifier: "EditEmoji", sender: emojiList[indexPath.row])
    }
    
    
    @IBAction func addNewEmoji(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "InsertNewEmoji", sender: nil)
    }
    
    
    @IBAction func editTableView(_ sender: UIBarButtonItem) {
        let isEditing = tableView.isEditing
        tableView.setEditing(!isEditing, animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController,
              let destination = navigationController.viewControllers.first as? AddEditEmojiTableViewController
        else { return }
        
        
        if segue.identifier == "InsertNewEmoji" {
            destination.navigationItem.title = "Insert Emoji"
        }else {
            destination.navigationItem.title = "Edit Emoji"
            if let emoji = sender as? Emoji{
                destination.emoji = emoji
            }
            
        }
    }
    
    
    @IBAction func unwindToEmojiTableView(_ segue: UIStoryboardSegue) {
        guard segue.identifier == "SaveEmojiFromUnwind",
              let sourceVC = segue.source as? AddEditEmojiTableViewController,
              let emoji = sourceVC.emoji else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojiList[selectedIndexPath.row] = emoji
            tableView.reloadData()
        }else{
            emojiList.insert(emoji, at: 0)
            
            let newIndexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
    }
    
    


}
