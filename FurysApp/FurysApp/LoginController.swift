//
//  LoginController.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 28/03/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        self.errorLabel.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBAction func loginButton(_ sender: UIButton) {
        let x = APIBrain()
        if !(email.text?.isEmpty)! && !(password.text?.isEmpty)!{
            x.loginUser(username: email.text!, password: password.text!){ data, responseCode in
                //Cannot update UI on anything other than the main thread
                //this dispatches the queue and only updates on main thread
                DispatchQueue.main.async {
                    if responseCode == 200 {
                        //Moves the storyboard to the mainNavigation view which is the core part of the app once logged in
                        let next = self.storyboard?.instantiateViewController(withIdentifier: "MainNavigation")
                        self.present(next!, animated: true, completion: nil)
                    } else if responseCode == 400{
                        self.errorLabel.text = data["error_description"] as! String?
                    } else{
                        print("now")
                        self.errorLabel.text = data["error"] as! String?
                    }
                    let defaults = UserDefaults.standard
                    if let stringx = defaults.string(forKey: "Username"){
                        print(stringx)
                    }
                }
            }
        } else{
            print("No text")
        }

    }
}
