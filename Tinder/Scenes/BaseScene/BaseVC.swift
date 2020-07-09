//
//  BaseVC.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation
import UIKit

class BaseVC: UIViewController {
    fileprivate var gestureRecognizer: UITapGestureRecognizer?

    //MARK:- loader
    var loaderCount = 0
    let loaderView: UIView = {
           let container = UIView()
           container.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
           return container
       }()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        //self.hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //self.hidesBottomBarWhenPushed = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
            if let bottomSafeArea = UIApplication.shared.keyWindow?.safeAreaInsets.bottom, bottomSafeArea > 0 {
                for subview in view.subviews {
                    if let subview = subview as? UITableView {
                        subview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
                    }
                }
            }
        }
        
        edgesForExtendedLayout = []
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        self.extendedLayoutIncludesOpaqueBars = true
        print("Screen Name \(self)")
        showNavigationShadow()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
}

extension BaseVC {
    
    func hideNavigationShadow() {
        self.navigationController?.navigationBar.layer.cornerRadius = 0
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 1
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.navigationController?.navigationBar.layer.shadowRadius = 0.0
    }
    
    func showNavigationShadow() {
        self.navigationController?.navigationBar.layer.cornerRadius = 6
        self.navigationController?.navigationBar.layer.shadowColor = #colorLiteral(red: 0.13, green: 0.13, blue: 0.13, alpha: 0.24)
        self.navigationController?.navigationBar.layer.shadowOpacity = 1
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.navigationController?.navigationBar.layer.shadowRadius = 4
    }
    
    func addTap() {
        if let gestureRecog = gestureRecognizer {
            view.removeGestureRecognizer(gestureRecog)
        }
        
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseVC.tapped(tap:)))
        gestureRecognizer?.cancelsTouchesInView = false
        view.addGestureRecognizer(gestureRecognizer!)
    }
    
    @objc func removeTap() {
        guard let gestureRecognizer = gestureRecognizer else {
            return
        }
        
        view.removeGestureRecognizer(gestureRecognizer)
        self.gestureRecognizer = nil
    }
    
    @objc func tapped(tap: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func addLoader() {
        removeLoader()
        UIApplication.shared.beginIgnoringInteractionEvents()
        UIApplication.shared.delegate?.window??.addSubview(loaderView)
    }
    
    func removeLoader() {
        if UIApplication.shared.isIgnoringInteractionEvents{
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        loaderView.removeFromSuperview()
    }
}

//MARK: - Routing Logic
extension BaseVC {
    func setAsRootFrom(vc: UIViewController?, with newVC: UIViewController) {
        let navVC = vc?.navigationController
        navVC?.setViewControllers([newVC], animated: true)
    }
}
