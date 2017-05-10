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
    
    var drink: Drink!{
        didSet{
            updateUI()
        }
    }
    
    var quantity = 0
    
    private var brain = APIBrain.shared
    
    @IBAction func updateCart(_ sender: UIButton) {
        var updateMethod = String()
        if sender.currentTitle == "+" {
            updateMethod = "add"
            self.quantity += 1
            
        } else{
            updateMethod = "remove"
            self.quantity -= 1
        }
        updateQuantityLabel(with: quantity)
        brain.updateCart(method: updateMethod, with: drink){ result in
            print(result)
        }
    }
    
    private func updateUI(){
        //Grab Anyobject price, convert to double and format to 2 decimal places
        let drinkPrice = String(format: "%.2f", drink.price)
        DrinkNameLabel?.text = drink.name
        PriceLabel?.text = "£\(drinkPrice)"
        QuantityLabel?.text = ""
        updateQuantityLabel(with: quantity)
    }
    
    func updateQuantityLabel(with value: Int){
        
        QuantityLabel?.text = "\(value)"
    }
}
