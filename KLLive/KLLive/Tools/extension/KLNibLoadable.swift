//
//  KLNibLoadable.swift
//  KLLive
//
//  Created by WKL on 2020/9/18.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit


protocol KLNibLoadable {
    
 
}

//where Self : UIView 当前方法只能UIView用
// static 类方法  在协议中b无法使用class 用static 代替

extension KLNibLoadable where Self : UIView {
    
    static func loadFromNib(nibName : String? = nil) -> Self  {
        
        let loadName = nibName ?? "\(self)"
        
        return Bundle.main.loadNibNamed(loadName, owner: nil , options: nil)?.first as! Self
    }
    
}


