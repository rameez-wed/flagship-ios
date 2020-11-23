//
//  FSUserViewCtrl.swift
//  QApp
//
//  Created by Adel on 23/11/2020.
//  Copyright © 2020 FlagShip. All rights reserved.
//

import UIKit
import Flagship
class FSUserViewCtrl: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }
    
    
    @IBOutlet var visitorTextField:UITextField?
    @IBOutlet var anonymousIdField:UITextField?
    
    
    @IBOutlet var newVisitorField:UITextField?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.visitorTextField?.text =  Flagship.sharedInstance.visitorId
        
        self.anonymousIdField?.text = Flagship.sharedInstance.anonymousId
        
        
        let redPlaceholderText = NSAttributedString(string: "New authenticated id",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                
        newVisitorField?.attributedPlaceholder = redPlaceholderText
        
        
    }
    
    
    
    internal func updateIds(){
        
        DispatchQueue.main.async {
            
            self.visitorTextField?.text =  Flagship.sharedInstance.visitorId
            
            self.anonymousIdField?.text = Flagship.sharedInstance.anonymousId
        }
    }
    
    
    /// authenticate
    @IBAction func authenticate(){
        
        if let userId = newVisitorField?.text{
            
            Flagship.sharedInstance.authenticateVisitor(newVisitorId:userId) { (result) in
                
                self.updateIds()
            }
        }

    }
    
    
    /// unAuthenticate
    @IBAction func unAuthenticate(){
        
        Flagship.sharedInstance.unAuthenticateVisitor{ (result) in
            
            self.updateIds()
        }
    }
    
    
    /// Synchronize
    @IBAction func synchronize(){
        
        Flagship.sharedInstance.synchronizeModifications { (result) in
            
            
        }
        
    }
    
    
    
}
