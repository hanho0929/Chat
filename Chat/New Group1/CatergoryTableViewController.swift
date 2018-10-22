//
//  CatergoryTableViewController.swift
//  Chat
//
//  Created by hanho on 10/18/18.
//  Copyright © 2018 hanho. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

class CatergoryTableViewController: SwipeTableViewController {
    
    
    let realm = try! Realm() // inital realm data base
    
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    // MARK: - TableView Datasource Methods.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Category Added yet"
        
        cell.backgroundColor = UIColor(hexString: categories?[indexPath.row].color ?? "76D6FF")
        return cell
    }
    
    
    // MARK: - TableView Delegate Methods.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToStory", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToStory" {
            let destinationVC = segue.destination as! MystoryTableViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories?[indexPath.row]
            }
        }
    }
    
    // MARK: - Add New Categories.
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textfield.text!
            newCategory.color = UIColor.randomFlat().hexValue()
            self.save(category: newCategory)
        }
        
        alert.addAction(action)
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create New Category"
            textfield = alertTextfield
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Data Manipulation Methods.
    func save(category: Category){
        
        do {
            try realm.write { // commit change in realm database
                realm.add(category)
            }
        } catch {
            print("Error saving context : \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    
    
    func loadCategories(){
        categories = realm.objects(Category.self)
        tableView.reloadData()
    }
    
    
    override func updateModel(at indexPath: IndexPath) {
        if let categoryForDeleted = categories?[indexPath.row] {
            do {
                try realm.write {
                    realm.delete(categoryForDeleted)
                }
            } catch {
                print("Error deleting the category, \(error)")
            }
        }
    }


}
