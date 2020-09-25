//
//  KLMenueLayout.swift
//  KLLive
//
//  Created by WKL on 2020/9/19.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit




class KLMenueLayout: UICollectionViewFlowLayout {
    
    
    var  column  : Int = 4
    var  rows : Int = 2
    
    lazy var rMaxWidth : CGFloat = 0
    
    fileprivate lazy var rAttributeArr  : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    
    override func prepare() {
        
        super.prepare()
        
        
        rAttributeArr.removeAll()
        
        let itemW = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - CGFloat(column - 1) * minimumInteritemSpacing) / CGFloat(column)
        
        let itemH = (collectionView!.bounds.height - sectionInset.top - sectionInset.bottom - CGFloat(rows - 1) * minimumLineSpacing) / CGFloat(rows)
        
        
        
        let sectionCount = collectionView!.numberOfSections
        
        var  prePage : Int  = 0
        
        for i  in 0..<sectionCount {
            let itemCount = collectionView!.numberOfItems(inSection: i)
            
            
            for j in 0..<itemCount {
                
                
                let indexPageh = IndexPath(item: j, section: i)
                
                let att =  UICollectionViewLayoutAttributes(forCellWith: indexPageh)
                
                //当前是第几页
                let page = j/(column*rows)
                //当前页的位置下标
                let index = j%(column*rows)
                
                
                let itemY = sectionInset.top + (minimumLineSpacing + itemH) * CGFloat(index/column)
                let itemX = sectionInset.left + (minimumInteritemSpacing + itemW) * CGFloat(index%column) + CGFloat(prePage + page) * collectionView!.bounds.width
                
                att.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                
                
                
                rAttributeArr.append(att)
                
            }
            
            prePage += (itemCount-1) / (column*rows) + 1
            
            
        }
        
        rMaxWidth = CGFloat(prePage) * collectionView!.bounds.width
        
    }
    
}


extension KLMenueLayout{
    
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        
        return false
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return rAttributeArr
    }
    
    
    
    
    override var collectionViewContentSize: CGSize{
        
        return CGSize(width: rMaxWidth, height: 0)
        
    }
    
}
