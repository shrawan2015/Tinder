//
//  FavouriteUseCase.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation
//Worker
class SwipeUseCase:BaseUseCase<UserList.FetchUsers.Request, UserList.FetchUsers.Response> {
    override func getRequest(request: UserList.FetchUsers.Request?, completionHandler: @escaping (UserList.FetchUsers.Response?, Error?) -> Void) {
        AFWrapper.sharedInstance.fetchData(using:"randomapi"){ data,error in
            if(error != nil){
                completionHandler(nil,error)
                return
            }
               do {
                let resultModel = try JSONDecoder().decode(RandomUser.self, from: data!)
                let users =  resultModel.results
                let response = UserList.FetchUsers.Response(results: users)
                completionHandler(response,nil)
                return
            }  catch let exception {
                     completionHandler(nil,exception)
            }
        }
    }
}

