//
//  UsersDataProvider.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation

import Foundation
protocol  UserDataDataProvider {
    func fetchUsers(request:UserList.FetchUsers.Request, completion: @escaping (UserList.FetchUsers.Response, Error?)->Void)
}
