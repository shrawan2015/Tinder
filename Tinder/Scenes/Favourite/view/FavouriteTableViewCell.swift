//
//  FavouriteTableViewCell.swift
//  Tinder
//
//  Created by ShrawanKumar Sharma on 27/06/20..
//  Copyright © 2020 Shrawan. All rights reserved.
//

import UIKit

protocol SelectItem {
    func itemSelect(index:Int)
}

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profilePic: CustomImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    var user: FavUsers! {
      didSet {
        address.text = user.location
        name.text = user.username
        setupThumbnailImage()
      }
    }
    
    func setupThumbnailImage() {
           guard let picture = user?.picture else { return }
           profilePic.loadImageUsingUrlString(urlString: picture)
       }
       

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
      
}
