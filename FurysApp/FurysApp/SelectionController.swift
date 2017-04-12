//
//  SelectionController.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 28/03/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import UIKit

class SelectionController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //beerButton.roundedButton()
        //spiritButton.roundedButton()
        //addImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var beerButton: HalfCircleButton!
    @IBOutlet weak var spiritButton: HalfCircleButton!
    
    
    func addImage(){
        //Crap workaround to get background images showing with aspect scaling
        let bgImage1 = UIImageView(frame: beerButton.bounds)
        let bgImage2 = UIImageView(frame: spiritButton.bounds)
        let image1 = UIImage(named: "beerPic")
        let image2 = UIImage(named: "spiritPic")
        
        bgImage1.image = image1
        bgImage1.contentMode = .scaleAspectFill
        beerButton.insertSubview(bgImage1, at: 0)
        bgImage2.image = image2
        bgImage2.contentMode = .scaleAspectFill
        spiritButton.insertSubview(bgImage2, at: 0)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextView = segue.destination as! BeerTableViewController
        if segue.identifier == "Beer"{
            nextView.beverageTypeSelected = .beer
        } else if segue.identifier == "Spirit"{
            nextView.beverageTypeSelected = .spirit
        }
    }
    
}
