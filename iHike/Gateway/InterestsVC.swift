//
//  InterestsVC.swift
//  iHike
//
//  Created by Elvis Tapfumanei on 10/27/17.
//  Copyright © 2017 Elvis Tapfumanei. All rights reserved.
//

import UIKit

class InterestsVC: UIViewController {

    var interests = [String]()
    
     // MARK: - Outlets
    
    
    @IBAction func trekkerBtn(_ sender: ETRadioButton) {
   
        sender.isSelected = !sender.isSelected
        
        if (sender as AnyObject).isSelected {
            interests = ["Trekker"]
            
           
        } else{
            interests = ["Not Selected"]
        }
        
        print(interests)
    }
    
    @IBAction func bikerBtn(_ sender: ETRadioButton) {
    
        sender.isSelected = !sender.isSelected
        
        if (sender as AnyObject).isSelected {
            interests = ["Biker"]
            
        } else{
            interests = ["Not Selected"]
        }
        
        print(interests)

    }
    
    
    @IBAction func walkerBtn(_ sender: ETRadioButton) {
   
        sender.isSelected = !sender.isSelected
        
        if (sender as AnyObject).isSelected {
            interests = ["Walker"]
        } else{
            interests = ["Not Selected"]
        }
        
        print(interests)

    }
    @IBAction func runnerBtn(_ sender: ETRadioButton) {
    
        sender.isSelected = !sender.isSelected
        
        if (sender as AnyObject).isSelected {
            interests = ["Runner"]
        } else{
            interests = ["Not Selected"]
        }
        
        print(interests)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
