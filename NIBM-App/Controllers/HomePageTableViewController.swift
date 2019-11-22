//
//  HomePageTableViewController.swift
//  NIBM-App
//
//  Created by Bagya Hennayake on 11/13/19.
//  Copyright © 2019 Bagya Hennayake. All rights reserved.
//
import UIKit
import FirebaseStorage
import FirebaseDatabase
import SwiftyJSON
import FirebaseAuth

class HomePageTableViewController: UITableViewController {
     var UID: String?
    var PostsId = [String]()
      var items = [JSON](){
          didSet{
              tableView.reloadData()
          }
      }
    //var user : String?
    var userid : String?
    override func viewDidLoad() {
        super.viewDidLoad()


       
             tableView.register(UINib(nibName: "PostViewTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "PostViewTableViewCell")
        

      
    
   
        
         let ref = Database.database().reference().child("Posts")
          ref.observe(.value, with: { snapshot in
              self.items.removeAll()
              self.PostsId.removeAll()
              let dict = snapshot.value as? [String: AnyObject]
              let json = JSON(dict as Any)

              for object in json["allPosts"]{
                  self.PostsId.append(object.0)
                  self.items.append(object.1)
                //print(object.1)
                //print(self.items)
              }
          })
     
        
    }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return items.count
        }
        
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 580
        }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostViewTableViewCell", for: indexPath) as! PostViewTableViewCell

        cell.Post_title_txt.text = items[indexPath.row]["Postname"].stringValue
        cell.Post_desc_txt.text = items[indexPath.row]["description"].stringValue
      
       
        cell.UserName_lbl.text = items[indexPath.row]["PostUserName"].stringValue
        
        let imageURL = URL(string: items[indexPath.row]["imageUrl"].stringValue)
        cell.Post_img.kf.setImage(with: imageURL)

        let avatarImageURL = URL(string: items[indexPath.row]["userAvatarImageUrl"].stringValue)
     //   cell.pro_img.kf.setImage(with: avatarImageURL, for: .normal)
      //  cell.pro_img.kf.setBackgroundImage(with: avatarImageURL, for: .normal)
        cell.pro_img.kf.setImage(with: avatarImageURL)
       
          cell.User = items[indexPath.row]["userUID"].stringValue
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
       {
           let loggedUserUid = UserDefaults.standard.string(forKey: "UserUID")
           let tempUID = items[indexPath.row]["userUID"].stringValue
           if loggedUserUid == tempUID{

            
          let vc = UpdatePostViewController(nibName: "UpdatePostViewController", bundle: nil)
              navigationController?.pushViewController(vc, animated: true)
            vc.article = items[indexPath.row]
             vc.articleID = PostsId[indexPath.row]
            print("edit post")
           }
           else{
               let vc = ViewPostViewController(nibName: "ViewPostViewController", bundle: nil)
               navigationController?.pushViewController(vc, animated: true)
             vc.article = items[indexPath.row]
            print("view post")

           }
           
       }

   

    func showAlert(message:String)
    {
        
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    
    func nothingToShow(){
        let lable = UILabel(frame: .zero)
        lable.textColor = UIColor.darkGray
        lable.numberOfLines = 0
        lable.text = "Oops, /n No articles to show"
        lable.textAlignment = .center
        tableView.separatorStyle = .none
        tableView.backgroundView = lable
    }
}
extension HomePageTableViewController : PostTableViewCellDelegate {
    
    
    func avatarTableViewCell(_ PostViewTableViewCell: PostViewTableViewCell, avatarButtonTappedFor user: String) {
        
        let vc = UserViewViewController(nibName: "UserViewViewController", bundle: nil)
        vc.UID = user
        print(user)
        navigationController?.pushViewController(vc, animated: true)
    }

    
        
}
