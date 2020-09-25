//
//  KLHomeCollectionController.swift
//  KLLive
//
//  Created by WKL on 2020/9/17.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

fileprivate let kWaterCellID = "kWaterCellID"
let kItemMargin : CGFloat = 10

class KLHomeCollectionController: UIViewController {
    
    var rType : Int? {
        
        didSet{
            
        }
    }
    
    
    lazy var rCollectionView : UICollectionView = {
        
        let layout = KLWaterLayout()
        layout.dataSource = self
        layout.minimumLineSpacing = kItemMargin
        layout.minimumInteritemSpacing = kItemMargin
 
        let collectionView  = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
//        collectionView.register(HomeViewCell.self, forCellWithReuseIdentifier: kWaterCellID)
        
        collectionView.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: kWaterCellID)

//        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        
        
        collectionView.autoresizingMask = UIView.AutoresizingMask.flexibleHeight
        
        if #available(iOS 11.0, *) {
                   collectionView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
               } else {
                   // Fallback on earlier versions
            
            automaticallyAdjustsScrollViewInsets = false;

               }
 
        return collectionView
        
    }()
    
   fileprivate lazy var rVModel : KLHomeViewModel = KLHomeViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false

        // Do any additional setup after loading the view.
        setupUI()
        
 loadData(index: 0)
       
    }
    
    
}


extension KLHomeCollectionController {
 
    func loadData (index : Int)  {
        
        print("开始网络请求 \(index)")
        rVModel.loadHomeData(type: rType!, index: index) {
             
            self.rCollectionView.reloadData()
        }
    }
    
}

//MARK:- UICollectionViewDataSource
extension KLHomeCollectionController : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rVModel.rModelsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kWaterCellID , for: indexPath) as! HomeViewCell
        
        

        cell.anchorModel =  rVModel.rModelsArray[indexPath.item]
        
        
        
 
        if indexPath.item == rVModel.rModelsArray.count - 1  &&  rVModel.rModelsArray.count < rVModel.rTotalCount{
            loadData(index: rVModel.rModelsArray.count)
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
        
        let vc = KLRoomViewController()
        
        vc.rAnchorModel = rVModel.rModelsArray[indexPath.item]
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


//MARK:- UI
extension KLHomeCollectionController  {
    
    
    fileprivate func setupUI () {
        
        view.addSubview(rCollectionView)
        
    }
    
}


extension KLHomeCollectionController : KLWaterLayoutDataSource  {
    func numberOfColumnCount(_ waterLayout: KLWaterLayout) -> Int {
        return 2
    }
    
    func heightForItem(_ waterLayout: KLWaterLayout, item: Int) -> CGFloat {
        return  item % 2 == 0 ? kScreenW * 2 / 3 : kScreenW * 0.5
    }
    
   
    
}
