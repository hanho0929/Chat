//
//  MystoryTableViewController.swift
//  Chat
//
//  Created by hanho on 10/17/18.
//  Copyright © 2018 hanho. All rights reserved.
//

import UIKit
import RealmSwift

class MystoryTableViewController: SwipeTableViewController {

    let realm = try! Realm() // inital realm
    
    var toReadStories: Results<Story>?
    
    var selectedCategory : Category? {
        didSet{
            loadStory()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - TableView DataSource Method.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toReadStories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell", for: indexPath)
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let story = toReadStories?[indexPath.row] {
            cell.textLabel?.text = story.title
            cell.accessoryType = story.read ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Story Added"
        }
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //story[indexPath.row].done = !story[indexPath.row].done
        if let story = toReadStories?[indexPath.row] {
            do {
                try realm.write {
                    story.read = !story.read
                }
            } catch {
                print("Error saving read status, \(error)")
            }
        }

        tableView.reloadData()
        tableView.deselectRow(at:indexPath, animated: true) // fade away the gray color after pointing
    }

    
    
    // MARK: - Add New Story
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textfield = UITextField()
        
        let alert = UIAlertController(title: "Add New Story", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let newStory = Story()
                        newStory.title = textfield.text!
                        newStory.dateCreated = Date()
                        currentCategory.stories.append(newStory)
                    }
                } catch {
                    print("Error saving new story \(error)")
                }
            }
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create New Story Name"
            textfield = alertTextfield
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Data Manipulation Methods.

    func loadStory(){ // default value if u didnt pass parameter
        toReadStories = selectedCategory?.stories.sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
    
    
    override func updateModel(at indexPath: IndexPath) {
        if let storyForDeleted = toReadStories?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(storyForDeleted)
                }
            } catch {
                print("Error deleting the story, \(error)")
            }
        }
    }
}
