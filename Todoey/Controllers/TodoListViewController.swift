//
//  ViewController.swift
//  Todoey
//
//  Created by Himanshu.Yadav1 on 30/07/18.
//  Copyright © 2018 Himanshu.Yadav1. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    // let defaults = UserDefaults.standard // an interface to user defaults database where you store key-value pairs peristently across
                                         //launches of app
    let dataFilePath=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //  Do any additional setup after loading the view, typically from a nib.
        
        print(dataFilePath)
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]
//
//        {   itemArray = items
//         }
    
   
        loadData()
        
    }

  //MARK- Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell=tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
       // let cell=UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
       
        let item = itemArray[indexPath.row]   //renaming shortcut
        cell.textLabel?.text=item.title
        
        cell.accessoryType = item.done ? .checkmark: .none
        
       
        
        
        
        return cell
    }
    
    //MARK- Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(itemArray[indexPath.row])
        
    //    if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
      //      tableView.cellForRow(at: indexPath)?.accessoryType = .none
      //  }else{
        //    tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        // }
        
     itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        tableView.reloadData()
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK- Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField=UITextField()
        
    let alert=UIAlertController(title: "Add New Todoey Item", message: " ", preferredStyle: .alert)
        
        
        let action=UIAlertAction(title: "Add Item", style: .default) { (action) in
            //what will happen when user clicks add item button
            
         //   print("Success!")
          //  print(textField.text)
            
            let newItem=Item()
            newItem.title=textField.text!
            
            self.itemArray.append(newItem)
          //  self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.saveItems()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create New Item"
            textField=alertTextField
            
            
        }
        
        alert.addAction(action)
       present(alert,animated: true,completion: nil)   //show the alert
        
        
    }
    
    //MARK- model Manipulation Methods
    
    func saveItems(){
        let encoder=PropertyListEncoder()
        do{
            let data=try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        }catch{
            print("Error encoding item array,\(error)")
        }
        tableView.reloadData()
    }   // Function saveItems closing
    
    
    func loadData(){
        
        if let data=try? Data(contentsOf: dataFilePath!)
        {  let decoder=PropertyListDecoder()
        do{
            itemArray=try decoder.decode([Item].self, from: data)
        }catch{
            print("Error decoding item array,\(error)")
        }
        
        }
        
    }
    
}
    
   




