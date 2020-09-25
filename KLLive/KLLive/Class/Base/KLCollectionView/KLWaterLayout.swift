//
//  KLWaterLayout.swift
//  KLLive
//
//  Created by WKL on 2020/9/17.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

protocol KLWaterLayoutDataSource : class  {
    
    
    func numberOfColumnCount( _ waterLayout : KLWaterLayout) -> Int
    
    func heightForItem( _ waterLayout : KLWaterLayout, item: Int) -> CGFloat
    
}

class KLWaterLayout: UICollectionViewFlowLayout {
    
    
    weak var dataSource : KLWaterLayoutDataSource?
    
    fileprivate  lazy var rCellAtts : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    
    lazy  var  colunmCount : Int = {
        
        return (self.dataSource?.numberOfColumnCount(self) ?? 2)
    }()
    
    
    fileprivate lazy  var rMaxHeights : [CGFloat] = Array(repeating: sectionInset.top, count: self.colunmCount)
    
}


//MARK:- 准备布局
extension KLWaterLayout {
    
    
    
    override func prepare() {
        
        
        
        
        
        super.prepare()
        
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        
        let  celW  = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing*CGFloat(colunmCount - 1)) / CGFloat(colunmCount)
        
        
        
        var celX : CGFloat = 0
        var celY : CGFloat = 0
        
        
        
        for i in rCellAtts.count..<itemCount {
            let indexPath = IndexPath(item: i , section: 0)
            
            //         给每个cell创建一个   UICollectionViewLayoutAttributes
            let att = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            //设置att的frame
            
            
            guard let celH = dataSource?.heightForItem(self , item: i) else {
                
                fatalError("请实现heightForItem 方法,并返回对应高度")
            }
            
            celY = rMaxHeights.min()!
            let minIndex = rMaxHeights.firstIndex(of: celY) ?? 0
            
            
            celX = sectionInset.left + (celW+minimumInteritemSpacing)*CGFloat(minIndex)
            att.frame = CGRect(x: celX, y: celY, width: celW, height: celH)
            
            rMaxHeights[minIndex] = att.frame.maxY + minimumLineSpacing
            
            rCellAtts.append(att)
        }
        
    }
    
}




//MARK:- 返回准备好的布局
extension KLWaterLayout {
    
    //        override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    //            return rCellAtts[indexPath.item]
    //        }
    
    //
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return rCellAtts
    }
    
    
}



//MARK:- 设置contentSize
extension KLWaterLayout {
    
    
    override var collectionViewContentSize: CGSize{
        
        return CGSize(width: (collectionView?.bounds.width)!, height: rMaxHeights.max()! + sectionInset.bottom)
    }
    
    
    
    
}
