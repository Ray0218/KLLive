//
//  HomeViewCell.swift
//  XMGTV
//
//  Created by 唐三彩 on 2017/6/7.
//  Copyright © 2017年 唐三彩. All rights reserved.
//

import UIKit

 
class HomeViewCell: UICollectionViewCell {

    // MARK: 控件属性
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var liveImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlinePeopleLabel: UIButton!
    
    
    // MARK: 定义属性
    var anchorModel : KLAnchorModel? {
        didSet {
//            albumImageView.setImage(  anchorModel?.pic51, "home_pic_default")
        
            albumImageView.kf.setImage(with: URL(string: anchorModel?.pic51 ?? "")   , placeholder: UIImage(named: "home_pic_default"))
 
            liveImageView.isHidden = anchorModel?.live == 0
            nickNameLabel.text = anchorModel?.name
            onlinePeopleLabel.setTitle("\(anchorModel?.focus ?? 0)", for: .normal)
        }
    }

}
