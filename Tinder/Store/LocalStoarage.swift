//
//  LocalStoarage.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation

struct FavUsers {
    var username: String?
    var location: String?
    var picture:String?
    init( username: String? = nil,
          picture: String? = nil,
          location: String? = nil
    ) {
        self.username = username
        self.picture = picture
        self.location = location
    }
}
