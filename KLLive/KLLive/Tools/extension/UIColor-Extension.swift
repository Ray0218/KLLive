//
//  UIColor-Extension.swift
//  KLDouYu
//
//  Created by WKL on 2020/8/29.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit
extension UIColor {
    //    convenience便利构造函数
    convenience  init(r : CGFloat,g : CGFloat,b : CGFloat) {
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
        
    }
    
    
    convenience init?(hex: String ,alpha: CGFloat = 1.0) {
        
        guard  hex.count >= 6 else { return nil }
        
        var tempHex = hex.uppercased()
        
        if tempHex.hasPrefix("0x") || tempHex.hasPrefix("##") {
            tempHex = (tempHex as NSString).substring(from: 2)
        }
        
        
        if  tempHex.hasPrefix("#") {
            tempHex = (tempHex as NSString).substring(from: 1)
        }
        
        var range = NSRange(location: 0, length: 2)
        
        let rHex = (tempHex as NSString).substring(with: range)
        
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        
        
        var r : UInt32 = 0 , g: UInt32 = 0, b: UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        
        Scanner(string: bHex).scanHexInt32(&b)
        
        
        self.init(r:CGFloat(r), g: CGFloat(g) ,b: CGFloat(b))
        
    }
    
    class func randomColor() -> UIColor{
        
        
        UIColor.init(r: CGFloat(arc4random_uniform(255)), g:CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
        
    }
    
    
    class func getRGBDelta(_ firstColor: UIColor , _ secondColor : UIColor) -> (CGFloat , CGFloat ,CGFloat){
        
        return (firstColor.getRGBArr().r - secondColor.getRGBArr().r , firstColor.getRGBArr().g - secondColor.getRGBArr().g,firstColor.getRGBArr().b - secondColor.getRGBArr().b)
    }
    
    
    func getRGBArr() -> ( r: CGFloat , g: CGFloat ,b : CGFloat) {
            
        
        guard let cmps  = cgColor.components else {
            
            
            fatalError("请传人RGB方式的颜色")
        }
        
        return (cmps[0] * 255,cmps[1] * 255,cmps[2] * 255)
       }
    
}
