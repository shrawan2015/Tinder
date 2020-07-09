//
//  FavouritePresenter.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation
import UIKit
protocol FavouritePresentationLogic {
    func presentFavouriteResponse(response:[FavUsers]?, error:Error?)
}

class FavouritePresenter: BasePresenter, FavouritePresentationLogic {
    func presentFavouriteResponse(response: [FavUsers]?, error: Error?) {
        if error != nil {
            viewController?.favouriteError(error?.localizedDescription ?? "No description")
        }else {
            viewController?.favouriteUser(response)
        }
    }
    
    weak var viewController:FavouriteViewController?
    
}
