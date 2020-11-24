//
//  FSModificationsViewCtrl.swift
//  QApp
//
//  Created by Adel on 24/11/2020.
//  Copyright © 2020 FlagShip. All rights reserved.
//

import UIKit
import Flagship


class FSModificationsViewCtrl: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    let sourcePicker:[String] = ["Integer","Boolean","Double","String"]
    
    
    
    
    @IBOutlet var valueLabel:FSLabel?
    @IBOutlet var variationIdLabel:FSLabel?
    @IBOutlet var variationGroupIdLabel:FSLabel?
    @IBOutlet var campaigIdLabel:FSLabel?

    
    @IBOutlet var keyTextField:UITextField?
    
    @IBOutlet var defaultValueField:UITextField?
    
    
    @IBOutlet var typePicker:UIPickerView?

    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let redPlaceholderText = NSAttributedString(string: "Default value",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
                
        defaultValueField?.attributedPlaceholder = redPlaceholderText
        
        


        // Do any additional setup after loading the view.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard)))
        

    }
    
    // Hide KeyBoard
    @objc func hideKeyBoard(){
        
        self.view.endEditing(true)
    }
    

    
    
    
    /// Actions
    
    @IBAction func onClikcGetValue(){
        
        // get default value
        if let defValue = defaultValueField?.text {
            
            
        }
        
        if let keyValue = keyTextField?.text {
            
            let resultValue = Flagship.sharedInstance.getModification(keyValue, defaultString:"valll")
            
            /// Display value
            
            let dicoInfo = Flagship.sharedInstance.getModificationInfo(keyValue)
            
            //      @return { “campaignId”: “xxxx”, “variationGroupId”: “xxxx“, “variationId”: “xxxx”} or nil
            
            DispatchQueue.main.async {
                
                self.valueLabel?.text = "\(resultValue)"
                
                self.variationIdLabel?.text = "\(dicoInfo?["variationId"] ?? "unknown")"
                
                self.variationGroupIdLabel?.text = "\(dicoInfo?["variationGroupId"] ?? "unknown")"
                
                self.campaigIdLabel?.text = "\(dicoInfo?["campaignId"] ?? "unknown")"


            }
        }
 
    }
    
    
    @IBAction func onClickActivate(){
        
        
    }
    
    
    
    //// delegate picker
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
       1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sourcePicker.count
    }
    
    
 
 
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return sourcePicker[row]
    }

}



















class FSLabel:UILabel{
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

     }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 223/250, green: 68/250, blue: 110/250, alpha: 1).cgColor
     }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}
