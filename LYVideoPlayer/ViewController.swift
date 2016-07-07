//
//  ViewController.swift
//  LYVideoPlayer
//
//  Created by 李言 on 16/7/6.
//  Copyright © 2016年 李言. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let playView:UIView = UIView.init()
        self.view.addSubview(playView)
        playView.backgroundColor = UIColor.blackColor()
        playView.snp_makeConstraints { (make) in
            make.left.top.right.equalTo(self.view)
            make.height.equalTo(playView.snp_width).multipliedBy(9.0 / 16.0)
        }
        
        let localURL =  NSBundle.mainBundle().URLForResource("hubblecast", withExtension: "m4v")
        
        
        
        let videoPlayControl = LYVideoPlayerControl.init(url: localURL!)
        playView.addSubview(videoPlayControl.view!)
        
        videoPlayControl.view?.snp_makeConstraints(closure: { (make) in
            make.edges.equalTo(playView)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

