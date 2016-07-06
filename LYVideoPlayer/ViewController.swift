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
        let videoPlayControl = LYVideoPlayerControl.init(url: NSURL.init(fileURLWithPath: "dddd"))
        self.view.addSubview(videoPlayControl.view!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

