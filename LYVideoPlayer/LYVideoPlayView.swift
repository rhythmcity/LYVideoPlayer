//
//  LYVideoPlayView.swift
//  LYVideoPlayer
//
//  Created by 李言 on 16/7/6.
//  Copyright © 2016年 李言. All rights reserved.
//

import UIKit
import AVFoundation
class LYVideoPlayView: UIView {

    
    var overlayView:OverlayView = {
        var view:OverlayView =  OverlayView.init(frame: CGRect.zero)
        return view
    }()
    
    
    var  transport:TransPort {
    
       return self.overlayView
    }
    
     override class func layerClass() -> AnyClass {
    
        return AVPlayerLayer.self
    
    }
    
    
    init(play:AVPlayer) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.blackColor()
        let layer:AVPlayerLayer  = self.layer as! AVPlayerLayer
        layer.player = play
    
        self.addSubview(self.overlayView)
        self.overlayView.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
      


    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
