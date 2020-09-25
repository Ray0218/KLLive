//
//  KLHomeViewModel.swift
//  KLLive
//
//  Created by WKL on 2020/9/17.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLHomeViewModel {
    
    
    var rModelsArray : [KLAnchorModel] = [KLAnchorModel]()
    
    var rTotalCount  :  Int = 0

    
    func loadHomeData(type : Int, index : Int,  finishedCallback : @escaping () -> ()) {
        
        
       
        KLNetWorkTools.requestData(type: .GET, URLString: "http://qf.56.com/home/v5/moreAnchor.ios",parameters: ["type" : type , "index" : index, "size" : 48]) { (result ) in
            
            
            guard let resultDict = result as? [String : Any] else { return }
            guard let messageDict = resultDict["message"] as? [String : Any] else { return }
            guard let dataArray = messageDict["anchors"] as? [[String : Any]] else { return }
            
            self.rTotalCount = messageDict["total"] as! Int
            
        
            
            let decoder = JSONDecoder()
            let modes = try! decoder.decode(Array<KLAnchorModel>.self, from: JSONSerialization.data(withJSONObject: dataArray, options: []))

            
//            for (index, model) in modes.enumerated() {
//                 model.isEvenIndex = index % 2 == 0
//             }
            
            
            
            self.rModelsArray.append(contentsOf: modes)
            if modes.count < 48 {
                self.rTotalCount = self.rModelsArray.count
            }
            
            
            print(modes.count)
            finishedCallback()
        }
        
        
       
    }
    
    
}
