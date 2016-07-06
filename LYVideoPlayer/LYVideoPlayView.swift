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

    
     override class func layerClass() -> AnyClass {
    
        return AVPlayer.self
    
    }
    
    init(play:AVPlayer) {
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[videoPlayView]-|", options: .AlignAllLeft, metrics: nil, views: ["videoPlayView" : self]))
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[videoPlayView]-|", options: .AlignAllLeft, metrics: nil, views: ["videoPlayView" : self]))
        

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
