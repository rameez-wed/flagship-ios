//
//  FSHitViewController.swift
//  QApp
//
//  Created by Adel on 26/11/2020.
//  Copyright © 2020 FlagShip. All rights reserved.
//

import UIKit
import Flagship

class FSHitViewController: UIViewController,UITextFieldDelegate {
    
    /// Page
    @IBOutlet weak var interfaceNameFiled: UITextField!
    
    @IBOutlet weak var pageHitBtn: UIButton!

    
    /// Event
    @IBOutlet weak var eventAction: UITextField!
    
    @IBOutlet weak var typeEventSwitch: UISwitch!
    
    @IBOutlet weak var eventHitBtn: UIButton!
    
    @IBOutlet weak var labelSwitch: UILabel!
    
    
    /// Transaction
    
    @IBOutlet weak var transactiontHitBtn: UIButton!
    
    @IBOutlet weak var idTransacField: UITextField!
    
    @IBOutlet weak var affiliationField: UITextField!





    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }
    
    
     

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard)))
        
        /// Disable the buttons
        pageHitBtn.isEnabled = false
        eventHitBtn.isEnabled = false
        transactiontHitBtn.isEnabled = false

        
    }
    
    // Hide KeyBoard
    @objc func hideKeyBoard(){
        
        self.view.endEditing(true)
    }
    
    
    //// Send The hit page
    @IBAction func onClickPageHit(){
        
        if let input = interfaceNameFiled!.text{
            
            if input.count > 2{
                
                Flagship.sharedInstance.sendHit(FSPage(input))
            }
        }
    }
    
    
    
    /// Send Event hit
    
    @IBAction func onClickEventHit(){
        
        if let input = eventAction!.text{
            
            if input.count > 2{
                
                let type:FSCategoryEvent = typeEventSwitch.isOn ? .Action_Tracking : .User_Engagement
                Flagship.sharedInstance.sendHit(FSEvent(eventCategory:type, eventAction: input))
            }
        }
    }
    
    /// Send Transaction
    
    @IBAction func onClickTransactionHit(){
        
        if let input = idTransacField!.text{
            
            if input.count > 2{
                Flagship.sharedInstance.sendHit(FSTransaction(transactionId: input, affiliation: "testTransac"))
            }
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        
        if textField.tag == 111 {
            
            if updatedText.count > 2 {
                
                pageHitBtn.isEnabled = true
            }else{
                pageHitBtn.isEnabled = false
            }
        }else if textField.tag == 222{
            
            if updatedText.count > 2 {
                
                eventHitBtn.isEnabled = true
            }else{
                eventHitBtn.isEnabled = false
            }
        }else if (textField.tag == 333 ){
            
            if updatedText.count > 2 {
                
                transactiontHitBtn.isEnabled = true
            }else{
                transactiontHitBtn.isEnabled = false
            }
            
        }
        
        return true
    }
    
    
    @IBAction func onChangeSwitch(){
        
    let typeString = typeEventSwitch.isOn ? FSCategoryEvent.Action_Tracking.categoryString :  FSCategoryEvent.User_Engagement.categoryString
        
        DispatchQueue.main.async {
            
            self.labelSwitch.text = typeString
        }
    }

}
