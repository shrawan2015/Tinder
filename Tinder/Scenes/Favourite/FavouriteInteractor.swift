//
//  FavouriteInteractor.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation

protocol FavBusinessLogic {
    func favUser()
}

class FavouriteInteractor: BaseInteractor, FavBusinessLogic {
    var users:[FavUsers]?
    
    var presenter:FavouritePresentationLogic?
    func favUser() {
        self.users =  getFav()
        presenter?.presentFavouriteResponse(response: self.users , error: nil)
    }
}

