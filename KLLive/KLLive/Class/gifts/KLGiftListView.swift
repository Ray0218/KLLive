//
//  KLGiftListView.swift
//  KLLive
//
//  Created by WKL on 2020/9/22.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit
fileprivate let kMenueCellId = "kMenueCellId"

class KLGiftListView: UIView , KLNibLoadable{
    
    @IBOutlet weak var rGiftView: UIView!
    @IBOutlet weak var rSendGiftBtn: UIButton!
    lazy var rGiftModel : KLGiftViewModel = KLGiftViewModel()
    var rMenueView : KLMenueView!
    
    override  func awakeFromNib() {
        super.awakeFromNib()
        
        setupGiftView()
        
    }
    
    
    
}

extension KLGiftListView{
    
    
    fileprivate func setupGiftView() {
        
        let style = KLMenueTitleStyle()
        style.rIsTitleTop = true
        style.rNornalColor = UIColor(r: 255, g: 255, b: 255)

        
        let layout = KLMenueLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 5
               layout.minimumInteritemSpacing = 5
        
//        let mu =  KLMenueView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: bounds.height), titles: ["热门", "高级", "豪华", "专属"], titleStyle: style, layout: layout)
        
        let mu =  KLMenueView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: rGiftView.bounds.height), titles: ["热门", "高级", "豪华"], titleStyle: style, layout: layout)

        mu.register(nib: UINib(nibName: "KLGiftCell", bundle: nil), identify: kMenueCellId)
        
        mu.dataSource = self
        mu.delegate = self
        rMenueView = mu
        
        rGiftView.addSubview(mu)
        
        
        rGiftModel.loadGiftData {
            
            self.rMenueView.rCollectionView.reloadData()
        }
        
    }
    
    
}


extension KLGiftListView  : KLMenueDataSource {
    func numberOfSections(in menueView: KLMenueView) -> Int {
        return self.rGiftModel.rListModels.count
    }
    
    func menueCollectionView(_ menueView: KLMenueView, numberOfItemsInSection section: Int) -> Int {
        
        self.rGiftModel.rListModels[section].list?.count ?? 0
    }
    
    
    func menueCollectionView(_ menueView: KLMenueView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = menueView.rCollectionView.dequeueReusableCell(withReuseIdentifier: kMenueCellId, for: indexPath) as! KLGiftCell
        
        cell.rModel = self.rGiftModel.rListModels[indexPath.section].list![indexPath.item]
        return cell
    }
    
    
}

extension KLGiftListView : KLMenueDataDelegate {
    
    
    func menueCollectionView(_ menueView: KLMenueView, didSelectItemAt indexPath: IndexPath) {
         
        
      let   rModel = self.rGiftModel.rListModels[indexPath.section].list![indexPath.item]
 
        print(rModel.subject)
        
    }
    
}
