//
//  ABService+Tracking.swift
//  FlagShip
//
//  Created by Adel on 12/08/2019.
//

import Foundation

internal extension ABService{
    
    
    func sendTracking< T: FSTrackingProtocol>(_ event:T){
        
        self.sendEvent(event)
    }
    
    
    ////////////////////: Send Event ...///////////////////////////////////////////////:
    
    func sendEvent< T: FSTrackingProtocol>(_ event:T){
        
        /// Check if the connexion is available
        
        if (self.threadSafeOffline.isConnexionAvailable() == false ){
            
            FSLogger.FSlog("The connexion is not available ..... The event will be saved in Data Base", .Network)
            
            self.threadSafeOffline.saveEvent(event)
            
            return
        }
        
        do {
            
            FSLogger.FSlog(String(format: "\n\n\n Sending Event : ....... %@ \n\n\n", event.bodyTrack.debugDescription), .Network)
            
            let data = try JSONSerialization.data(withJSONObject:event.bodyTrack as Any, options:.prettyPrinted)
            
            if let urlEvent = URL(string:FSDATA_ARIANE) {
                
                var request:URLRequest = URLRequest(url: urlEvent)
                request.httpMethod = "POST"
                request.httpBody = data
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let session = URLSession(configuration:URLSessionConfiguration.default)
                
                session.dataTask(with: request) { (responseData, response, error) in
                    
                    let httpResponse = response as? HTTPURLResponse
                    
                    switch (httpResponse?.statusCode){
                        
                    case 200,201:
                        FSLogger.FSlog("Event sent with success \n\n \(event.bodyTrack) \n\n", .Network)
                        break
                        
                    default:
                        FSLogger.FSlog("Error on send Event", .Network)
                    }
                    
                }.resume()
            }
            
        }catch{
            
            FSLogger.FSlog("Error serialize  event ", .Network)
        }
        
    }
    
    
    
    
    //// Tempo ....
    
    //magicUserEndPoint
    
    
    func magikUserConsolidation(_ userName:String,  onGetResponse:@escaping(FSConsolidation?, FlagshipError?)->Void){
        
        do {
            
            let params:NSMutableDictionary = ["username":userName , "deviceId":FSGenerator.getFlagShipIdInCache() ?? ""]
            
            
            print(" !!!!!!!!!!!!!!!!! ......About to send the username with generated id \(params) !!!!!!!!!!!!!!!!!!!")
            
            let data = try JSONSerialization.data(withJSONObject: params, options:[])
            
             if let getUrl = URL(string: String(format: magikUserEndPoint)){
                
                var request:URLRequest = URLRequest(url:getUrl, timeoutInterval: timeOutServiceForRequestApi)  //// Request with time interval
                request.httpMethod = "POST"
                request.httpBody = data
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                sessionService.dataTask(with: request) { (responseData, response, error) in
                    
                    if (error == nil){
                        
                        let httpResponse = response as? HTTPURLResponse
                        switch (httpResponse?.statusCode){
                        case 200:
                            
                            if let aResponseData = responseData {
                                
                                do {
                                    
                                    let decoder = JSONDecoder()
                                    let objectDecoded = try decoder.decode(FSConsolidation.self, from: aResponseData)
                                    
                                    // Print Json response
                                    let dico = try JSONSerialization.jsonObject(with: aResponseData, options: .allowFragments)
                                    
                                    
                                    print(" !!!!!!!!!!! Get the response from coso sever \(dico) !!!!!!!!!!!!!!!!!!!!")
                                    
                                    onGetResponse(objectDecoded, nil)
                      
                                } catch {
                                    
                                    onGetResponse(nil, FlagshipError.GetCampaignError)
                                }
                            }else{
                                
                                onGetResponse(nil, FlagshipError.GetCampaignError)
                            }
                            break
                        default:
                            onGetResponse(nil, FlagshipError.GetCampaignError)
                        }
                    }else{
                        
                        onGetResponse(nil, FlagshipError.NetworkError)
                    }
                    
                    }.resume()
            }
        }catch{
            
            FSLogger.FSlog("error on serializing json", .Network)
        }
        
    }
}


