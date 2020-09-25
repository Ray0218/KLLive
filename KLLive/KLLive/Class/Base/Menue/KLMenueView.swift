//
//  KLMenueView.swift
//  KLLive
//
//  Created by WKL on 2020/9/19.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit



protocol KLMenueDataSource : class  {
    
    
    func numberOfSections(in menueView : KLMenueView) -> Int
    
    func menueCollectionView(_ menueView: KLMenueView, numberOfItemsInSection section: Int) -> Int
    
    
    func menueCollectionView(_ menueView: KLMenueView,collectionView : UICollectionView,  cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    
 
}

protocol KLMenueDataDelegate : class {
    func menueCollectionView(_ menueView: KLMenueView, didSelectItemAt indexPath: IndexPath)
}


class KLMenueView: UIView {
    
    weak var dataSource : KLMenueDataSource?
    weak var delegate : KLMenueDataDelegate?

    var rTitles : [String]
    var rTitleStyle : KLMenueTitleStyle
    var rLayout : KLMenueLayout
    
    
    var rTitleView: KLMenueTitleView!
    
    var rCollectionView: UICollectionView!
    var rPageControl: UIPageControl!
    
    var rSourceIndexPath : IndexPath = IndexPath(item: 0, section: 0)
    
    
    
    init(frame: CGRect, titles : [String], titleStyle : KLMenueTitleStyle,layout : KLMenueLayout) {
        
        rTitles = titles
        rTitleStyle = titleStyle
        rLayout = layout
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}


extension KLMenueView {
    
    
    func  setupUI ()  {
        
        //创建TitleView
        let titleY = rTitleStyle.rIsTitleTop ? 0 : bounds.height - rTitleStyle.rTitleHeight
        
        let titleFrame = CGRect(x: 0, y: titleY, width: kScreenW, height: rTitleStyle.rTitleHeight)
        
        rTitleView = KLMenueTitleView(frame: titleFrame, titles: rTitles, style: rTitleStyle)
        
        rTitleView.delegate = self
        addSubview(rTitleView)
        
        
        //创建pageController
        
        let pageY = rTitleStyle.rIsTitleTop ? bounds.height - 20 : bounds.height - rTitleStyle.rTitleHeight - 20
        let pageFrame = CGRect(x: 0, y: pageY, width: kScreenW, height: 20)
        
        let pageControl = UIPageControl(frame: pageFrame)
        pageControl.numberOfPages = 4
                pageControl.hidesForSinglePage = true 
        pageControl.isEnabled = false
        
        addSubview(pageControl)
        
        
        
        //创建collectionView
        
        let collectionFrame = CGRect(x: 0, y: rTitleStyle.rIsTitleTop ? rTitleStyle.rTitleHeight : 0, width: kScreenW, height: bounds.height - rTitleStyle.rTitleHeight - 20)
        let collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: rLayout)
        
        //        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kMenueCellId)
        
        //        collectionView.backgroundColor = UIColor.randomColor()
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        addSubview(collectionView)
        
        rCollectionView = collectionView
        rPageControl = pageControl
        
        
    }
}


extension KLMenueView {
    
    func register (cell : AnyClass, identify : String) {
        
        rCollectionView.register(cell.self, forCellWithReuseIdentifier: identify)
    }
    
    
    func register (nib  : UINib, identify : String) {
        
        rCollectionView.register(nib, forCellWithReuseIdentifier: identify)
    }
    
}

extension KLMenueView : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSections(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let itemCount =  dataSource?.menueCollectionView(self, numberOfItemsInSection: section) ?? 0
        
        
        if section == 0 {
            rPageControl.numberOfPages = (itemCount - 1)/(rLayout.column*rLayout.rows) + 1
        }
        
        
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenueCellId, for: indexPath)
        //
        //        cell.contentView.backgroundColor = UIColor.randomColor()
        //
        return dataSource!.menueCollectionView(self,collectionView: collectionView , cellForItemAt: indexPath)
        
    }
    
    
}


extension KLMenueView : UICollectionViewDelegate{
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          
        
        delegate?.menueCollectionView(self, didSelectItemAt: indexPath)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        endScroll()
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !decelerate {
            endScroll()
        }
    }
    
    func endScroll () {
        
        let point = CGPoint(x: rLayout.sectionInset.left + 1 + rCollectionView.contentOffset.x, y: rLayout.sectionInset.top + 1)
        
        guard let indexPath = rCollectionView.indexPathForItem(at: point) else { return  }
        
        
        if rSourceIndexPath.section != indexPath.section  {
            
            
            
            let itemCount =  dataSource?.menueCollectionView(self, numberOfItemsInSection: indexPath.section) ?? 0
            
            rPageControl.numberOfPages = (itemCount - 1)/(rLayout.column*rLayout.rows) + 1
            
            //修改标题选中位置
            rTitleView.adjustTitleLabel(targetIndex: indexPath.section)
            
            rSourceIndexPath = indexPath
        }
        
        
        rPageControl.currentPage = indexPath.item  / (rLayout.rows * rLayout.column)
        
        
    }
    
}


extension KLMenueView : KLMenueTitleDelegate{
    func titleViewChange(_ titleView: KLMenueTitleView, index: Int) {
        
        
        let indexPath = IndexPath(item: 0, section: index)
        
        rCollectionView.scrollToItem(at: indexPath, at: .left, animated: false)
        
        rCollectionView.contentOffset.x -= rLayout.sectionInset.left
        
        endScroll()
        
    }
    
    
}


