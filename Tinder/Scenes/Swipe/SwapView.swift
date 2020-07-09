//
//  SwapView.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation

extension SwipeViewController{
    func resetFormFields(){
        userHeading.text = ""
        userDescription.text = ""
        self.profilePic.image = nil
    }
    
    func itemSelect(index: Int) {
        switch index {
        case 0:
            userHeading.text = "Hi, My name is"
            userDescription.text = user?.name
        case 1:
            userHeading.text = "My birthday is"
             userDescription.text = user?.dob
        case 2:
            
            userHeading.text = "My address is"
            userDescription.text =    user?.location
        case 3:
            userHeading.text = "My phone number is"
            userDescription.text = user?.phoneNumber
        case 4:
            
            userHeading.text = "My password is"
            userDescription.text = user?.password
        default:
            self.userHeading.text = ""
            self.userDescription.text = ""
        }
    }
    
}
