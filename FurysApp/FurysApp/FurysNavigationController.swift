//
//  FurysNavigationController.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 28/03/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import UIKit

class FurysNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UIApplication.shared.statusBarStyle = .lightContent
        let furysColour = UIColor(red: 51/255.0, green: 54/255.0, blue: 63/255.0, alpha: 1)
        self.navigationBar.barTintColor = furysColour
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.isTranslucent = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return UIInterfaceOrientationMask.portrait
    }
    
    open override var shouldAutorotate: Bool{
        return false
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
