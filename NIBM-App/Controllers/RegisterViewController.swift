//
//  RegisterViewController.swift
//  NIBM-App
//
//  Created by Bagya Hennayake on 11/9/19.
//  Copyright © 2019 Bagya Hennayake. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var RegEmail_txt: UITextField!
    
    @IBOutlet weak var RegPass_txt: UITextField!
    @IBOutlet weak var RegRepass_txt: UITextField!
    func showAlert(message:String)
    {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func Regbtn(_ sender: Any)
    {
        if ((RegEmail_txt.text?.isEmpty)! || (RegPass_txt.text?.isEmpty)!)
        {
            self.showAlert(message: "All fields are mandatory!")
            return
        } else {
            if RegPass_txt.text == RegRepass_txt.text{
                Auth.auth().createUser(withEmail: RegEmail_txt.text!, password: RegPass_txt.text!)
                {
                    (authResult, error) in
                    print("authResult ", authResult)
                    if ((error == nil)) {
                        
                        self.showAlert(message: "Signup Successfully!")
                        let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "loginstroyId")
                        self.present(vc, animated: true, completion: nil)
                      
                        
                    } else {
                        self.showAlert(message: (error?.localizedDescription)!)
                    }
                    
                    
                    
                }
            }
            else {
                
                self.showAlert(message: "Passwords don't match")
                
                
            }
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
}
