//
//  ViewController.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 21/03/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loginButton.layer.cornerRadius = 4
    }
    override func viewDidAppear(_ animated: Bool) {
        let userLoggedIn = APIBrain().userLoggedIn
        if userLoggedIn{
            print("Logged In")
            let next = self.storyboard?.instantiateViewController(withIdentifier: "MainTabController")
            self.present(next!, animated: true, completion: nil)
        } else{
            print("No username")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func temp(_ sender: Any) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "MainTabController")
        self.present(next!, animated: true, completion: nil)
    }
    @IBOutlet weak var loginButton: UIButton!
}

