//
//  ProfileViewController.swift
//  iHike
//
//  Created by Elvis Tapfumanei on 31/10/2017.
//  Copyright © 2017 Elvis Tapfumanei. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit

class ProfileViewController: UIViewController {

    var user: FUser!
    var avatarImage: UIImage?
    
    // UI objects
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pp: UIImageView!
    @IBOutlet weak var fullnameLbl: UILabel!
    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var checkins: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var followings: UILabel!
    
    @IBOutlet weak var checkinsTitle: UILabel!
    @IBOutlet weak var followersTitle: UILabel!
    @IBOutlet weak var followingsTitle: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()

        print("ELVIS: User is on the own Profile Screen screen")

    }

    @IBAction func logoutBtn(_ sender: Any) {
        
        showLogoutView()

    }
  
    // MARK: - Functions

    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    

    func getUserInfo() {
        
        self.user = FUser.currentUser()
        
        if user.objectId != FUser.currentId() {
            
        }
        
        let placeHolderImage = UIImage(named: "pp")
        
        self.pp.image = maskRoundedImage(image: placeHolderImage!, radius: Float(placeHolderImage!.size.width ))
        
        fullnameLbl.text = user.fullname.capitalized
        location.text = user.location.capitalized
        checkins.text = "75"
        followings.text = "300"
        followers.text = "634"

        
        
        if user.avatar != "" {
            
            imageFromData(pictureData: user.avatar, withBlock: {
                image in
                
//                self.pp.image = maskRoundedImage(image: image!, radius: Float(image!.size.width))
                self.pp.image = bgImage(image: image!)
            })
            
        }
    }
    
    func showLogoutView() {
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let logOut = UIAlertAction(title: "Log Out", style: .destructive) { (alert: UIAlertAction!) in
            
            self.logOut()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) in
            
        }
        
        optionMenu.addAction(logOut)
        optionMenu.addAction(cancelAction)
        
        
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    func logOut() {
        
        cleanupFirebaseObservers()
        
        FUser.logOutCurrentUser()
        
        //log out from facebook
        if FBSDKAccessToken.current() != nil {
            
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
        }
        
        
        
        let login = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InitialVC")
        
        self.present(login, animated: true, completion: nil)
        
    }

}
