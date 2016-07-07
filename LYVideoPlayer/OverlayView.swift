//
//  OverlayView.swift
//  LYVideoPlayer
//
//  Created by 李言 on 16/7/7.
//  Copyright © 2016年 李言. All rights reserved.
//

import UIKit
import SnapKit
class OverlayView: UIView,TransPort {
    
    weak var delegate:TransPortDelegate?
    
    private lazy var scrubberSlider:UISlider =  {
        var  slider  = UISlider.init()
        return slider
    }()
    
    private lazy var currentTimeLabel:UILabel = {
        var label = UILabel.init()
        label.backgroundColor = UIColor.blueColor()
        return label
    }()
    
    private lazy var infoView:UIView = {
        var view = UIView.init()
        return view
    }()
    
    
    private lazy var scrubbingTimeLabel:UILabel = {
        var label = UILabel.init()
        return label
    }()
    
    private lazy var bottomBarView:UIView = {
        var view = UIView.init()
        view.backgroundColor = UIColor.yellowColor()
        return view
    }()
    
    private lazy var remainingTimeLabel:UILabel = {
       var label = UILabel()
        label.backgroundColor = UIColor.brownColor()
       return label
    }()
    
    private lazy var playBackButton:UIButton = {
        var button = UIButton.init(type: .Custom)
        button.backgroundColor = UIColor.redColor()
        return button
    
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.creatUI()
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle(title:String) -> Void {
    
    }
    func setCurrentTime(time:NSTimeInterval, duration:NSTimeInterval) -> Void {
        let currentSeconds = ceilf(Float(time));
        let remainingTime = duration - time;
        self.currentTimeLabel.text = self.formatSeconds(Int(currentSeconds))
        self.remainingTimeLabel.text = self.formatSeconds(Int(remainingTime))
        self.scrubberSlider.minimumValue = 0.0
        self.scrubberSlider.maximumValue = Float(duration)
        self.scrubberSlider.value = Float(time)
    }
    func setScrubbingTime(time:NSTimeInterval) -> Void {
    }
    func playbackComplete() -> Void {
    }
    func setSubtitle(titles:Array<String>) -> Void {
    }
    
    

}

private extension OverlayView {
    
    func creatUI() -> Void  {
        
        self.addSubview(self.bottomBarView)
        bottomBarView.addSubview(scrubberSlider)
        bottomBarView.addSubview(currentTimeLabel)
        bottomBarView.addSubview(remainingTimeLabel)
        bottomBarView.addSubview(playBackButton)
        
        self.bottomBarView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.bottom.equalTo(self)
            make.height.equalTo(60)
        }
        
      
        
        playBackButton.snp_makeConstraints { (make) in
            make.left.equalTo(bottomBarView)
            make.height.equalTo(bottomBarView)
            make.width.equalTo(60)
            make.centerY.equalTo(bottomBarView)
        }
        currentTimeLabel.snp_makeConstraints { (make) in
            make.left.equalTo(playBackButton.snp_right)
            make.centerY.equalTo(bottomBarView)
            make.width.equalTo(60)
            make.height.equalTo(bottomBarView)
        }
//
        scrubberSlider.snp_makeConstraints { (make) in
            make.centerY.equalTo(bottomBarView)
            make.left.equalTo(currentTimeLabel.snp_right).offset(10)
            make.right.equalTo(remainingTimeLabel.snp_left).offset(-10)
            make.height.equalTo(bottomBarView)
        }
        
        remainingTimeLabel.snp_makeConstraints { (make) in
            make.centerY.equalTo(bottomBarView)
            make.left.equalTo(scrubberSlider.snp_right).offset(10)
            make.height.equalTo(bottomBarView)
            make.right.equalTo(bottomBarView)
            make.width.equalTo(60)
        }
        
        

        
    }
    
    func formatSeconds(value:Int) -> String {
        let  seconds = value % 60;
        let  minutes = value / 60;
        return   String( String(minutes) + ":" +   String(seconds))
    }

    

}

