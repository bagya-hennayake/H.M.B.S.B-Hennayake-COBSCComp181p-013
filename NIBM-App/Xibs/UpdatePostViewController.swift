//
//  UpdatePostViewController.swift
//  NIBM-App
//
//  Created by Bagya Hennayake on 11/13/19.
//  Copyright © 2019 Bagya Hennayake. All rights reserved.
//


import UIKit
import SwiftyJSON
import FirebaseDatabase
import Kingfisher
import FirebaseStorage


class UpdatePostViewController: UIViewController {
    var imagePicker: ImagePicker!
      var avatarImageUrl: String!
      var article: JSON?
      var articleID: String?
   
    
  
    @IBOutlet weak var post_desc_txt: UITextField!
    @IBOutlet weak var Post_img: UIImageView!
  
    @IBOutlet weak var PostTitle_txt: UITextField!
    
    
    //@IBOutlet weak var Post_des_txt: UITextField!
    @IBAction func get_img_btn(_ sender: Any) {
        
        self.imagePicker.present(from: sender as! UIView)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)

        PostTitle_txt.text = article!["Postname"].stringValue
        post_desc_txt.text = article!["description"].stringValue
        
        let imageURL = URL(string: article!["imageUrl"].stringValue)
        Post_img.kf.setImage(with: imageURL)
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Save_btn(_ sender: Any) 
    
    {
        
        
           print ("click")
            let alert = UIAlertController(title: nil, message: "Posting", preferredStyle: .alert)
            
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating();
            
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
            
        
            let loggedUserUID = UserDefaults.standard.string(forKey: "UserUID")
            
            let avatarRef = Database.database().reference().child("profiles").child(loggedUserUID!)
            avatarRef.observe(.value, with: { snapshot in
                
                let dict = snapshot.value as? [String: AnyObject]
                let json = JSON(dict as Any)
                
                self.avatarImageUrl = json["profileImageUrl"].stringValue
                
                
                
            })
            
            guard let Postname = PostTitle_txt.text, !Postname.isEmpty else {
                alert.dismiss(animated: false, completion: nil)
                showAlert(message: "Title cannot be empty")
                return
            }
            
            guard let description = post_desc_txt.text, !description.isEmpty else {
                alert.dismiss(animated: false, completion: nil)
                showAlert(message: "Description cannot be empty")
                return
            }
            
            
            
            
            guard let image = Post_img.image,
                let imgData = image.jpegData(compressionQuality: 1.0) else {
                    alert.dismiss(animated: false, completion: nil)
                    showAlert(message: "An Image must be selected")
                    return
            }
            
            let imageName = UUID().uuidString

            let reference = Storage.storage().reference().child("profileImages").child(imageName)


            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"


            reference.putData(imgData, metadata: metaData) { (meta, err) in
                if let err = err {
                    alert.dismiss(animated: false, completion: nil)
                    self.showAlert(message: "Error uploading image: \(err.localizedDescription)")
                    return
                }

                reference.downloadURL { (url, err) in
                    if let err = err {
                        alert.dismiss(animated: false, completion: nil)
                        self.showAlert(message: "Error fetching url: \(err.localizedDescription)")
                        return
                    }

                    guard let url = url else {
                        alert.dismiss(animated: false, completion: nil)
                        self.showAlert(message: "Error getting url")
                        return
                    }

                    let imgUrl = url.absoluteString
            
                    //                let dbChildName = UUID().uuidString
                    
                    
                    let dbRef = Database.database().reference().child("Posts").child("allPosts").child(self.articleID!)
                    
                    
                    let data = [
                       "Postname" : Postname,
                        "description" : description,
                       "imageUrl" : imgUrl,
                        "userUID" : loggedUserUID,
                     "userAvatarImageUrl" : self.avatarImageUrl
                    ]
                    
                    dbRef.setValue(data, withCompletionBlock: { ( err , dbRef) in
                        if let err = err {
                            self.showAlert(message: "Error uploading data: \(err.localizedDescription)")
                            return
                        }
                        alert.dismiss(animated: false, completion: nil)
                        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBarController")
                        self.present(vc, animated: true, completion: nil)
                        
                        
                    })
                    
                }
            }
    
        }
    
 
    
    func showAlert(message:String)
     {
         let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
         alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
         self.present(alert, animated: true)
     }
}

extension UpdatePostViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.Post_img.image = image
    }
}



