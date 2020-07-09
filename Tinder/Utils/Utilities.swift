//
//  Utilities.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation
import UIKit
import MMMaterialDesignSpinner

class Utilities: NSObject {
    static var spinnerView: MMMaterialDesignSpinner {
        get {
            let sv: MMMaterialDesignSpinner = MMMaterialDesignSpinner(frame: CGRect(x: (UIScreen.main.bounds.width - 50)/2, y: (UIScreen.main.bounds.height - 50)/2, width: 49, height: 49))
            sv.lineWidth = 2.0
            sv.tintColor = UIColor.buttonTitleBlue
            return sv
        }
    }
    
    static func addLoader(onView: UIView? = UIApplication.shared.keyWindow, count: inout Int, isInteractionEnabled: Bool) {
        print("addLoader: count is \(count)")
        guard let onView = onView else {
            return
        }
        
        if count == 0 {
            if let view = onView as? UIWindow {
                let mask = UIView()
                mask.tag = 998
                mask.frame = view.bounds
                mask.backgroundColor = UIColor.backgroundWhiteBlue.withAlphaComponent(0.1)
                addActivityIndicator(onView: mask)
                view.addSubview(mask)
            } else {
                addActivityIndicator(onView: onView)
            }
        }
        
        guard let view = onView.viewWithTag(999) else {
            return
        }
        
        onView.isUserInteractionEnabled = isInteractionEnabled
        
        onView.bringSubviewToFront(view)
        count = count + 1
    }
    
    @discardableResult
    static func removeLoader(fromView: UIView? = UIApplication.shared.keyWindow, count: inout Int) -> Bool {
        print("removeLoader: count is \(count)")
        
        guard let fromView = fromView else {
            return false
        }
        
        count = count - 1
        if count < 0 {
            count = 0
        }
        
        if count == 0 {
            fromView.isUserInteractionEnabled = true
            if let view = fromView as? UIWindow {
                view.viewWithTag(998)?.removeFromSuperview()
            }
            fromView.viewWithTag(999)?.removeFromSuperview()
        }
        
        return count == 0
    }
    
    static func addActivityIndicator(onView: UIView) {
        
        let spinnerView1: MMMaterialDesignSpinner = spinnerView
        spinnerView1.tag = 999
        spinnerView1.startAnimating()
        onView.addSubview(spinnerView1)
    }
    
    static func showAlert(on vc: UIViewController, title:String = "", message: String, action1:String = "Ok", action2:String? = nil, completion1:  ((UIAlertAction)->Void)? = nil , completion2:  ((UIAlertAction)->Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action1, style: .default, handler: completion1))

        if action2 != nil {
            alert.addAction(UIAlertAction(title: action2, style: .cancel, handler: completion2))
        }
        vc.present(alert, animated: true)
    }
    
}


final class Utility: NSObject {
    private override init() { }
    static let shared = Utility()
    
    func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    func CGSizeMake( _ width:CGFloat, _ height:CGFloat) -> CGSize{
        return CGSize(width: width, height: height)
    }
}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = 2.0
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
}


extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.locale = Locale(identifier: "en_US")

        return dateFormatter.string(from: date)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
