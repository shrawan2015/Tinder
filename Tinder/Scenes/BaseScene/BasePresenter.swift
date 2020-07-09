//
//  BasePresenter.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation


struct LogicalError: LocalizedError {
    
    private var message: String
    
    init(_ message: String,code : String? = nil) {
        self.message = message
        self.errorCode = code
    }
    var errorCode : String?
    var errorDescription: String? {
        return message
    }
    
}

class BasePresenter {
  
}
