//
//  ViewPostViewController.swift
//  NIBM-App
//
//  Created by Bagya Hennayake on 11/14/19.
//  Copyright © 2019 Bagya Hennayake. All rights reserved.
//


import UIKit
import SwiftyJSON
import FirebaseDatabase
import Kingfisher
import FirebaseStorage

class ViewPostViewController: UIViewController {

    @IBOutlet weak var prof_pic: UIButton!
    @IBOutlet weak var Post_img: UIImageView!
    @IBOutlet weak var PostTitle_txt: UILabel!
    @IBOutlet weak var PostDesc_txt: UILabel!
    @IBOutlet weak var User_name_txt: UILabel!
    @IBOutlet weak var User_img: UIImageView!
    
      var article: JSON?
    override func viewDidLoad()
   
    {   super.viewDidLoad()
           self.prof_pic.layer.cornerRadius = self.prof_pic.bounds.height / 2
                 self.prof_pic.clipsToBounds = true
      

PostTitle_txt.text = article!["Postname"].stringValue
     PostDesc_txt.text = article!["description"].stringValue

      let imageURL = URL(string: article!["imageUrl"].stringValue)
      Post_img.kf.setImage(with: imageURL)

      let avatarURL = URL(string: article!["userAvatarImageUrl"].stringValue)
      prof_pic.kf.setImage(with: avatarURL, for: .normal)
      prof_pic.kf.setBackgroundImage(with: avatarURL, for: .normal)
        User_name_txt.text = article!["PostUserName"].stringValue
    }
    
    @IBAction func Prof_avatar_click(_ sender: Any) {
    
    print ("xxx")
    let vc = UserViewViewController(nibName: "UserViewViewController", bundle: nil)
           vc.UID = article!["userUID"].stringValue
           
           navigationController?.pushViewController(vc, animated: true)
}
}
 
    

