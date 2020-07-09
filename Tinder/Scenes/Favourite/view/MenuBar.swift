//
//  MenuBar.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 28/06/20.
//  Copyright © 2020 Shrawan. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    func addConstraintsWithFormat(format:String, views: UIView...){
        var viewsDictionary = [String:UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

class BaseCell:UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    func setUpViews(){
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MenuBar:UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    var delegate:SelectItem?
    lazy var collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.clear
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let reuseIdentifier = "Cell"
    let imageNames = ["person", "calendar", "location" , "phone" , "password"]
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        fatalError("init(coder:) has not been implemented")
             collectionView.register(MenuCell.self, forCellWithReuseIdentifier: reuseIdentifier)
              addSubview(collectionView)
              addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
              addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.itemSelect(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        cell.imageView.tintColor = UIColor.gray
        cell.borderView.tintColor = .clear
        collectionView.selectItem(at: IndexPath(item:2, section:0), animated: false, scrollPosition:[])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return Utility.shared.CGSizeMake(frame.width/5, frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
  
}

class MenuCell:BaseCell{
    
    var imageView:UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    var borderView:UIView = {
        let view = UIView()
        return view
    }()
    
    override var isHighlighted: Bool{
        didSet{
            imageView.tintColor = isHighlighted ? UIColor.returnRGBColor(r: 150, g: 181, b: 98, alpha: 1) :UIColor.gray
            borderView.backgroundColor = isHighlighted ? UIColor.returnRGBColor(r: 150, g: 181, b: 98, alpha: 1) :UIColor.clear
        }
    }
    
    override var isSelected: Bool{
        didSet{
            imageView.tintColor = isSelected ?  UIColor.returnRGBColor(r: 150, g: 181, b: 98, alpha: 1) : UIColor.gray
            borderView.backgroundColor = isSelected ? UIColor.returnRGBColor(r: 150, g: 181, b: 98, alpha: 1) :UIColor.clear

        }
    }
    
    override func setUpViews() {
        super.setUpViews()
        addSubview(imageView)
        addSubview(borderView)
        addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(2)]", views: borderView)

        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: borderView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: borderView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: borderView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: 0))


    }
}
