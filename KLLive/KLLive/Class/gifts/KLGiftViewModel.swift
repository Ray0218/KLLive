//
//  KLGiftViewModel.swift
//  KLLive
//
//  Created by WKL on 2020/9/22.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

class KLGiftViewModel: NSObject {
    
    lazy var rListModels = [KLGiftPackge]()
    
    
    func loadGiftData(finish : @escaping () -> ())   {
         
        KLNetWorkTools.requestData(type: .GET, URLString: "http://qf.56.com/pay/v4/giftList.ios",parameters: ["type" : 0, "page" : 1, "rows" : 150]) { (result ) in
             
            guard let resultDict = result as? [String: Any] else {return}
            
            guard let dataDict = resultDict["message"] as? [String : Any] else { return }

            
            let decoder = JSONDecoder()

            for i in 0..<dataDict.count{
                guard let list = dataDict["type\(i+1)"] as? [String : Any] else { continue }
 
                   let packgeMode =  try! decoder.decode(KLGiftPackge.self, from: JSONSerialization.data(withJSONObject: list, options: []))
                
                self.rListModels.append(packgeMode)

            }
            
            self.rListModels = self.rListModels.filter({ return $0.t != 0 }).sorted(by: {$0.t > $1.t})
                       
 
            
            finish()
        }
    
    
    }

}
