//
//  CheckoutViewController.swift
//  FurysApp
//
//  Created by Dion MacIntyre on 09/05/2017.
//  Copyright © 2017 Dion MacIntyre. All rights reserved.
//

import UIKit
import Stripe

class CheckoutViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var paymentSucceeded = false
    
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
            }
        })
    }
    
    
    
    @IBAction func applePay(_ sender: UIButton) {
        let paymentRequest = Stripe.paymentRequest(withMerchantIdentifier: "merchant.com.Dionmm.FurysApp")
        paymentRequest.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "Vokda coke", amount: 5.00),
            PKPaymentSummaryItem(label: "Vokda Lemonade", amount: 5.00)
        ]
        if Stripe.canSubmitPaymentRequest(paymentRequest){
            let paymentAuthorisationVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
            paymentAuthorisationVC.delegate = self
            self.present(paymentAuthorisationVC, animated: true, completion: nil)
            
        }
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
