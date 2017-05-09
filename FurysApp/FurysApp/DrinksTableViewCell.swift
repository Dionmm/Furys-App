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
            drinkId = drink.id
        }
    }
    
    var drinkId: String?
    
    var parentNavController: FurysNavigationController!{
        didSet{
            brain = parentNavController.brain
        }
    }
    
    var brain = APIBrain.shared
    
    @IBAction func updateCart(_ sender: UIButton) {
        var updateMethod = String()
        if sender.currentTitle == "+" {
            updateMethod = "add"
        } else{
            updateMethod = "remove"
        }
        
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
    }
    
    func updateQuantityLabel(with value: Int){
        QuantityLabel?.text = "\(value)"
    }
}
