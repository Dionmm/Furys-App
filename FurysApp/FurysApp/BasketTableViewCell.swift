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
//        self.frame.size.width = 374
        let whiteRoundedView = UIView(frame: CGRect(x: 10, y: 8, width: self.bounds.width - 10, height: self.bounds.height - 10))
        whiteRoundedView.layer.backgroundColor = UIColor.white.cgColor
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: 0, height: 0)
        whiteRoundedView.layer.shadowOpacity = 0.2
        self.contentView.addSubview(whiteRoundedView)
        self.contentView.sendSubview(toBack: whiteRoundedView)
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

    var quantity = 0
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    private func updateUI(){
        //Grab Anyobject price, convert to double and format to 2 decimal places
//        let drinkPrice = String(format: "%.2f", drink.price)
        nameLabel?.text = drink.name
        quantityLabel?.text = ""
        updateQuantityLabel(with: quantity)
        let drinkPrice = String(format: "%.2f", Double(quantity) * drink.price)
        priceLabel?.text = "£\(drinkPrice)"
    }
    
    func updateQuantityLabel(with value: Int){
        
        quantityLabel?.text = "x\(value)"
    }
    
}
