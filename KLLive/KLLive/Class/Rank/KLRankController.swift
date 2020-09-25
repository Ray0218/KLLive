//
//  KLRankController.swift
//  KLLive
//
//  Created by WKL on 2020/9/16.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit


fileprivate let kMenueCellId = "kMenueCellId"

class KLRankController: UIViewController {
    
    
    lazy var rGiftModel : KLGiftViewModel = KLGiftViewModel()
    
    var rMenueView : KLMenueView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "排行"
        
        // Do any additional setup after loading the view.
        
        let style = KLMenueTitleStyle()
        style.rIsTitleTop = true
        
        let layout = KLMenueLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let mu =  KLMenueView(frame: CGRect(x: 0, y: 150, width: kScreenW, height: 250), titles: ["热门", "高级", "豪华"], titleStyle: style, layout: layout)
        
         mu.register(nib: UINib(nibName: "KLGiftCell", bundle: nil), identify: kMenueCellId)

        mu.dataSource = self
        rMenueView = mu
        
        view.addSubview(mu)
        
        
        rGiftModel.loadGiftData {
            
            self.rMenueView.rCollectionView.reloadData()
               }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}



extension KLRankController : KLMenueDataSource {
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
