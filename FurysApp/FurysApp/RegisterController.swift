//
//  RegisterController.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 25/03/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var scrollView: UIScrollView!
    
    //Credit http://stackoverflow.com/questions/26689232/scrollview-and-keyboard-swift
    func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBAction func returnKeyPressed(_ sender: UITextField) {
        register(sender)
    }
    
    @IBAction func register(_ sender: Any) {
        let brain = APIBrain.shared
        if !(username.text?.isEmpty)! && !(email.text?.isEmpty)! && !(password.text?.isEmpty)! && (password.text! == confirmPassword.text!){
            brain.registerUser(username: username.text!, password: password.text!, email: email.text!){data, responseCode in
                
                DispatchQueue.main.async {
                    if responseCode == 200 {
                        let alert = UIAlertController(title: "Registered", message: "You've successfully registered, you may now login!", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {action in
                            let next = self.storyboard?.instantiateViewController(withIdentifier: "LoginController")
                            self.present(next!, animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                        
                        
                    } else{
                        let alert = UIAlertController(title: "Error", message: "Something went wrong, please try again", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
        } else{
            print("No Text")
        }
    }
    
}
