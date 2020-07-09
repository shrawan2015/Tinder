//
//  FavouritePresenter.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation
import UIKit
protocol SwipePresentationLogic {
    func presentUserResponse(response: UserList.FetchUsers.Response?, error:Error?)
}

class SwipePresenter: BasePresenter, SwipePresentationLogic {
    func presentUserResponse(response:  UserList.FetchUsers.Response?, error: Error?) {
        if error != nil {
            viewController?.displayError(error?.localizedDescription ?? "")
        }else {
            guard let results = response?.results, results.count != 0 ,let result = results[0].user else {
                viewController?.displayError(error?.localizedDescription ?? "")
                return
            }
            var formatedDate = ""
            if let date = Double(result.dob ?? "") {
               formatedDate = date.getDateStringFromUTC()
            }
            
            
            let displayedUser = UserList.FetchUsers.ViewModel.DisplayedUser(name: "\(result.name?.first ?? "") \(result.name?.last ?? "")".capitalizingFirstLetter(), address: result.email ?? "", location: "\(result.location?.street ?? "" ) \(result.location?.city ?? "")", phoneNumber: result.phone ?? "", password: result.password ?? "", profilePic: result.picture ?? "",dob: formatedDate )
            let viewModel = UserList.FetchUsers.ViewModel(displayedUser: displayedUser)
            viewController?.showUser(viewModel.displayedUser)
        }
    }
    
    weak var viewController:SwipeViewController?
}
