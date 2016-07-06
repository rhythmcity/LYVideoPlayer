//
//  TransPortProtocol.swift
//  LYVideoPlayer
//
//  Created by 李言 on 16/7/6.
//  Copyright © 2016年 李言. All rights reserved.
//

import Foundation

@objc protocol TransPortDelegate:NSObjectProtocol {
    func play()     -> Void
    func pause()    -> Void
    func stop()     -> Void
    func scrubbingDidStart() -> Void
    func scrubbingToTime(time:NSTimeInterval) ->Void
    func scrubbingDidEnd() -> Void
    func jumpToTime(time:NSTimeInterval) ->Void
}

protocol TransPort:NSObjectProtocol  {
    weak var delegate:TransPortDelegate?{ set get }
    func setTitle(title:String) -> Void
    func setCurrentTime(time:NSTimeInterval, duration:NSTimeInterval) -> Void
    func setScrubbingTime(time:NSTimeInterval) -> Void
    func playbackComplete() -> Void
    func setSubtitle(titles:Array<String>) -> Void
}