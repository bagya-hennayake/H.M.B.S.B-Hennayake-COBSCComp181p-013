//
//  UserLoginPageViewController.swift
//  NIBM-App
//
//  Created by Bagya Hennayake on 11/9/19.
//  Copyright © 2019 Bagya Hennayake. All rights reserved.
//


import UIKit
import Firebase
import FirebaseAuth
//import GoogleSignIn
class UserLoginPageViewController: UIViewController {

    var window: UIWindow?
    
    @IBOutlet weak var LoginEmail_txt: UITextField!
    @IBOutlet weak var LoginPass_txt: UITextField!
    @IBAction func Login_btn(_ sender: Any)
    {
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
       
        
        
        Auth.auth().signIn(withEmail: LoginEmail_txt.text!, password: LoginPass_txt.text!) { (user, error) in
            
            if(error == nil)
            {
                var user_email:String?
                var UID: String?
                if let user = user {
                    _ = user.user.displayName
                    user_email = user.user.email
                    UID = user.user.uid
                    print("eeeeeeeeeee\(user_email!)")
                }
                
                //self.showAlert(message: "SignIn Successfully! Email: \(user_email!)")
                UserDefaults.standard.set(user_email, forKey: "LoggedUser")
                UserDefaults.standard.set(UID, forKey: "UserUID")
                UserDefaults.standard.set(true, forKey: "LoggedIn")
                UserDefaults.standard.synchronize()
                alert.dismiss(animated: false, completion: nil)
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
                self.present(vc, animated: true, completion: nil)
                
                
                
                
              
                
            }
            else{
                if let errorCode = AuthErrorCode(rawValue: error!._code) {
                    switch errorCode {
                    case.wrongPassword:
                        alert.dismiss(animated: false, completion: nil)
                        self.showAlert(message: "You entered an invalid password please try again!")
                        break
                    case.userNotFound:
                        alert.dismiss(animated: false, completion: nil)
                        self.showAlert(message: "There is no matching account with that email")
                        break
                    default:
                        alert.dismiss(animated: false, completion: nil)
                        self.showAlert(message: "Unexpected error \(errorCode.rawValue) please try again!")
                        print("Creating user error \(error.debugDescription)!")
                    }
                }
            }
        }
    }
    @IBOutlet weak var GoogleSign: UIView!
    func showAlert(message:String)
    {
        
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

      
    }
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//          // ...
//          if let error = error {
//              // ...
//              print(error)
//              return
//          }
//          
//          guard let authentication = user.authentication else { return }
//          let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                         accessToken: authentication.accessToken)
//          Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//              if let error = error {
//                  print(error)
//                  let alert = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle:.alert)
//                  alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                  self.present(alert, animated: true, completion: nil)
//                  // ...
//                  return
//              }
//              // User is signed in
//              // ...
//              self.dismiss(animated: true, completion: nil)
//              print(authResult!.user.email!)
//          }
//          // ...
//      }
//      
//      func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
//          // Perform any operations when the user disconnects from app here.
//          // ...
//      }
      
     
    @IBAction func Forgot_passward_btn(_ sender: Any) {
        
        Auth.auth().sendPasswordReset(withEmail: LoginEmail_txt.text!) { error in
            if self.LoginEmail_txt.text?.isEmpty==true{
                let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(resetFailedAlert, animated: true, completion: nil)
            }
            if error != nil && self.LoginEmail_txt.text?.isEmpty==false{
                let resetEmailAlertSent = UIAlertController(title: "Reset Email Sent", message: "Reset email has been sent to your login email, please follow the instructions in the mail to reset your password", preferredStyle: .alert)
                resetEmailAlertSent.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(resetEmailAlertSent, animated: true, completion: nil)
            }
        }

    }
    
    
    
      @IBAction func createAccount(_ sender: Any) {
      }
      


}
