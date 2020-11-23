//
//  FSTabBarViewCtrl.swift
//  QApp
//
//  Created by Adel on 23/11/2020.
//  Copyright © 2020 FlagShip. All rights reserved.
//

import UIKit

class FSTabBarViewCtrl: UITabBarController, FSConfigViewDelegate {
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let configCtrl = self.viewControllers?.first as? FSConfigViewController{
            
            configCtrl.delegate = self
        }
        
    }
    
    
    
    
    
    /// Delegate
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        print("a")
    }

    
    /// Delegate FSConfig
    
    func onGetSdkReady() {
        
        DispatchQueue.main.async {
            
            if let userController = self.viewControllers?.last as? FSUserViewCtrl{
                
               
                    userController.updateIds()
                
               
            }
        }
    }
}


