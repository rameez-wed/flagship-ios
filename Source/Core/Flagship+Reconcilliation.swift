//
//  Flagship+Reconcilliation.swift
//  Flagship
//
//  Created by Adel on 12/11/2020.
//  Copyright © 2020 FlagShip. All rights reserved.
//

import Foundation


extension Flagship{
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - newVisitorId: <#newVisitorId description#>
    ///   - context: <#context description#>
    ///   - onSynchronized: <#onSynchronized description#>
    public func authenticateVisitor(newVisitorId:String, newContext:[String:Any]? = nil, onSynchronized:((FlagshipResult)->Void)? = nil){
        
        /// Update the visitor an anonymous id 
        self.anonymousId = self.visitorId
        
        self.visitorId = newVisitorId
        
        ///set the new context if provided here
        /// if the context is nill ==> will no effect or erase the current context
        self.context.setNewContext(newContext)
        
        if let aSync = onSynchronized {
            
            self.synchronizeModifications { (result) in
                
                aSync(result)
            }
        }
    }
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - context: <#context description#>
    ///   - onSynchronized: <#onSynchronized description#>
    public func unAuthenticateVisitor(_ newContext:[String:Any]? = nil, onSynchronized:((FlagshipResult)->Void)? = nil){
        
        self.visitorId = self.anonymousId
        
        self.anonymousId = nil
        
        ///set the new context if provided here
        /// if the context is nill ==> will no effect or erase the current context
        self.context.setNewContext(newContext)
        
        if let aSync = onSynchronized {
            
            self.synchronizeModifications { (result) in
                
                aSync(result)
            }
        }
        
    }
    
    
    /// <#Description#>
    /// - Returns: <#description#>
    public func getVisitorContext()->Dictionary<String, Any>{
        
        self.context.currentContext
    }
}
