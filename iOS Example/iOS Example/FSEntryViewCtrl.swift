//
//  FSEntryViewCtrl.swift
//  iOS Example
//
//  Created by Adel on 20/01/2020.
//  Copyright © 2020 FlagShip. All rights reserved.
//

import UIKit
import FlagShip

class FSEntryViewCtrl: UIViewController {
    
    
    @IBOutlet var signInBtn:UIButton!
    @IBOutlet var logInBtn:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let loadView = UIActivityIndicatorView(frame: CGRect(x: self.view.center.x, y: self.view.center.y, width: 100, height: 100))
        loadView.center = self.view.center
        loadView.color = .red
        loadView.startAnimating()
        self.view.addSubview(loadView)
        // Reset vid
        FlagShip.sharedInstance.resetUserIdFlagShip()
        
        
        FlagShip.sharedInstance.updateContextWithPreConfiguredKeys(.FIRST_TIME_INIT, value: "rr", sync: nil)
        
        /// Set context isVip to true
        FlagShip.sharedInstance.context("isVip", true)
        /// Start The sdk
        FlagShip.sharedInstance.startFlagShip(environmentId:"bkk9glocmjcg0vtmdlng",nil) { (result) in
            
            // The state is ready , you can now use the FlagShip
            if result == .Ready {
                DispatchQueue.main.async {
                   
                    loadView.stopAnimating()
                    self.logInBtn.isHidden  = false
                    self.signInBtn.isHidden = false
                }
            }else{
                
                print(result)
                loadView.stopAnimating()
            }
        }
        
        // To get your generated visitorId, use :
        FlagShip.sharedInstance.visitorId
        
     }
    
    
    

    @IBAction func onShowLoginScreen(){
        
        //Update isVipUser with false value in the user context
        FlagShip.sharedInstance.updateContext(["isVip":false]) { (result) in
            
            if result == .Updated{
                
                // In this block you will have new values updated for non VIP users
                DispatchQueue.main.async {
                    
                    // Get title for banner
                    let title = FlagShip.sharedInstance.getModification("bannerTitle", defaultString: "More Infos",activate: true)
                    // Set the title
                    
                    
                }
            }
        }
        
        self.performSegue(withIdentifier: "showLoginScreen", sender:nil)
    }

}
