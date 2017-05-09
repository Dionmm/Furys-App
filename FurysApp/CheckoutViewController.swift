//
//  CheckoutViewController.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 09/05/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import UIKit
import Stripe

class CheckoutViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var paymentSucceeded = false
    var brain = APIBrain.shared
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController,
                                            didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        
        STPAPIClient.shared().createToken(with: payment) { (token, error) in
            //submit token
            if (error != nil) {
                completion(.failure)
            } else {
                self.paymentSucceeded = true
                completion(.success)
            }
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        self.dismiss(animated: true, completion: {
            //payemtn succeeded
            if (self.paymentSucceeded) {
                // show a receipt page
                let next = self.storyboard?.instantiateViewController(withIdentifier: "TrackOrder")
                self.present(next!, animated: true, completion: nil)
            }
        })
    }
    
    
    @IBOutlet weak var basketContentsTable: UITableView!
    
    @IBAction func applePay(_ sender: UIButton) {
        let x = self.parent as! FurysNavigationController
        
        print(x.brain.basket)
        let paymentRequest = Stripe.paymentRequest(withMerchantIdentifier: "merchant.com.Dionmm.FurysApp")
        paymentRequest.paymentSummaryItems = calcTotalCost()
        if Stripe.canSubmitPaymentRequest(paymentRequest){
            let paymentAuthorisationVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
            paymentAuthorisationVC.delegate = self
            self.present(paymentAuthorisationVC, animated: true, completion: nil)
            
        }
    }
    
    private func calcTotalCost() -> [PKPaymentSummaryItem]{
        var itemArray = [PKPaymentSummaryItem]()
        var totalCost = 0.0
        
        for drink in brain.basket{
            totalCost += drink.price
        }
        itemArray.append(PKPaymentSummaryItem(label: "Furys Ayr", amount: NSDecimalNumber(value: totalCost)))
        return itemArray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basketCell", for: indexPath)
//        // Configure the cell...
//        let drink = drinks[indexPath.row]
//        if let drinkCell = cell as? DrinksTableViewCell{
//            drinkCell.drink = drink
//            drinkCell.parentNavController = self.parent as! FurysNavigationController!
//        }
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "basketCell")
        return cell
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
