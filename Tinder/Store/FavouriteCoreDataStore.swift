//
//  FavouriteCoreDataStore.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation
import UIKit
import CoreData


let appDelegate = UIApplication.shared.delegate as! AppDelegate
func viewContext() -> NSManagedObjectContext {
    return appDelegate.persistentContainer.viewContext
}


func saveFavUser(user:UserList.FetchUsers.ViewModel.DisplayedUser?){
    let context = viewContext()
    let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
    let newUser = NSManagedObject(entity: entity!, insertInto: context)
    newUser.setValue(user?.name, forKey: "username")
    newUser.setValue(user?.profilePic, forKey: "picture")
    newUser.setValue(user?.location, forKey: "location")
    do {
        appDelegate.saveContext()
    } catch {
    }
}

func getFav() -> [FavUsers]{
    let context = viewContext()
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
    var userList = [FavUsers]()
    do {
        let result = try context.fetch(request)
        for data in result as! [NSManagedObject] {
            print(data.value(forKey: "picture") as! String)
            var userobj = FavUsers()
            if let username = data.value(forKey: "username") as? String {
                userobj.username = username
            }
            if let location = data.value(forKey: "location") as? String {
                userobj.location = location
            }
            if let picture = data.value(forKey: "picture") as? String {
                userobj.picture = picture
            }
            userList.append(userobj)
        }
    } catch {
        
    }
    return userList
}
