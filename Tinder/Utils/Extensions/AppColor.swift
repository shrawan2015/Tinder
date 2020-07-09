//
//  AppColor.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation
import UIKit

@objc extension UIColor {
    static let backgroundWhiteBlue      = #colorLiteral(red: 0.9882352941176471, green: 0.9882352941176471, blue: 1.0, alpha: 1.0)  // hex color #RGB =  #FCFCFF    alpha 1.0
    static let buttonTitleBlue          = #colorLiteral(red: 0.00784313725490196, green: 0.5098039215686274, blue: 0.9411764705882353, alpha: 1.0)  // hex color #RGB =  #0282F0    alpha 1.0
}
extension UIColor{
    static func returnRGBColor(r:CGFloat, g:CGFloat, b:CGFloat, alpha:CGFloat) -> UIColor{
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: alpha)
    }
}


