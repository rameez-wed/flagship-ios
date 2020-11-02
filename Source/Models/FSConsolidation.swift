//
//  FSConsolidation.swift
//  Flagship
//
//  Created by Adel on 02/11/2020.
//  Copyright © 2020 FlagShip. All rights reserved.
//

import UIKit

class FSConsolidation: Decodable {
    
    /// user name
    let username:String?
    
    /// Device Id
    let initialDeviceId:String?
    
    
    required public  init(from decoder: Decoder) throws{
        
        let values     = try decoder.container(keyedBy: CodingKeys.self)

        do{ self.username                    = try values.decode(String.self, forKey: .username)} catch{ self.username = ""}
        do{ self.initialDeviceId             = try values.decode(String.self, forKey: .initialDeviceId)} catch{ self.initialDeviceId = ""}
    }
    
    private enum CodingKeys: String, CodingKey {
        case username
        case initialDeviceId
    }

}


