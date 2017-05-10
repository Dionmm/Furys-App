//
//  OrderTrackingViewController.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 09/05/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import UIKit
import SwiftR

class OrderTrackingViewController: UIViewController {

    private let brain = APIBrain.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let connection = SignalR("https://api.furysayr.co.uk/")
        let orderHub = Hub("orderHub")

        orderHub.on("orderComplete"){ data in
            print("order Complete")
            print(data!)
        }
        orderHub.on("error"){data in
            print(data!)
        }
        orderHub.on("userConnected"){ data in
            print(data!)
            
        }
        
        connection.queryString = ["bearerToken": brain.authToken]
        
        connection.addHub(orderHub)
        connection.starting = {
            print("starting")
        }
        connection.connected = {
            print("connected")
            do {
                try orderHub.invoke("newOrder", arguments: [String(describing: self.brain.orderId!)])
                print(self.brain.orderId!)
            } catch {
                print("bad")
            }
        }
        connection.error = { error in
            print("error")
            //print(error!)
            
        }
        connection.disconnected = {
            print("disconnected")
        }
        connection.start()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        do {
//            try orderHub.invoke("newOrder", arguments: [brain.orderId!])
//            print(brain.orderId!)
//        } catch {
//            print("bad")
//        }
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
