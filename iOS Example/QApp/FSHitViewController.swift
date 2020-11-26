//
//  FSHitViewController.swift
//  QApp
//
//  Created by Adel on 26/11/2020.
//  Copyright © 2020 FlagShip. All rights reserved.
//

import UIKit

class FSHitViewController: UIViewController {
    
    
 
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }
    
    
     

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard)))
        
    }
    
    // Hide KeyBoard
    @objc func hideKeyBoard(){
        
        self.view.endEditing(true)
    }
    
    @IBAction func onClickPageHit(){
        
        
        
    }
 
    
    @IBAction func onClickEventHit(){
        
        
    }
    
    
    @IBAction func onClickTransactionHit(){
        
        
    }

}
