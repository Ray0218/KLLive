//
//  KLMainViewController.swift
//  KLLive
//
//  Created by WKL on 2020/9/16.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Rank")
        addChildVC(storyName: "Discover")
        addChildVC(storyName: "Mine")

        
        
    }
    
 
    
    func addChildVC( storyName : String)  {
         
        guard let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController() else { return  }
        
        addChild(childVC)
    }
}
