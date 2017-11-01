//
//  ViewController.swift
//  iHike
//
//  Created by Elvis Tapfumanei on 10/25/17.
//  Copyright © 2017 Elvis Tapfumanei. All rights reserved.
//

import UIKit
import BWWalkthrough
import Firebase


class InitialVC: UIViewController, BWWalkthroughViewControllerDelegate {
    
    var firstLoad: Bool?
    var needWalkthrough:Bool = true
    var walkthrough:BWWalkthroughViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { auth, user in
            
            if user != nil {
                
                if userDefaults.object(forKey: kCURRENTUSER) != nil {
                    
                    DispatchQueue.main.async {

                        self.goToApp()
                        
                    }
                }
                
            } else {
                

                print("User is signed out.")
            }
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        if userDefaults.object(forKey: kCURRENTUSER) != nil {
            print("ELVIS: User is signed in. So it's the main screen")

            DispatchQueue.main.async {
                
                self.goToApp()
                
            }
        
        
    } else {
    
    self.presentWalkthrough()
            
            print("ELVIS: User is signed out. So it's the first screen")
    


//        if needWalkthrough {
//            self.presentWalkthrough()
//        }
    }
    }

    override var prefersStatusBarHidden: Bool{
        
        return true
        
    }
    
    func presentWalkthrough(){
        
        let stb = UIStoryboard(name: "Main", bundle: nil)
        walkthrough = stb.instantiateViewController(withIdentifier: "container") as! BWWalkthroughViewController
        let page_one = stb.instantiateViewController(withIdentifier: "page_1")
        let page_two = stb.instantiateViewController(withIdentifier: "page_2")
        let page_three = stb.instantiateViewController(withIdentifier: "page_3")
        
        // Attach the pages to the master
        walkthrough.delegate = self
        walkthrough.add(viewController:page_one)
        walkthrough.add(viewController: page_two)
        walkthrough.add(viewController:page_three)
        
        
        self.present(walkthrough, animated: true) {
            ()->() in
            self.needWalkthrough = false
        }
    }

    func goToApp() {
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UserDidLoginNotification"), object: nil, userInfo: ["userId" : FUser.currentId()])
        
        
        //go to app
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        
        present(vc, animated: true, completion: nil)
        
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

extension InitialVC{
    
//    func walkthroughCloseButtonPressed() {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    func walkthroughPageDidChange(pageNumber: Int) {
//        if (self.walkthrough.numberOfPages - 1) == pageNumber{
//            self.walkthrough.facebookButton?.isHidden = false
//        }else{
//            self.walkthrough.facebookButton?.isHidden = true
//        }
//    }
    
}
