//
//  UserViewViewController.swift
//  NIBM-App
//
//  Created by Bagya Hennayake on 11/19/19.
//  Copyright © 2019 Bagya Hennayake. All rights reserved.
//

import UIKit
import  FirebaseDatabase
import Kingfisher
import SwiftyJSON

class UserViewViewController: UIViewController {
    
    @IBOutlet weak var Phone_Num_txt: UITextField!
    @IBOutlet weak var Email_txt: UITextField!
    @IBOutlet weak var User_Name_txt: UITextField!
    @IBOutlet weak var prof_img: UIImageView!
    
    @IBOutlet weak var DOB_txt: UITextField!
    var UID: String?
    var LIKEHIT: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prof_img.layer.cornerRadius = self.prof_img.bounds.height / 2
        self.prof_img.clipsToBounds = true
        
      
        
            let ref = Database.database().reference().child("profiles").child(UID!)
                  ref.observe(.value, with: { snapshot in
                      
                      let dict = snapshot.value as? [String: AnyObject]
                      let json = JSON(dict as Any)
                      
            
            let imageURL = URL(string: json["profileImageUrl"].stringValue)
            self.prof_img.kf.setImage(with: imageURL)

           self.DOB_txt.text = json["DOB"].stringValue
          self.User_Name_txt.text = json["First_Name"].stringValue
          
       self.Phone_Num_txt.text = json["Phone_Number"].stringValue
           self.Email_txt.text = json["Email"].stringValue
            
            
            
        })
        
  print(UID)
        // Do any additional setup after loading the view.
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
