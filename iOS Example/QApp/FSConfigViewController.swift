//
//  FSConfigViewController.swift
//  QApp
//
//  Created by Adel on 23/11/2020.
//  Copyright © 2020 FlagShip. All rights reserved.
//

import UIKit
import Flagship

class FSConfigViewController: UIViewController, UITextFieldDelegate {
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }
    
    @IBOutlet var envIdTextField:UITextField?
    @IBOutlet var apiKetTextField:UITextField?
    @IBOutlet var visitorIdTextField:UITextField?
    @IBOutlet var authenticateSwitch:UISwitch?
    
    @IBOutlet var visitorCtxLabel:UILabel?

    
    
    var delegate:FSConfigViewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // set envid
        
        self.envIdTextField?.text = "bkk9glocmjcg0vtmdlng"
        self.apiKetTextField?.text = "j2jL0rzlgVaODLw2Cl4JC3f4MflKrMgIaQOENv36"
        self.visitorIdTextField?.text = nil
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard)))
        
        self.visitorCtxLabel?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showEditContext)))
        self.visitorCtxLabel?.isUserInteractionEnabled = true
        
        
       

        
        self.visitorCtxLabel?.text = String(format: "%@", Flagship.sharedInstance.getVisitorContext())

    }
    
    // Hide KeyBoard
    @objc func hideKeyBoard(){
        
        self.view.endEditing(true)
    }
    
    // Hide KeyBoard
    @objc func showEditContext(){
        
        
        DispatchQueue.main.async {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let contextCtrl = storyboard.instantiateViewController(
                          withIdentifier: "contextPopUp")
            ///push view
            contextCtrl.modalPresentationStyle = .popover
            self.present(contextCtrl, animated: true) {
                
            }
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.visitorCtxLabel?.text = String(format: "%@", Flagship.sharedInstance.getVisitorContext())

    }
    
    
    
    
    @IBAction func onClikcStart(){
        
        let userIdToSet:String? = (visitorIdTextField?.text?.count == 0) ? nil : visitorIdTextField?.text
        

        let config  = FSConfig(.DECISION_API, authenticated: self.authenticateSwitch?.isOn ?? false)
        
        /// Start function
        Flagship.sharedInstance.start(envId: envIdTextField?.text ?? "", apiKey: apiKetTextField?.text ?? "", visitorId: userIdToSet, config:config) { (result) in
            
            
            DispatchQueue.main.async {
                
                self.visitorCtxLabel?.text = String(format: "%@", Flagship.sharedInstance.getVisitorContext())

            }
            
            if result == .Ready {
                
                self.delegate?.onGetSdkReady()
            }
        }
    }
    
    
    
    @IBAction func onSwichAuthenticate(){
        
        if (authenticateSwitch?.isOn ?? false) {
            
            print(" @@@@@@@@@@@@@@@@@@@@@@ AUTHENTICATE IS TRUE @@@@@@@@@@@@@@@@@@@@@@@@@")
        }else{
            
            print(" @@@@@@@@@@@@@@@@@@@@@@ AUTHENTICATE IS FALSE @@@@@@@@@@@@@@@@@@@@@@@@@")
        }
    }
    
    
    /// Delegate textfield
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        hideKeyBoard()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    
 
    }
}




///// Delegate


protocol FSConfigViewDelegate {
    
    func onGetSdkReady()
    
}


