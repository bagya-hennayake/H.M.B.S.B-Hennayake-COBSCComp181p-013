////
////  TabMainViewController.swift
////  NIBM-App
////
////  Created by Bagya Hennayake on 11/9/19.
////  Copyright © 2019 Bagya Hennayake. All rights reserved.
////
//
import BiometricAuthentication
import UIKit
//import FirebaseDatabase
//import SwiftyJSON
//import Kingfisher
class TabMainViewController: UITabBarController, UITabBarControllerDelegate{

    //self.tabBarController?.tabBar.items![0].image = UIImage(named: "your image name")
  override func viewDidLoad() {
    
    super.viewDidLoad()

    self.delegate = self
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: MyProfileViewController.self) {
           
            BioMetricAuthenticator.authenticateWithBioMetrics(reason: "Authentication required to access this section") { (result) in
                
                switch result {
                case .success( _):
                    print("Authentication Successful")
                    self.selectedIndex = 2
                case .failure(let error):
                    print("Authentication Failed")
                    
                }
            }
            return false
        }
        return true
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("eeeee--\(item.tag)")
        
    }

}
