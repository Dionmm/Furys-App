//
//  DrinksTableViewCell.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 11/04/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import UIKit

class DrinksTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBOutlet weak var QuantityLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var DrinkNameLabel: UILabel!
    
    var drink: [String: Any]? {
    didSet{
        updateUI()
    }
    }
    
    @IBAction func UpdateCart(_ sender: UIButton) {
        if sender.currentTitle == "+" {
            print("add")
        } else{
            print("Subtract")
        }
    }
    
    private func updateUI(){
        print("UI Updated")
        DrinkNameLabel?.text = drink?["Name"] as! String?
        PriceLabel?.text = "£\(drink?["Price"]!)"
        QuantityLabel?.text = "0"
        
    }
    
}
