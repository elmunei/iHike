//
//  ViewController.swift
//  iHike
//
//  Created by Elvis Tapfumanei on 10/25/17.
//  Copyright © 2017 Elvis Tapfumanei. All rights reserved.
//

import UIKit
import BWWalkthrough


class InitialVC: UIViewController, BWWalkthroughViewControllerDelegate {
    
    var needWalkthrough:Bool = true
    var walkthrough:BWWalkthroughViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presentWalkthrough()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        if needWalkthrough {
            self.presentWalkthrough()
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
