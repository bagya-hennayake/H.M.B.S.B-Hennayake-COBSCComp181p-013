//
//  MyProfileViewController.swift
//  NIBM-App
//
//  Created by Bagya Hennayake on 11/12/19.
//  Copyright © 2019 Bagya Hennayake. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import SwiftyJSON
import FirebaseAuth
class MyProfileViewController: UIViewController {
    var imagePicker: ImagePicker!
    var fname = ""
    var lname = ""
    var space = " "
    var logout : String? = "Log out "
    @IBOutlet weak var ProfilePic_img: UIImageView!
    @IBOutlet weak var Name_txt: UITextField!
    @IBOutlet weak var IndexId_txt: UITextField!
    @IBOutlet weak var DOB_txt: UITextField!
    
    @IBOutlet weak var Phone_txt: UITextField!
    
    @IBOutlet weak var Email_txt: UITextField!
    
 
    @IBOutlet weak var Logout_btn: UIButton!
    @IBAction func LogOutfunc(_ sender: Any) {
 
            UserDefaults.standard.removeObject(forKey: "LoggedUser")
            UserDefaults.standard.removeObject(forKey: "LoggedIn")
            UserDefaults.standard.removeObject(forKey: "UserUID")
            UserDefaults.standard.synchronize()
            let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "loginstroyId")
            self.present(vc, animated: true, completion: nil)
        }

    
    
    override func viewDidLoad() {
        
       
        
        super.viewDidLoad()
        
         self.ProfilePic_img.layer.cornerRadius = self.ProfilePic_img.bounds.height / 2
               self.ProfilePic_img.clipsToBounds = true

        
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
       
        
        let loggedUserUid = UserDefaults.standard.string(forKey: "UserUID")
        let ref = Database.database().reference().child("profiles").child(loggedUserUid!)
        ref.observe(.value, with: { snapshot in
            
            let dict = snapshot.value as? [String: AnyObject]
            let json = JSON(dict as Any)
            
            let imageURL = URL(string: json["profileImageUrl"].stringValue)
            self.ProfilePic_img.kf.setImage(with: imageURL)
            
            self.fname = json["First_Name"].stringValue
            self.lname = json["Last_Name"].stringValue
            self.DOB_txt.text = json["DOB"].stringValue
            self.Phone_txt.text = json["Phone_Number"].stringValue
             self.IndexId_txt.text = json["Index_ID"].stringValue
            self.Name_txt.text = self.fname + self.space +  self.lname

            self.Logout_btn.setTitle( self.logout, for: .normal)
      })
        
        // Do any additional setup after loading the view.
    
        let user = Auth.auth().currentUser
        if let user = user {   let uid = user.uid
            self.Email_txt.text = user.email
          
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension MyProfileViewController:
    ImagePickerDelegate {
        
        func didSelect(image: UIImage?) {
            self.ProfilePic_img.image = image
        }
    }

