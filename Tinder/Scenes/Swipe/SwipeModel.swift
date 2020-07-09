//
//  SwipeModel.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation
struct RandomUser: Codable {
    let results: [User]?
}

struct User: Codable {
    let user: UserObj?
}

struct UserObj: Codable {
    let gender: String?
    let name: Name?
    let location: Location?
    let email: String?
    let username:String?
    let password:String?
    let dob: String?
    let picture:String?
    let phone:String?
}

struct Name: Codable {
    let title, first, last: String?
}

struct Location: Codable {
    let street,city, state, zip: String?
}


struct FavouriteRequest {
}
struct FavouriteResponse{
}

struct FavouriteViewModel{
}
 

enum UserList
{
  // MARK: Use cases
  enum FetchUsers
  {
    struct Request
    {
        
    }
    struct Response
    {
        let results: [User]?
    }
    struct ViewModel
    {
      struct DisplayedUser
      {
        var name: String
        var address: String
        var location: String
        var phoneNumber: String
        var password: String
        var profilePic: String
        var dob: String
      }
      var displayedUser: DisplayedUser
    }
  }
}
