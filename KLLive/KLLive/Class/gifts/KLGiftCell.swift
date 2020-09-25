//
//  KLGiftCell.swift
//  KLLive
//
//  Created by WKL on 2020/9/22.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLGiftCell: UICollectionViewCell {

    @IBOutlet weak var rImageView: UIImageView!
    @IBOutlet weak var rTitleLabel: UILabel!
    @IBOutlet weak var rPriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let selectedView = UIView()
              selectedView.layer.cornerRadius = 5
              selectedView.layer.masksToBounds = true
              selectedView.layer.borderWidth = 1
              selectedView.layer.borderColor = UIColor.orange.cgColor
              selectedView.backgroundColor = UIColor.black
              
              selectedBackgroundView = selectedView
    }

    
    var rModel : KLGiftModel?{
        
        didSet{
            
            rImageView.setImage(with: rModel?.img2, placeHolderName: "room_btn_gift")
            rTitleLabel.text = rModel?.subject
            rPriceLabel.text = "\(rModel?.coin ?? 0)"
            
        }
    }
}
