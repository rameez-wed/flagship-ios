//
//  FSCacheManager.swift
//  FlagShip
//
//  Created by Adel on 21/08/2019.
//

import Foundation

class FSCacheManager {
    
    
    var urlCampaign:URL?
    
//    init() {
//        // Create Url cache
//        self.urlCampaign = createUrlForCache()
//    }
    
    
    // Get All Event
    func readCampaignFromCache()->FSCampaigns?{
        
        return nil
    }
    
    
    
    // Write Campaign on Directory
    func saveCampaignsInCache(_ dataCampaign:Data?){
        
        DispatchQueue(label: "sss", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil).async {
            
            let urlForCache:URL? = self.createUrlForCache()
            
            guard let url:URL? = urlForCache?.appendingPathComponent("campaigns.json") else {
                
                print("Failed to save ..........")
                return
            }
            do {
                try dataCampaign!.write(to: url!, options: [])
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        
    }
    
    
    /////////// Tools /////////////////////////////
    func createUrlForCache()->URL?{
        
        if var url:URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            // Path
            url.appendPathComponent("FlagShipCampaign", isDirectory: true)
            
            if (FileManager.default.fileExists(atPath: url.path) == false){
                
                // create directory
                do {
                    try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                    return url
                    
                }catch{
                    
                    fatalError(error.localizedDescription)
                }
                
            }else{
                
                print("URL For cache already exist")
                return url
            }
        }
        return nil
    }
}
