//
//  NewPostViewController.swift
//  NIBM-App
//
//  Created by Bagya Hennayake on 11/10/19.
//  Copyright © 2019 Bagya Hennayake. All rights reserved.
//


import UIKit
import FirebaseStorage
import FirebaseDatabase
import SwiftyJSON


class NewPostViewController: UIViewController {
    
    
    var imagePicker: ImagePicker!
    @IBOutlet weak var ProfilePic_img: UIImageView!
    var avatarImageUrl: String!
    @IBOutlet weak var PostName_txt: UITextField!
    @IBOutlet weak var GetImage: UIImageView!
     var username: String!
    @IBOutlet weak var PostDescription_txt: UITextField!
    @IBAction func UploadImage(_ sender: UIButton) {
    self.imagePicker.present(from: sender)
    }
    @IBAction func Upload_btn(_ sender: Any) {
       
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
            self.username = json["First_Name"].stringValue
            
            
            
        })
        
        guard let Postname = PostName_txt.text, !Postname.isEmpty else {
            alert.dismiss(animated: false, completion: nil)
            showAlert(message: "Title cannot be empty")
            return
        }
        
        guard let description = PostDescription_txt.text, !description.isEmpty else {
            alert.dismiss(animated: false, completion: nil)
            showAlert(message: "Description cannot be empty")
            return
        }
        
        
        
        
        guard let image = GetImage.image,
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
                
                
                let dbRef = Database.database().reference().child("Posts").child("allPosts").childByAutoId()
                
                
                let data = [
                   "Postname" : Postname,
                    "description" : description,
                   "imageUrl" : imgUrl,
                    "userUID" : loggedUserUID,
                 "userAvatarImageUrl" : self.avatarImageUrl,
                    "PostUserName" : self.username
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
        }}

    
    func showAlert(message:String)
    {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    



    override func viewDidLoad() {
        
       
              super.viewDidLoad()
        
//        
//        ProfilePic_img.layer.cornerRadius = ProfilePic_img.frame.size.width/2
//        ProfilePic_img.layer.cornerRadius = ProfilePic_img.frame.size.height/2
//        ProfilePic_img.clipsToBounds = true
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
            
           // self.FisrtName_txt.text = json["First_Name"].stringValue
           // self.LastName_txt.text = json["Last_Name"].stringValue
            //self.txtDOB.text = json["DOB"].stringValue
           // self.PhoneNum_txt.text = json["Phone_Number"].stringValue
            
            
        })
        // Do any additional setup after loading the view.
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



extension NewPostViewController: ImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
        self.GetImage.image = image
    }
}
