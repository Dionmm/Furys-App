//
//  BasketTableViewCell.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 10/05/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import UIKit

class BasketTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var drink: Drink!{
        didSet{
            updateUI()
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    private func updateUI(){
        //Grab Anyobject price, convert to double and format to 2 decimal places
//        let drinkPrice = String(format: "%.2f", drink.price)
        nameLabel?.text = drink.name
        quantityLabel?.text = ""
    }
    
}
