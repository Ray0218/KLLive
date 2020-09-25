//
//  KLTitlePageView.swift
//  KLLive
//
//  Created by WKL on 2020/9/16.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLTitlePageView: UIView {
    
    
    fileprivate  var rTitles : [String]
    fileprivate  var rTitleStyle : KLTitleStyle
    
    fileprivate var rChildVCs : [UIViewController]
    fileprivate var rParentVC : UIViewController
    
     fileprivate var rTitleView : KLTitleView!
    
 
    init(frame: CGRect,titiles: [String] , childsVCs: [UIViewController], parentVC : UIViewController, style: KLTitleStyle) {
        
        
        rTitles = titiles;
        rChildVCs = childsVCs
        rParentVC = parentVC
        rTitleStyle = style
        
        super.init(frame: frame)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



//MARK:- 设置UI界面

extension KLTitlePageView{
    
    
    func setUpUI ()  {
        
        setupTitleView()
        setUpContentView()
        
        
    }
    
    
    func setupTitleView()  {
        
        let titleFrame = CGRect(x: 0, y: 0, width: bounds.width, height: rTitleStyle.rTitleHeight)
        rTitleView = KLTitleView(frame: titleFrame,titles:rTitles,style: rTitleStyle)
        addSubview(rTitleView)
    }
    
    
    
    func  setUpContentView () {
        
        let contentFrame = CGRect(x: 0, y: rTitleView.frame.maxY, width: bounds.width, height:bounds.height -  rTitleStyle.rTitleHeight)
        let contentView = KLContentView(frame: contentFrame,childVC: rChildVCs , parentVC : rParentVC )
        contentView.backgroundColor = UIColor.randomColor()
        addSubview(contentView)
        rTitleView.delegate = contentView
        contentView.delegate = rTitleView

    }
}
