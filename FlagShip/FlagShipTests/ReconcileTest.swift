//
//  ReconcileTest.swift
//  FlagshipTests
//
//  Created by Adel on 17/11/2020.
//  Copyright © 2020 FlagShip. All rights reserved.
//

import XCTest
@testable import Flagship



class ReconcileTest: XCTestCase {
    
    var serviceTest:ABService!
    let mockUrl = URL(string: "Mock")!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let sessionTest = URLSession.init(configuration: configuration)
        serviceTest = ABService("idClient", "idVisitor", "anounymousA", "apiKey")
        
        /// Set our mock session into service
        serviceTest.sessionService = sessionTest
        
        Flagship.sharedInstance.service = serviceTest
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testAuthenticate(){
        
        /// Create the mock response
        /// Load the data
         
         let expectation = XCTestExpectation(description: "Service-GetScript")
         
         do {
             
             let testBundle = Bundle(for: type(of: self))
             
             guard let path = testBundle.url(forResource: "decisionApi", withExtension: "json") else { return  }
             
             let data = try Data(contentsOf: path, options:.alwaysMapped)
             
             
             MockURLProtocol.requestHandler = { request in
                 
                 let response = HTTPURLResponse(url:self.mockUrl , statusCode: 200, httpVersion: nil, headerFields: nil)!
                 return (response, data)
             }
             
             // Set visitor id
             Flagship.sharedInstance.setVisitorId("alex")
             // set context
             Flagship.sharedInstance.updateContext(ALL_USERS, "")
             
             Flagship.sharedInstance.onStartDecisionApi { (result) in
                 
                 XCTAssert(result == .Ready)
                
                
                
                 expectation.fulfill()
             }
             
         }catch{
             
             print("error")
         }
         
         wait(for: [expectation], timeout: 5.0)
        
        
    }

    
    
    
    

}
