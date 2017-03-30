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
        let defaults = UserDefaults.standard
        if let stringx = defaults.string(forKey: "Username"){
            print(stringx)
            
            
            //Get the expiry date in seconds since 1 Jan 2001 and compare with current date
            //in seconds from 1 Jan 2001, if < 45,000 (~12 hours) then consider token expired
            let expiryDate = defaults.double(forKey: "tokenExpiryDate")
            let currentDate = Double(Date().timeIntervalSinceReferenceDate)
            
            
            if(expiryDate - currentDate > 45000){
                let next = self.storyboard?.instantiateViewController(withIdentifier: "MainTabController")
                self.present(next!, animated: true, completion: nil)
            } else{
                //Delete stuff here
            }
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

