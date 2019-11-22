//
//  PostViewTableViewCell.swift
//  NIBM-App
//
//  Created by Bagya Hennayake on 11/13/19.
//  Copyright © 2019 Bagya Hennayake. All rights reserved.
//

import UIKit

class PostViewTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var Avatar_btn: UIButton!
    
    @IBOutlet weak var pro_img: UIImageView!
    @IBOutlet weak var Post_img: UIImageView!
    
    @IBOutlet weak var Post_title_txt: UITextView!
    @IBOutlet weak var Post_desc_txt: UITextView!
    
    @IBOutlet weak var Like_txt: UILabel!
  
    @IBOutlet weak var UserName_lbl: UILabel!
    // @IBOutlet weak var btn: UIButton!
    
  
    @IBOutlet weak var Name: UILabel!
    var User : String?
    
        
        // the delegate, remember to set to weak to prevent cycles
        weak var delegate : PostTableViewCellDelegate?
        
        override func awakeFromNib() {
            super.awakeFromNib()
            self.pro_img.layer.cornerRadius = self.pro_img.bounds.height / 2
            self.pro_img.clipsToBounds = true
            // Initialization code
             self.Avatar_btn.addTarget(self, action: #selector(avatarButtonTapped(_:)), for: .touchUpInside)
            // Add action to perform when the button is tapped
           // self.btn.addTarget(self, action: #selector(avatarButtonTapped(_:)), for: .touchUpInside)
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)

            // Configure the view for the selected state
        }
    @IBAction func avatarButtonTapped(_ sender: UIButton){
            if let user = User,
                let delegate = delegate {
                self.delegate?.avatarTableViewCell(self, avatarButtonTappedFor: user)
            }
        }
   
}
protocol PostTableViewCellDelegate: AnyObject {
    func avatarTableViewCell(_ PostViewTableViewCell: PostViewTableViewCell, avatarButtonTappedFor user: String)


   

}
