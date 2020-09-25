//
//  KLTitleView.swift
//  KLLive
//
//  Created by WKL on 2020/9/16.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

//加class表示当前协议只能被类遵守
protocol KLTitleDelegate : class {
    
    func titleViewChange(_ titleView : KLTitleView, index: Int)
    
}

class KLTitleView: UIView {
    
    var rTitles : [String]
    
    
    var rCurrentIndex  : Int = 0
    
    
    var rTitleLabels  = [UILabel]()
    
    var rStyle  : KLTitleStyle
    
    weak  var delegate : KLTitleDelegate?
    
    lazy var rScrollView : UIScrollView = {
        let scrolView = UIScrollView(frame: self.bounds)
        
        scrolView.bounces = false
        scrolView.scrollsToTop = false
        
        return  scrolView
        
    }()
    
    lazy var rBottomLine : UIView = {
        let lineView  =  UIView()
        
        lineView.backgroundColor = self.rStyle.rLineColor
        lineView.frame.size.height = self.rStyle.rBottomLineHeight
        lineView.frame.origin.y =  self.bounds.height -  self.rStyle.rBottomLineHeight
        
        
        return  lineView
        
    }()
    
    
    init(frame: CGRect, titles: [String], style: KLTitleStyle) {
        
        rTitles = titles
        rStyle = style
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension KLTitleView {
    
    func setupUI () {
        
        
        self.backgroundColor = .white

        for (index , titile ) in rTitles.enumerated(){
            
            let label =  createLabel(title: titile )
            
            if index == 0 {
                label.textColor = rStyle.rSelectColor
            }
            
            label.tag = index
            
            rScrollView.addSubview(label)
            rTitleLabels.append(label)
            
        }
        
        addSubview(rScrollView)
        
        setupTitleLabelsFrame()
        
        if rStyle.rShowBottomLine {
            rScrollView.addSubview(rBottomLine)
        }
        
    }
    
    
    func setupTitleLabelsFrame() {
        
        
        var w : CGFloat = 0
        var x : CGFloat = 0
        
        
        var  preLabel : UILabel!
        
        for (index , label ) in rTitleLabels.enumerated(){
            
            
            if rStyle.rScrollEnable {
                
                w = (rTitles[index] as NSString).boundingRect(with: CGSize(width:  CGFloat(MAXFLOAT), height: 0), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font:label.font!], context: nil).width
                if index == 0 {
                    x = rStyle.rItemMargin * 0.5
                    
                    rBottomLine.frame.origin.x = x
                    rBottomLine.frame.size.width = w
                }else {
                    x = preLabel.frame.maxX + rStyle.rItemMargin
                }
                
            }else {
                x = w * CGFloat(index)
                w = bounds.width / CGFloat(rTitles.count)
                
                if index == 0 {
                    rBottomLine.frame.origin.x = 0
                    rBottomLine.frame.size.width = w
                }
                
            }
            
            label.frame = CGRect(x: x, y: 0, width: w, height: bounds.height)
            
            preLabel = label
            
        }
        
        
        if  rStyle.rScrollEnable {
            
            rScrollView.contentSize = CGSize(width: preLabel.frame.maxX + rStyle.rItemMargin * 0.5, height: 0)
            
        }else {
            rScrollView.contentSize = CGSize(width: preLabel.frame.maxX, height: 0)
            
        }
        
    }
    
    func createLabel (title: String ) -> UILabel {
        let lab = UILabel()
        lab.text = title
        lab.font = rStyle.rFont
        lab.textAlignment = .center
        lab.textColor =  rStyle.rNornalColor
        //        lab.backgroundColor = UIColor.randomColor()
        lab.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pvt_select(_:))))
        lab.isUserInteractionEnabled = true
        return lab
    }
}




//MARK:- action
extension KLTitleView {
    
    @objc func pvt_select(_ gesture : UITapGestureRecognizer) {
        
        let targetLab = gesture.view as! UILabel
        targetLab.textColor = rStyle.rSelectColor
        
        if rCurrentIndex != targetLab.tag {
            
            adjustTitleLabel(targetIndex: targetLab.tag)
            
            //通知
            delegate?.titleViewChange(self, index: rCurrentIndex)
            
            if rStyle.rShowBottomLine {
                
                
                UIView.animate(withDuration: 0.25) {
                    
                    self.rBottomLine.frame.origin.x = targetLab.frame.origin.x
                    self.rBottomLine.frame.size.width = targetLab.bounds.width
                }
            }
            
            
        }
        
    }
    
    func adjustTitleLabel(targetIndex : Int)  {
        
        let targetLab = rTitleLabels[targetIndex]
        
        rTitleLabels[rCurrentIndex].textColor = rStyle.rNornalColor
        
        targetLab.textColor = rStyle.rSelectColor
        
        
        rCurrentIndex = targetIndex
        
        
        if rStyle.rScrollEnable {
            var  offX = targetLab.center.x - rScrollView.bounds.width * 0.5
            if offX < 0{
                offX = 0
            }else   if offX > rScrollView.contentSize.width - rScrollView.bounds.width {
                offX = rScrollView.contentSize.width - rScrollView.bounds.width
            }
            
            rScrollView.setContentOffset(CGPoint(x: offX, y: 0), animated: true)
        }
        
        
        
    }
}


extension KLTitleView: KLContentDelegate{
    func contentChange(contetView: KLContentView, targetIndec: Int) {
        
        
        if targetIndec != rCurrentIndex {
            adjustTitleLabel(targetIndex: targetIndec)
            
        }
        
    }
    
    func contentChange(contetView: KLContentView, curIndex: Int , targetIndex: Int, progress: CGFloat) {
        
        
        guard curIndex != targetIndex else {
            return
        }
        let targetLabel = rTitleLabels[targetIndex]
        let curLable = rTitleLabels[curIndex]
        
        
        //颜色渐变
        let deltaRGB = UIColor.getRGBDelta (rStyle.rSelectColor, rStyle.rNornalColor)
        
        
        let seleRGB = rStyle.rSelectColor.getRGBArr()
        let normalRGB = rStyle.rNornalColor.getRGBArr()
        
        
        targetLabel.textColor = UIColor(r: normalRGB.r + deltaRGB.0 * progress, g: normalRGB.g + deltaRGB.1 * progress, b: normalRGB.b + deltaRGB.2 * progress)
        
        curLable.textColor = UIColor(r: seleRGB.r -  deltaRGB.0 * progress  , g: seleRGB.g - deltaRGB.1 * progress , b: seleRGB.b - deltaRGB.2 * progress)
        
        
        
        
        //MARK:底部线
        if rStyle.rShowBottomLine{
            
            let delW = targetLabel.bounds.width - curLable.bounds.width
            
            let delX = targetLabel.frame.origin.x - curLable.frame.origin.x
            
            let lineW =  curLable.bounds.width + delW * progress
            let lineX = curLable.frame.origin.x + delX * progress
            
            rBottomLine.frame.origin.x = lineX
            rBottomLine.frame.size.width = lineW
            
            
        }
        
        
        if rStyle.rScrollEnable {
            var  offX = targetLabel.center.x - rScrollView.bounds.width * 0.5
            if offX < 0{
                offX = 0
            }else   if offX > rScrollView.contentSize.width - rScrollView.bounds.width {
                offX = rScrollView.contentSize.width - rScrollView.bounds.width
            }

            rScrollView.setContentOffset(CGPoint(x: offX, y: 0), animated: true)
        }
        
        
        
        
        rCurrentIndex = targetIndex
        
    }
    
    
    
    
}
