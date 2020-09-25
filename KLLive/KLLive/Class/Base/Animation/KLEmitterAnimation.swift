//
//  KLEmitterAnimation.swift
//  KLLive
//
//  Created by WKL on 2020/9/18.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

protocol KLEmitterAnimation: class  {
    
}


extension KLEmitterAnimation {
    
    func createAnimation (point : CGPoint, parentLayer : CALayer)  {
        
        guard   parentLayer.sublayers?.filter({$0.isKind(of: CAEmitterLayer.self)}).count==0 else {return}
        
        //创建发射器
        let emitter = CAEmitterLayer()
        
        //开启三维效果
        emitter.preservesDepth = true
        
        emitter.emitterPosition = point
        
        //创建粒子
        var   cells : [CAEmitterCell] = [CAEmitterCell]()
        for i in 0..<9 {
            let cell = CAEmitterCell()
            
            //粒子速度
            cell.velocity = 250
            //        粒子速度波动范围
            cell.velocityRange = 100
            
            //z粒子大小
            cell.scale = 0.7
            cell.scaleRange = 0.3
            
            //旋转
            cell.spin = .pi
            cell.spinRange = .pi
            
            //方向
            cell.emissionLongitude = -.pi/2
            cell.emissionRange = .pi/4
            
            //每秒弹出个数
            cell.birthRate = 10
            
            //存活时间
            cell.lifetimeRange = 8.0
            cell.lifetimeRange = 3.5
            
            //图片
            cell.contents = UIImage(named: "good\(i)_30x30")?.cgImage
            cells.append(cell)
        }
        
        
        emitter.emitterCells = cells
        
        parentLayer.addSublayer(emitter)
        
    }
    
    func stopMmitter(parentLayer : CALayer )  {
        
        
        let layers =   parentLayer.sublayers?.filter({$0.isKind(of: CAEmitterLayer.self)})
        
        layers?.first?.removeFromSuperlayer()
        
    }
    
    
}
