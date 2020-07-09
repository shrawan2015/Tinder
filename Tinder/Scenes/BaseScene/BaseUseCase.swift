//
//  BaseUseCase.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation


class BaseUseCase<RequestType: Any, ResponseType: Any> {
    
    class func service(request:RequestType?,  completionBlock: @escaping ( _ response: ResponseType? , _ error : Error?) -> Void){
        self.init(request) { (response, error) in
            completionBlock(response, error)
        }
    }
    
    @discardableResult
    required init(_ request:RequestType?,  completionBlock: @escaping ( _ response: ResponseType? , _ error : Error?) -> Void){
        self.getRequest(request: request) { (response, error) in
            completionBlock(response, error)
        }
    }
    
    func getRequest(request: RequestType?, completionHandler: @escaping(_ response: ResponseType?, _ error: Error?) -> Void) {
        
    }
}

