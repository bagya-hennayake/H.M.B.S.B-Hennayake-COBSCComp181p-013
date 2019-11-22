//
//  ProfileViewAuthenticationViewController.swift
//  NIBM-App
//
//  Created by Bagya Hennayake on 11/14/19.
//  Copyright © 2019 Bagya Hennayake. All rights reserved.
//

import UIKit


import Firebase
import FirebaseAuth
//import BiometricAuthentication
class ProfileViewAuthenticationViewController: UIViewController {
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
}
//    func touchIdLoginAction(){
//        IDTouch.authenticateUser(){ [weak self] message in
//            if let message = message {
//                let alertView = UIAlertController(title: "Authentication Error", message: message, preferredStyle: .alert)
//
//                let okAction = UIAlertAction(title: "Ok", style: .default, handler: {(action:UIAlertAction!) in
//                    print("Try again")
//                })
//
//                alertView.addAction(okAction)
//                self!.present(alertView, animated: true)
//            }else{
//                AppTempData.userData = Auth.auth().addStateDidChangeListener{(auth, user) in
//                    if user == nil{
//                        //self!.performSegue(withIdentifier: "ShowLogin", sender: nil)
//
//
//                    }else{
//                        print("vyggyh")
//                        self!.performSegue(withIdentifier: "authPath", sender: nil)
//                    }
//
//                }
//
//            }
//
//        }
//    }
//
//    @IBAction func ViewProf(_ sender: Any) {
//        touchIdLoginAction()
//    }
    


