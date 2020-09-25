//
//  KLRoomViewModel.swift
//  KLLive
//
//  Created by WKL on 2020/9/18.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit
import IJKMediaFramework
  

class KLRoomViewModel: NSObject {
    lazy var liveURL : String = ""

}


extension KLRoomViewModel {
    
    
    func loadLiveURL( roomid : String ,userId : String  , complete: @escaping () -> ())  {
        
        let URLString = "http://qf.56.com/play/v7/preLoading.ios"
        let parameters : [String : Any] = ["imei" : "36301BB0-8BBA-48B0-91F5-33F1517FA056",
                                           "roomId" : roomid,
                                           "signature" : "f69f4d7d2feb3840f9294179cbcb913f",
                                           "userId" : userId]
        
        
        KLNetWorkTools.requestData(type: .GET, URLString: URLString,parameters: parameters) { (result ) in
             
            
            // 1.获取结果字典
                       guard let resultDict = result as? [String : Any] else { return }
                       
                       // 2.获取信息
                       guard let msgDict = resultDict["message"] as? [String : Any] else { return }
                       
                       // 3.获取直播的请求地址
                       guard let requestURL = msgDict["rUrl"] as? String else { return }
            
            // 4.请求直播地址
                      self.loadOnliveURL(requestURL, complete)
            
        }
        
        
         
    }
    
    
    fileprivate func loadOnliveURL(_ URLString : String, _ complection : @escaping () -> ()) {
      
        KLNetWorkTools.requestData(type: .GET, URLString: URLString, finishedCallBack: {   result in
               // 1.获取结果字典
               guard let resultDict = result as? [String : Any] else { return }
               
               // 2.获取地址
               guard let liveURL = resultDict["url"] as? String else { return }
               
               // 3.保存地址
               self.liveURL = liveURL
               
            print(liveURL)
               // 4.回调出去
               complection()
           })
       }
    
}
