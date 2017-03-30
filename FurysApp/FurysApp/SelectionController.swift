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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var circleView: CircleView!
    
    private var rightHalf = UIBezierPath()
    private var leftHalf = UIBezierPath()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(circleView.viewDrawn){
            leftHalf = circleView.leftHalf
            rightHalf = circleView.rightHalf
            circleView.viewDrawn = false
        }
        for touch in touches{
            let location = touch.location(in: view)
            if(rightHalf.contains(location)){
                print("Tap right")
                let next = self.storyboard?.instantiateInitialViewController()
                self.present(next!, animated: true, completion: nil)
                
            } else if(leftHalf.contains(location)){
                print("Tap left")
                let next = self.storyboard?.instantiateViewController(withIdentifier: "SpiritView")
                self.present(next!, animated: true, completion: nil)
            }
        }
    }
}
