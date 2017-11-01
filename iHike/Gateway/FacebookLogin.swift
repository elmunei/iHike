//
//  FacebookLogin.swift
//  iHike
//
//  Created by Elvis Tapfumanei on 28/10/2017.
//  Copyright © 2017 Elvis Tapfumanei. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import FBSDKCoreKit
import FirebaseAuth
import ProgressHUD
import NotificationBannerSwift

class FacebookLogin: UIViewController {

    var firstLoad: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.fbBtn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    func fbBtn() {
        let fbLoginManager = FBSDKLoginManager()
        
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self, handler: {
            result, error in
            
            if error != nil {
                print("error logging in with facebook \(String(describing: error?.localizedDescription))")
                return
            }
            
            
            if result?.token != nil {
                
                ProgressHUD.show("Please wait...", interaction: false)
                ProgressHUD.backgroundColor(UIColor.white)
                let credentials = FacebookAuthProvider.credential(withAccessToken: result!.token.tokenString)
                
                Auth.auth().signIn(with: credentials, completion: { (firuser, error) in
                    
                    if error != nil {
                        
                        print("Error logging in with facebook \(String(describing: error?.localizedDescription))")
                        return
                    }
                    
                    self.isUserRegistered(userId: firuser!.uid, withBlock: { (isRegistered) in
                        
                        if !isRegistered {
                            ProgressHUD.dismiss()
                            //do only when user is not registered yet
                            self.createFirebaseUserFromFacebook(withBlock: { (result, avatarImage) in
                                
                                let fUser = FUser(_objectId: firuser!.uid, _pushId: "", _createdAt: Date(), _updatedAt: Date(), _email: firuser!.email!, _username: result["name"] as! String, _fullname: result["name"] as! String, _avatar: avatarImage,_location: "" ,_interests: [" "], _loginMethod: kFACEBOOK, _friends: [])
                                
                                saveUserLocally(fUser: fUser)
                                saveUserInBsckground(fUser: fUser, completion: { (error) in
                                    
                                    if error == nil {
                                        
                                        ProgressHUD.dismiss()
                                        self.goToApp()
                                    }
                                    
                                })
                                
                            })
                            
                        } else {
                            
                            ProgressHUD.dismiss()
                            //login user and dont reg him
                            fetchUser(userId: firuser!.uid, withBlock: { (success) in
                                
                                if success {
                                    
                                    ProgressHUD.dismiss()
                                    //go to app
                                    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                                    
                                    self.present(vc, animated: true, completion: nil)
                                }
                                
                            })
                            
                        }
                        
                    })
                    
                })
            }
            
        })
    }
    
    
    func createFirebaseUserFromFacebook(withBlock: @escaping (_ result: NSDictionary, _ avatarImage: String) -> Void) {
        
        
        
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields" : "email, name, locale"]).start { (connection, result, error) in
            
            
            if error != nil {
                ProgressHUD.dismiss()
                print("Error facebook request \(String(describing: error?.localizedDescription))")
                return
            }
            
            
            if let facebookId = (result as! NSDictionary)["id"] as? String {
                
                let avatarUrl = "http://graph.facebook.com/\(facebookId)/picture?width=640&height=640"
                
                getImageFromURL(url: avatarUrl, withBlock: { (image) in
                    
                    //convert avatar image to string
                    let image = UIImageJPEGRepresentation(image!, 0.5)
                    let avatarString = image!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
                    
                    
                    withBlock(result as! NSDictionary, avatarString)
                })
                
            } else {
                
                print("Facebook request error, no facebook id")
                
                //return result only
                withBlock(result as! NSDictionary, "")
                
            }
            
        }
        
    }
    
    
    func isUserRegistered(userId: String, withBlock: @escaping (_ result: Bool) -> Void) {
        
        firebase.child(kUSER).queryOrdered(byChild: kOBJECTID).queryEqual(toValue: userId).observeSingleEvent(of: .value, with: {
            snapshot in
            
            if snapshot.exists() {
                
                withBlock(true)
                
            } else {
                
                withBlock(false)
            }
            
        })
        
    }
    
    func goToApp() {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLoginNotification"), object: nil, userInfo: ["userId" : FUser.currentId()])
        
        
        //go to app
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UsernameVC") as! UsernameVC
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    //firstRun check
    func setUserDefaults() {
        
        firstLoad = userDefaults.bool(forKey: kFIRSTRUN)
        
        if !firstLoad! {
            
            userDefaults.set(true, forKey: kFIRSTRUN)
            userDefaults.set(true, forKey: kAVATARSTATE)
            
            userDefaults.set(1.0, forKey: kRED)
            userDefaults.set(1.0, forKey: kGREEN)
            userDefaults.set(1.0, forKey: kBLUE)
            
            userDefaults.synchronize()
        }
        
    }

}
