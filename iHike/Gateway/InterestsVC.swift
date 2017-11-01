//
//  InterestsVC.swift
//  iHike
//
//  Created by Elvis Tapfumanei on 10/27/17.
//  Copyright © 2017 Elvis Tapfumanei. All rights reserved.
//

import UIKit
import Firebase
import ProgressHUD

class InterestsVC: UIViewController {

    var user: FUser!

    
    var interest1 = ""
    var interest2 = ""
    var interest3 = ""
    var interest4 = ""

    var userInterests: [String] = []
    
     // MARK: - Outlets
    
    
    @IBAction func trekkerBtn(_ sender: ETRadioButton) {
   
        sender.isSelected = !sender.isSelected
        
        if (sender as AnyObject).isSelected {
            interest1 = "Trekker"
//            interests.append("Trekker")
       
        } else{
            interest1 = ""

//            interests.append("Not Selected")
        }
        
        print(interest1)
    }
    
    @IBAction func bikerBtn(_ sender: ETRadioButton) {
    
        sender.isSelected = !sender.isSelected
        
        if (sender as AnyObject).isSelected {
            interest2 = "Biker"

//            interests.append("Biker")
            
        } else{
            interest2 = ""

//            interests.append("Not Selected")
        }
        
        print(interest2)

    }
    
    
    @IBAction func walkerBtn(_ sender: ETRadioButton) {
   
        sender.isSelected = !sender.isSelected
        
        if (sender as AnyObject).isSelected {
            interest3 = "Walker"

//            interests.append("Walker")
        } else{
            interest3 = ""

//            interests.append("Not Selected")
        }
        
        print(interest3)

    }
    @IBAction func runnerBtn(_ sender: ETRadioButton) {
    
        sender.isSelected = !sender.isSelected
        
        if (sender as AnyObject).isSelected {
            interest4 = "Runner"

//            interests.append("Runner")
        } else{
            interest4 = ""

//            interests.append("Not Selected")
        }
        
        print(interest4)

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Elvis: You are on Interests screen")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
    // MARK: - Navigation

    @IBAction func exploreBtn(_ sender: Any) {
        
        userInterests.append(interest1)
        userInterests.append(interest2)
        userInterests.append(interest3)
        userInterests.append(interest4)
        
        
        let newDate = dateFormatter().string(from: Date())
        
        updateUser(withValues: [kCURRENTUSERINTERESTS: userInterests, kUPDATEDAT: newDate]) { (success) in
            
            if success {
                ProgressHUD.dismiss()
                
                self.user = FUser.currentUser()
                self.view.endEditing(false)
                
                print("Elvis: Interests are \(String(describing: self.userInterests))")
                
                //Proceed to Location Screen
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RequestLocationVC") as! RequestLocationVC
                
                self.present(vc, animated: true, completion: nil)
                
            }
            
            
        }

    }
    
 
    

}
