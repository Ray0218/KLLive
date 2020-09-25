//
//  UIImageView-Extension.swift
//  KLLive
//
//  Created by WKL on 2020/9/18.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    
    func setImage(with urlString: String? , placeHolderName: String? = nil)  {
        
        
        guard placeHolderName != nil else {
            
            
            guard let urlStr = urlString else { return }
            guard let url = URL(string: urlStr) else {  return  }
            kf.setImage(with: url)
            
            return
        }
        
        guard let urlStr = urlString else { return }
        guard let url = URL(string: urlStr) else {return }
        
        kf.setImage(with: url, placeholder: UIImage(named:placeHolderName!))
        
    }
    
}
