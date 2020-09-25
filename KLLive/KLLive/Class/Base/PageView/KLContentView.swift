//
//  KLContentView.swift
//  KLLive
//
//  Created by WKL on 2020/9/16.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

fileprivate let kContentCellId = "kContentCellId"


protocol KLContentDelegate : class    {
     
    func contentChange(contetView : KLContentView, targetIndec: Int)
    
    func contentChange(contetView : KLContentView,curIndex : Int , targetIndex: Int,progress: CGFloat)

}

class KLContentView: UIView {
    
    
    fileprivate let   rChildVC : [UIViewController]
    fileprivate let   rParentVC : UIViewController
    
    weak var delegate : KLContentDelegate?
    
    var  rStartOffX : CGFloat = 0.0
    
    var  rIsClick  : Bool = false

    
    lazy var rCollectionView : UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = self.bounds.size
        
        let collectionView  = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellId)
        collectionView.isPagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.bounces = false 
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
        
    }()
    
    
    init(frame: CGRect,childVC : [UIViewController] , parentVC: UIViewController) {
        rChildVC = childVC
        rParentVC = parentVC
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension KLContentView {
    
    func setupUI () {
        
        //将所有子控制器加到父控制器中
        for childVC in rChildVC{
            
            rParentVC.addChild(childVC)
        }
        
        addSubview(rCollectionView)
        
    }
}


extension KLContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rChildVC.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellId, for: indexPath)
        
        
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        
        let rVC = rChildVC[indexPath.item]
        rVC.view.frame = cell.contentView.bounds
        rVC.view.backgroundColor = UIColor.randomColor()
        cell.contentView.addSubview(rVC.view)
        
        
        return cell
    }
    
    
    
}



//MARK:- KLTitleDelegate

extension KLContentView : KLTitleDelegate{
    func titleViewChange(_ titleView: KLTitleView, index: Int) {
         
        let indexPath = IndexPath(item: index, section: 0)
        
        rIsClick = true
        
        rCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    
}



//MARK:- UICollectionViewDelegate
extension KLContentView : UICollectionViewDelegate{
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//         contetViewEndScroll()
//
//    }
//    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//         
//        
//        if !decelerate {
//            contetViewEndScroll()
//        }
//    }
//    
//    
//    
//    //MARK:停止滚动
//    func contetViewEndScroll ()   {
//        
//        guard !rIsClick else {
//             return
//        }
//        
//     let index = Int(rCollectionView.contentOffset.x / rCollectionView.bounds.width)
//
//        delegate?.contentChange(contetView: self, targetIndec: index)
//     }
//    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
         
        rStartOffX = scrollView.contentOffset.x
        rIsClick = false

     }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if rIsClick   {
            return
        }
        
      
//        var targetIndex = 0
//        var progress : CGFloat = 0.0
//
//
//
//        let curIndex = Int(rStartOffX/scrollView.bounds.width)
//
//        if rStartOffX < scrollView.contentOffset.x { //左滑
//
//            targetIndex = curIndex + 1
//
//            if targetIndex > rChildVC.count - 1 {
//                targetIndex = rChildVC.count - 1
//            }
//
//            progress = (scrollView.contentOffset.x - rStartOffX) / scrollView.bounds.width
//
//        } else {
//            targetIndex = max(curIndex -  1, 0)
//
//            progress = (rStartOffX - scrollView.contentOffset.x ) / scrollView.bounds.width
//
//        }
        
        var progress : CGFloat = 0
        var  sourceIndex : Int = 0
        var  targetIndex : Int = 0
        
        let scrolW = scrollView.bounds.width
        
        let currentoffX = scrollView.contentOffset.x ;
        
        if currentoffX > rStartOffX { //左滑
            
            progress = currentoffX/scrolW - floor(currentoffX/scrolW)
            
            sourceIndex = Int(currentoffX/scrolW)
            
            targetIndex = sourceIndex + 1
            if targetIndex >= rChildVC.count - 1 {
                targetIndex = rChildVC.count - 1
            }
            //完全划过去
            if currentoffX - rStartOffX == scrolW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        }else{ //右滑
            
            progress = 1 -  (currentoffX/scrolW - floor(currentoffX/scrolW))
            
            targetIndex =  Int(currentoffX/scrolW)
            
            sourceIndex = targetIndex + 1
            
            
            if sourceIndex >= rChildVC.count - 1 {
                sourceIndex = rChildVC.count - 1
            }
            
        }
        
 
        delegate?.contentChange(contetView: self, curIndex: sourceIndex , targetIndex: targetIndex, progress: progress)
 
        
    }
    
}
