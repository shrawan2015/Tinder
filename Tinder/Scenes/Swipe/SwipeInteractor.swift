//
//  SwipeInteractor.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation

protocol UserDataStore
{
    var user: UserList.FetchUsers.ViewModel? { get }
}

protocol SwipeBusinessLogic {
    func fetchUser()
    
}

class SwipeInteractor: BaseInteractor, SwipeBusinessLogic {
    var presenter:SwipePresentationLogic?
    var user: UserList.FetchUsers.ViewModel?

    func fetchUser() {
        let request = UserList.FetchUsers.Request()
        SwipeUseCase.service(request: request) { [weak self] (response, error) in
                self?.presenter?.presentUserResponse(response: response, error: error)
        }
    }
    
}
