//
//  AccountViewController.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 12/04/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LogOutButton(_ sender: UIButton) {
        let brain = APIBrain()
        brain.logoutUser()
        let next = self.storyboard?.instantiateViewController(withIdentifier: "InitialNavigation")
        self.present(next!, animated: true, completion: nil)
    }
    
}
