//
//  KLRoomViewController.swift
//  KLLive
//
//  Created by WKL on 2020/9/18.
//  Copyright © 2020 ray. All rights reserved.
//

import UIKit

private let kGiftlistViewHeight : CGFloat = kScreenH * 0.5


class KLRoomViewController: KLBaseViewController {
    @IBOutlet weak var rBgImageView: UIImageView!
    
    var rAnchorModel : KLAnchorModel? {
        didSet {
            
            self.loadData()
            
            
        }
    }
    lazy var rVModel : KLRoomViewModel  = KLRoomViewModel()
    
    lazy var rGiftModel : KLGiftViewModel = KLGiftViewModel()
    
    var player : IJKFFMoviePlayerController?
    
    lazy var rGiftView : KLGiftListView = KLGiftListView.loadFromNib(nibName: "GiftListView")
    
    //        {
    //
    //        let view = Bundle.main.loadNibNamed("GiftListView", owner: nil, options:nil)?.first
    //
    //        return view as! KLGiftListView
    //    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = "房间"
        navigationController?.navigationBar.isTranslucent = false
        
        setupUI()
        
        self.rBgImageView.setImage(with: rAnchorModel?.pic51)
        
        
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        //        player?.stop()
        player?.shutdown()
    }
    
    
    deinit {
        
        
        print("######  释放了 #######")
    }
    
    @IBAction func pvt_bottomClick(_ sender: UIButton) {
        
        
        print(sender.tag)
        
        if (sender.tag == 2){
            UIView.animate(withDuration: 0.25, animations: {
                self.rGiftView.frame.origin.y = kScreenH - kGiftlistViewHeight
            })
        }
        if(sender.tag == 4){
            
            createAnimation(point:CGPoint(x: sender.frame.midX, y: sender.superview?.frame.midY ?? 0.0), parentLayer: view.layer)
            
        }
        
    }
    
}
extension KLRoomViewController  {
    
    
    func setupUI ()  {
        
        buildBlurView()
        
        
        rGiftView.frame = CGRect(x: 0, y: view.bounds.height, width: view.bounds.width, height: kGiftlistViewHeight)
        rGiftView.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        view.addSubview(self.rGiftView)
        
    }
    
    
    func buildBlurView ()  {
        
        let effect = UIBlurEffect(style: .dark)
        
        let blurView = UIVisualEffectView(effect: effect)
        
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.frame = rBgImageView.bounds
        rBgImageView.addSubview(blurView)
        
    }
    
    
}
extension KLRoomViewController  {
    
    func loadData ()   {
        
        if let roomid = rAnchorModel?.roomid, let uid = rAnchorModel?.uid {
            print(roomid, uid)
            rVModel.loadLiveURL(roomid: roomid, userId: uid, complete: {
                self.setupDisplayView()
                
                print("dddd")
            })
        }
        
        
        
    }
    
    
    fileprivate func setupDisplayView() {
        // 0.关闭log
        IJKFFMoviePlayerController.setLogReport(false)
        
        
        
        let options = IJKFFOptions.byDefault()
        //打开硬解码
        options?.setOptionIntValue(1, forKey: "videotoolbox", of: kIJKFFOptionCategoryPlayer)
        
        // 1.初始化播放器
        let url = URL(string: rVModel.liveURL)
        player = IJKFFMoviePlayerController(contentURL: url, with: options)
        
        
        
        // 2.设置播放器View的位置和尺寸
        if rAnchorModel?.push == 1 {
            player?.view.frame = CGRect(x: 0, y: 150, width: kScreenW, height: kScreenW * 3 / 4)
        } else {
            player?.view.frame = view.bounds
        }
        
        // 3.将view添加到控制器的view中
        rBgImageView.insertSubview(player!.view, at: 1)
        
        
        // 4.准备播放
        DispatchQueue.global().async {
            self.player?.prepareToPlay()
            self.player?.play()
        }
    }
    
}


extension KLRoomViewController : KLEmitterAnimation {
     
    
    
}


extension KLRoomViewController {
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //          chatToolsView.inputTextField.resignFirstResponder()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.rGiftView.frame.origin.y = kScreenH
        })
        
    }
}
