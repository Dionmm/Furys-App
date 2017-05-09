//
//  BeerTableViewController.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 31/03/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import UIKit

class BeerTableViewController: UITableViewController {

    private var drinks = [Drink]()
    
    //Pull this out in own file so it's global
    enum beverageType {
        case beer
        case spirit
    }
    
    var beverageTypeSelected: beverageType = .beer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let brain = APIBrain()
        
        func alert(){
            let alert = UIAlertController(title: "Couldn't load drinks", message: "Please try again", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        func reload(){
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        if beverageTypeSelected == .beer{
            brain.getDrinks(beverageType: "beer"){ data, responseCode in
                if data != nil{
                    self.drinks = data!
                    reload()
                } else{
                    alert()
                }
            }
        } else if beverageTypeSelected == .spirit{
            brain.getDrinks(beverageType: "spirit"){ data, responseCode in
                if data != nil{
                    self.drinks = data!
                    reload()
                } else{
                    alert()
                }
            }
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return drinks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Drink", for: indexPath)
        // Configure the cell...
        let drink = drinks[indexPath.row]
        if let drinkCell = cell as? DrinksTableViewCell{
            drinkCell.drink = drink
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
