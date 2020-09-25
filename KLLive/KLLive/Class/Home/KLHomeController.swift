//
//  KLHomeController.swift
//  KLLive
//
//  Created by WKL on 2020/9/16.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

 class KLHomeController: UIViewController {
    
    
    
    lazy var rPageView : KLTitlePageView = {
        
        let modes = self.getTitlesArray()
        
        
        var childVC = [KLHomeCollectionController]()
        for mode in modes {
            
            let vc = KLHomeCollectionController()
            vc.rType = mode.type
            childVC.append(vc)
        }
        
        let style = KLTitleStyle()
        style.rScrollEnable = true
        style.rItemMargin = 15.0
        
         let pageFrame = CGRect(x: 0, y: kNavigationBarH + kStatusBaarH, width: kScreenW, height: kScreenH - kNavigationBarH - kStatusBaarH - kTabbarH)
        
        
        let pageView = KLTitlePageView(frame: pageFrame, titiles: modes.map({$0.title}), childsVCs: childVC, parentVC: self , style: style)
        return pageView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        edgesForExtendedLayout = []
    navigationController?.navigationBar.isTranslucent = false

        
 
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.randomColor()
        
        setNavigationBar()
        
        
        setupUI()
        
      }
    
    
    func getTitlesArray() -> [KLHomeTitleModel]  {
        
        
        guard  let path =  Bundle.main.path(forResource: "types", ofType: "plist") else {return []}
        guard  let jsonArr =  NSArray(contentsOfFile: path) else {return []}
 
        let decoder = JSONDecoder()
 
        
    return  try! decoder.decode(Array<KLHomeTitleModel>.self, from: JSONSerialization.data(withJSONObject: jsonArr, options: []))
                  
    
 
       
 
    }
     

}



extension KLHomeController {
    
    func setNavigationBar( )  {
         
         navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "home-logo")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_btn_follow"), style: .plain, target: self, action: #selector(pvt_search))
    
        
        let searchFrame = CGRect(x: 0, y: 0, width: 200, height: 32)
        let searBar = UISearchBar(frame: searchFrame)
        searBar.placeholder = "主播昵称/房间号/链接"
        searBar.searchBarStyle = .minimal
        searBar.delegate = self

        let searchField = searBar.value(forKey: "_searchField") as? UITextField
        searchField?.textColor = .white
        navigationItem.titleView = searBar
        
    }
    
 
    
  fileprivate  func setupUI()  {
    
    view.addSubview(rPageView)
    rPageView.frame = self.view.bounds
         
    }
    
    
}


extension KLHomeController{
    
    @objc func pvt_search() {
          
      }
}


extension KLHomeController : UISearchBarDelegate{
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}
